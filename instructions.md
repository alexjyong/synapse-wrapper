<h1>Welcome To Synapse!</h1>
<p>Synapse is your personal gateway to the <a href="https://matrix.org/" target="_blank">Matrix</a> federation. With
  it, you can communicate with anyone, anywhere, without restriction, without permission, independently, and in total,
  trustless privacy.</p>
<p style="color: red;">Warning! Synapse is an incredibly powerful and complex piece of software. Please read these
  instructions carefully. If you
  find yourself in trouble, the best thing to do is stop clicking and contact support.</p>

<br />
<h2><u>Instructions</u></h2>

<h3>Step 1: Connecting to Your Synapse Server</h3>
<p>In order to use your new Synapse server, you will need to select a client app. Currently, the only client we
  recommend is
  <a href="https://element.io" target="_blank">Element</a>, which offers native apps for various platforms.
</p>
<ul>
  <li>
    <h4>Web</h4>
    <ol>
      <p><i>Note: Element Web is <b>not</b> mobile responsive, meaning it does not adapt well to smaller screen sizes.
          You should only use it from desktop/laptop browsers, not from your mobile device.</i></p>
      <li>Visit <a href="https://app.element.io" target="_blank">https://app.element.io</a> <i>from a Tor-enabled
          browser</i> (Tor Browser or Firefox, but <b>not</b> Brave).</li>
      <li>Click <code>Sign In</code> or <code>Create Account</code>, depending on whether or not you have already
        created your account.</li>
      <li>Beneath "Host Account On" (following Create Account), or "Homeserver" (following Sign In), click <code>Edit</code> and change "matrix.org" to
        <code>http://your_synapse_address_from_interfaces.onion</code></li>
      <li>Complete sign in or account creation.</li>
    </ol>
  </li>
  <li>
    <h4>macOS</h4>
    <ol>
      <li>Configure your macOS device to run Tor following these <a
          href="https://start9.com/latest/user-manual/connecting/connecting-tor/tor-os/tor-mac">instructions</a>.</li>
      <li>Download the <a href="https://element.io/get-started" target="_blank">Element app for macOS</a>. You can also check out <a href="https://www.schildi.chat/" target="_blank">SchildiChat</a></li>
      <p><i>Note: your mac will likely block opening this app for security purposes. You may need to grant special
          permission inside System Preferences --> Security and Privacy. It is perfectly fine to open this app. You
          downloaded it from your own Embassy!</i></p>
      <li>Click <code>Sign In</code> or <code>Create Account</code>, depending on whether or not you have already
        created your account.</li>
      <li>Beneath "Host Account On" (following Create Account), or "Homeserver" (following Sign In), click <code>Edit</code> and change "matrix.org" to
        <code>http://your_synapse_address_from_interfaces.onion</code></li>
      <li>Complete sign in or account creation.</li>
    </ol>
  </li>
  <li>
    <h4>Linux</h4>
    <ol>
      <li>Configure your Linux device to run Tor following these <a
          href="https://start9.com/latest/user-manual/connecting/connecting-tor/tor-os/tor-linux">instructions</a>.</li>
      <li>Download the <a href="https://element.io/get-started" target="_blank">Element app for Linux</a>.</li>
      <li>Because the Element app is not Tor-enabled by default, you must launch it from the command line using the
        following command: <code>element-desktop --proxy-server=socks5://127.0.0.1:9050</code></li>
      <li>Click <code>Sign In</code> or <code>Create Account</code>, depending on whether or not you have already
        created your account.</li>
      <li>Beneath "Host Account On" (following Create Account), or "Homeserver" (following Sign In), click <code>Edit</code> and change "matrix.org" to
        <code>http://your_synapse_address_from_interfaces.onion</code></li>
      <li>Complete sign in or account creation.</li>
    </ol>
  </li>
  <li>
    <h4>Windows</h4>
    <ol>
      <li>Configure your Windows device to run Tor following these <a
          href="https://start9.com/latest/user-manual/connecting/connecting-tor/tor-os/tor-windows">instructions</a>.</li>
      <li>Download the <a href="https://element.io/get-started" target="_blank">Element app for Windows</a>.</li>
      <li>Right click on the Element app or app shortcut.</li>
      <li>Click "Properties".</li>
      <li>On the "Shortcut" tab, add <code>--proxy-server=socks5://127.0.0.1:9050</code> to the end of the "Target"
        field. Please note, there must be a space between <code>...Element.exe</code> and <code>--proxy...</code>
      </li>
      <li>Click <code>Sign In</code> or <code>Create Account</code>, depending on whether or not you have already
        created your account.</li>
      <li>Beneath "Host Account On" (following Create Account), or "Homeserver" (following Sign In), click <code>Edit</code> and change "matrix.org" to
        <code>http://your_synapse_address_from_interfaces.onion</code></li>
      <li>Complete sign in or account creation.</li>
    </ol>
  </li>
  <li>
    <h4>Android</h4>
    <ol>
      <li>Configure your Android device to run Tor following these <a
          href="https://start9.com/latest/user-manual/connecting/connecting-tor/tor-os/tor-android">instructions</a>.</li>
      <li>Download the <a href="https://element.io/get-started" target="_blank">Element app for Android</a>.</li>
      <li>Add Element to the list of VPN apps inside Orbot.</li>
      <li>In the Element app, you will be asked to "Select a Server."  Choose "Other," and enter <code>http://your_synapse_address_from_interfaces.onion</code></li>
      <li>Complete sign in or account creation.  If you are asked to 'Trust' a certificate, go ahead and do so.  This is safe to do as you are the server operator and traffic is already over Tor.</li>
    </ol>
  </li>
  <li>
    <h4>iOS</h4>
    <ol>
      <li>Configure your iOS device to run Tor following these <a
          href="https://start9.com/latest/user-manual/connecting/connecting-tor/tor-os/tor-ios">instructions</a>.</li>
      <li>Download the <a href="https://element.io/get-started" target="_blank">Element app for iOS</a>.</li>
      <li>In the Element app, you will be asked to "Select a Server."  Choose "Other," and enter <code>http://your_synapse_address_from_interfaces.onion</code></li>
      <li>Complete sign in or account creation.  If you are asked to 'Trust' a certificate, go ahead and do so.  This is safe to do as you are the server operator and traffic is already over Tor.</li>
    </ol>
  </li>
