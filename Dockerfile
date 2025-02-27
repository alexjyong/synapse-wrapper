# Dockerfile to build the matrixdotorg/synapse docker images.
#
# Note that it uses features which are only available in BuildKit - see
# https://docs.docker.com/go/buildkit/ for more information.
#
# To build the image, run `docker build` command from the root of the
# synapse repository:
#
#    DOCKER_BUILDKIT=1 docker build -f docker/Dockerfile .
#
# There is an optional PYTHON_VERSION build argument which sets the
# version of python to build against: for example:
#
#    DOCKER_BUILDKIT=1 docker build -f docker/Dockerfile --build-arg PYTHON_VERSION=3.10 .
#

# Irritatingly, there is no blessed guide on how to distribute an application with its
# poetry-managed environment in a docker image. We have opted for
# `poetry export | pip install -r /dev/stdin`, but there are known bugs in
# in `poetry export` whose fixes (scheduled for poetry 1.2) have yet to be released.
# In case we get bitten by those bugs in the future, the recommendations here might
# be useful:
#     https://github.com/python-poetry/poetry/discussions/1879#discussioncomment-216865
#     https://stackoverflow.com/questions/53835198/integrating-python-poetry-with-docker?answertab=scoredesc



ARG PYTHON_VERSION=3.10

###
### Stage 0: generate requirements.txt
###
FROM docker.io/python:${PYTHON_VERSION}-slim as requirements