</ul>

<br />
<hr style="border: 1px dashed #bbb;" />
<br />

<h3>Step 2: Enable Cross Signing</h3>
<ol>
  <li>Go to Settings --> Security & Privacy --> Cross-signing.</li>
  <li>If you see a green checkmark with <code>Cross-signing is ready for use</code>, then you are good to go.</li>
  <li>If you see <code>Cross-signing has not been set up</code>, then click <code>Set Up</code>, then follow the
    instructions to complete setup.</li>
  <li>Alternatively, if you see <code>Cross-signing is ready but keys are not backed up</code>, follow the backup instructions in Step 4</li>
</ol>
<p>Explanation: The Matrix protocol uses advanced cryptography to ensure that you are, in fact, communicating with the
  people you think you are,
  and not impostors. To make this as simple as possible, Matrix offers something called Cross Signing, which allows
  users to verify each other, and then for each user to verify their own various devices. The alternative is that
  every user would need to verify every
  device of everyone they interact with, which is simply annoying. You can read more about Cross Signing 
  <a href="https://element.io/blog/e2e-encryption-by-default-cross-signing-is-here/" target="_blank">here</a>.
</p>

<br />
<hr style="border: 1px dashed #bbb;" />
<br />

<h3>Step 3: Joining a Room</h3>
<ol>
  <li>On the main dashboard, select <code>Explore Public Rooms</code>.</li>
  <li>In the search field, paste in the alias of the room you want to join. Room aliases start with #. For example,
    Start9's Tor Party room
    is <a href="https://matrix.to/#/#tor-party:matrix.privacy34kn4ez3y3nijweec6w4g54i3g54sdv7r5mr6soma3w4begyd.onion"
      target="_blank">#tor-party:matrix.privacy34kn4ez3y3nijweec6w4g54i3g54sdv7r5mr6soma3w4begyd.onion</a>, then click
    <code>&#8626; Join</code>.</li>
  <li>Joining a room can take a while, depending on how many users are currently in the room. If it fails, simply try
    again.</li>
</ol>

<br />
<hr style="border: 1px dashed #bbb;" />
<br />

<h3>Step 4: Creating Backups - <span style="color: red;">Important, Read Carefully!</span></h3>
<p><u>Encryption Keys</u>: Matrix uses end-to-end (E2E) encryption, meaning all encryption/decryption is performed
  locally on your phone/computer using keys stored on the device. To further complicate things, these keys are
  frequently changed to ensure maximum security. And to even further complicate things, when you log out of
  Element, these keys are purged from memory. Meaning, if you log out of all your Element client apps, you will
  lose your keys and be unable to decrypt your own message history!</p>
<p><u>Message History</u>: Additionally, your entire (encrypted) message history is stored on your personal
  Synapse server, which is running on your physical Embassy device. So there are two, separate types of backups
  that are needed: (1) the encryption keys on your device and (2) the message history on your Embassy.</p>
<ul>
  <li>
    <h4>Backing up encryption keys</h4>
    <p>There are two methods of backing up encryption keys: Manual and Automatic</p>
    <ul>
      <li>
        <h5>Manual</h5>
        <p>Because your encryption keys are rotated frequently, it is almost impossible to perform manual backups
          and guarantee that all messages can be recovered. However, performing periodic backups can at least
          ensure the recovery of messages up until that point in time.</p>
        <ol>
          <li>
            In your Element app, go to Settings --> Security & Privacy --> Cryptography --> "Export
            E2E room keys"
          </li>
          <li>
            Optionally enter a passphrase to protect the backup and save the file somewhere safe
          </li>
          <li>
            Remember, the keys involved in this backup will only be capable of decrypting messages up until the
            time of backup. New messages will likely be unrecoverable
          </li>
        </ol>
      </li>
      <li>
        <h5>Automatic</h5>
        <p>This option will <i>automatically</i> store encrypted backups of your keys on your Embassy whenever they
          are rotated
          and is the recommended way of doing key backup</p>
        <ol>
          <li>
            In your Element app, go to Settings --> Security & Privacy --> Secure Backup --> "Set up".
          </li>
          <li>
            You will be prompted to select either <code>Generate a Security Key</code> or
            <code>Enter a Security Phrase</code>.
            This is a misleading choice. Either way, Element will generate a security key.
            If you select <code>Generate a Security Key</code> (recommended), Element will display the Security Key
            for you to store on your own.
            If you select <code>Enter a Security Phrase</code>, Element will encrypt the Security Key with your
            Security Phrase,
            then store it on your Embassy. In the former case, you will need to keep and protect a private key.
            In the latter case, you will need to keep and protect a chosen passphrase. Either way, you will need to
            store something.
            The reason it is recommended to select <code>Generate a Security Key</code> is because, if someone gets
            access to your Synapse server,
            it is <i>far</i> more likely they will guess your chosen passphrase than be able to brute force a private
            key.
          </li>
          <li>
            Regardless of which option you choose, you must store the value somewhere safe. <b>Do not lose
              it!</b>. It is recommended to store it in your self-hosted Bitwarden.
          </li>
        </ol>
      </li>
    </ul>
  </li>
  <li>
    <h4>Backing up message history</h4>
    <p>All your (encrypted) messages are stored on your physical Embassy device. Therefore, it is critical to
      create frequent backups of Synapse on your Embassy.</p>
  </li>
</ul>