# RUN --mount is specific to buildkit and is documented at
# https://github.com/moby/buildkit/blob/master/frontend/dockerfile/docs/syntax.md#build-mounts-run---mount.
# Here we use it to set up a cache for apt (and below for pip), to improve
# rebuild speeds on slow connections.
RUN \
   --mount=type=cache,target=/var/cache/apt,sharing=locked \
   --mount=type=cache,target=/var/lib/apt,sharing=locked \
 apt-get update && apt-get install -y git \
    && rm -rf /var/lib/apt/lists/*

# We install poetry in its own build stage to avoid its dependencies conflicting with
# synapse's dependencies.
# We use a specific commit from poetry's master branch instead of our usual 1.1.12,
# to incorporate fixes to some bugs in `poetry export`. This commit corresponds to
#    https://github.com/python-poetry/poetry/pull/5156 and
#    https://github.com/python-poetry/poetry/issues/5141 ;
# without it, we generate a requirements.txt with incorrect environment markers,
# which causes necessary packages to be omitted when we `pip install`.
#
# NB: In poetry 1.2 `poetry export` will be moved into a plugin; we'll need to also
# pip install poetry-plugin-export (https://github.com/python-poetry/poetry-plugin-export).
RUN --mount=type=cache,target=/root/.cache/pip \
  pip install --user "poetry-core==1.1.0a7" git+https://github.com/python-poetry/poetry.git@fb13b3a676f476177f7937ffa480ee5cff9a90a5

WORKDIR /synapse

# Copy just what we need to run `poetry export`...
COPY synapse/pyproject.toml synapse/poetry.lock synapse/README.rst /synapse/

# If specified, we won't verify the hashes of dependencies.
# This is only needed if the hashes of dependencies cannot be checked for some
# reason, such as when a git repository is used directly as a dependency.
ARG TEST_ONLY_SKIP_DEP_HASH_VERIFICATION

RUN /root/.local/bin/poetry export --extras all -o /synapse/requirements.txt ${TEST_ONLY_SKIP_DEP_HASH_VERIFICATION:+--without-hashes}

###
### Stage 1: builder
###
FROM docker.io/python:${PYTHON_VERSION}-slim as builder

LABEL org.opencontainers.image.url='https://matrix.org/docs/projects/server/synapse'
LABEL org.opencontainers.image.documentation='https://github.com/matrix-org/synapse/blob/master/docker/README.md'
LABEL org.opencontainers.image.source='https://github.com/matrix-org/synapse.git'
LABEL org.opencontainers.image.licenses='Apache-2.0'

# install the OS build deps
RUN \
   --mount=type=cache,target=/var/cache/apt,sharing=locked \
   --mount=type=cache,target=/var/lib/apt,sharing=locked \
 apt-get update && apt-get install -y \
    build-essential \
    libffi-dev \
    libjpeg-dev \
    libpq-dev \
    libssl-dev \
    libwebp-dev \
    libxml++2.6-dev \
    libxslt1-dev \
    openssl \
    rustc \
    zlib1g-dev \
    git \
    && rm -rf /var/lib/apt/lists/*

# To speed up rebuilds, install all of the dependencies before we copy over
# the whole synapse project, so that this layer in the Docker cache can be
# used while you develop on the source
#
# This is aiming at installing the `[tool.poetry.depdendencies]` from pyproject.toml.
COPY --from=requirements /synapse/requirements.txt /synapse/
RUN --mount=type=cache,target=/root/.cache/pip \
  pip install --prefix="/install" --no-deps --no-warn-script-location -r /synapse/requirements.txt

# Copy over the rest of the synapse source code.
COPY synapse/synapse /synapse/synapse/
# ... and what we need to `pip install`.
# TODO: once pyproject.toml declares poetry-core as its build system, we'll need to copy
# pyproject.toml here, ditching setup.py and MANIFEST.in.
COPY synapse/pyproject.toml synapse/README.rst /synapse/

# Install the synapse package itself.
RUN pip install --prefix="/install" --no-deps --no-warn-script-location /synapse

###
### Stage 2: runtime
###

FROM docker.io/python:${PYTHON_VERSION}-slim as base-image

LABEL org.opencontainers.image.url='https://matrix.org/docs/projects/server/synapse'
LABEL org.opencontainers.image.documentation='https://github.com/matrix-org/synapse/blob/master/docker/README.md'
LABEL org.opencontainers.image.source='https://github.com/matrix-org/synapse.git'
LABEL org.opencontainers.image.licenses='Apache-2.0'

RUN \
   --mount=type=cache,target=/var/cache/apt,sharing=locked \
   --mount=type=cache,target=/var/lib/apt,sharing=locked \
  apt-get update && apt-get install -y \
    curl \
    gosu \
    libjpeg62-turbo \
    libpq5 \
    libwebp6 \
    xmlsec1 \
    libjemalloc2 \
    libssl-dev \
    openssl \
    && rm -rf /var/lib/apt/lists/*

COPY --from=builder /install /usr/local
COPY ./synapse/docker/start.py /start.py
COPY ./synapse/docker/conf /conf

EXPOSE 8008/tcp 8009/tcp 8448/tcp

ENTRYPOINT ["/start.py"]

HEALTHCHECK --start-period=5s --interval=15s --timeout=5s \
    CMD curl -fSs http://localhost:8008/health || exit 1

FROM base-image

RUN apt-get update \
    && apt-get install -y \
    tini \
    ca-certificates \
    nginx \
    curl \
    jq \
    openssl \
    privoxy \
    iproute2 \
    wget \
    sqlite3

RUN wget -O /usr/local/bin/yq https://github.com/mikefarah/yq/releases/download/v4.12.2/yq_linux_arm \
    && chmod a+x /usr/local/bin/yq
RUN pip install --prefix="/install" --no-warn-script-location pyyaml

ADD ./www /var/www
ADD ./cert.conf /etc/ssl/cert.conf
ADD ./priv-config-forward-onion /root
ADD ./priv-config-forward-all /root
ADD ./docker_entrypoint.sh /usr/local/bin/docker_entrypoint.sh
RUN chmod a+x /usr/local/bin/docker_entrypoint.sh
ADD ./check-federation.sh /usr/local/bin/check-federation.sh
RUN chmod a+x /usr/local/bin/check-federation.sh
ADD ./user-signups-off.sh /usr/local/bin/user-signups-off.sh
RUN chmod a+x /usr/local/bin/user-signups-off.sh
ADD ./configurator.py /configurator.py
RUN chmod a+x /configurator.py

WORKDIR /data

RUN mkdir /run/nginx

EXPOSE 8448 443 80

ENTRYPOINT ["/usr/local/bin/docker_entrypoint.sh"]
