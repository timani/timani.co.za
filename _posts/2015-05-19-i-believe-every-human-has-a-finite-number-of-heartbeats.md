---
layout: post
title: "Lessons learned from presenting at my Drupalcon LA 2015"
---

##### Summary

Want to create a simple to use and beautiful blog with <a href="http://ghost.org/">Ghost</a>? Thanks to DigitalOcean's one-click "application" installation, you can create a droplet with Ghost pre-installed, running and ready to go in just a few short minutes!

##### Introduction

Want to create a simple to use and beautiful blog with <a href="http://ghost.org/">Ghost</a>? Thanks to DigitalOcean's one-click "application" installation, you can create a droplet with Ghost pre-installed, running and ready to go in just a few short minutes!

The instructions below will take you from zero to blog, but they do assume that you already have an account with DigitalOcean. If you haven't, then head on over to the <a href="https://www.digitalocean.com/registrations/new">sign up page</a>.

###### Step 1: Create a Ghost Droplet

In your DigitalOcean control panel, press the <a href="https://www.digitalocean.com/droplets/new">Create Droplet</a> button, to be taken to the creation screen.

<strong>Droplet Hostname:</strong> You'll first be asked for a "hostname" - this is the name of your Droplet so you can identify it if you have a few. The name should not contain any spaces or special characters.

strong>Select Size:</strong> There are 6 size options, but the smallest <strong>512MB</strong> should be plenty for the majority of blogs. If you run out of resources, you can always upgrade later.

<strong>Select Region:</strong> Choose the region closest to you, or to your target audience.

<strong>Select Image:</strong> This is the important part! Under 'Select Image' choose 'Applications' and then select 'Ghost on Ubuntu 12.04'.

<img src="https://dl.dropboxusercontent.com/u/531857/ghost/do/select-image.png" alt="Ghost">

You're nearly there! Hit the big green 'Create Droplet' button, and a new Droplet will be created for you, with all of the things you need to run Ghost - such as Node.js, nginx and including Ghost itself - already configured and setup.

<img src="https://assets.digitalocean.com/articles/ghost/creating-droplet.png" alt="Creating a new droplet">

Once your Droplet is ready, you'll see a screen like this one:

    <img src="https://assets.digitalocean.com/articles/ghost/droplet-ready.png" alt="Droplet ready">

If you open the IP address - which is <code>162.243.43.52</code> in the example above - in your favourite browser, you'll see your new Ghost blog is already up and running!

###### Step 2: Setting up a domain name</h4>

You now have your very own Ghost blog, but accessing it via an IP address probably isn't what you want. There are 3 steps to setting up a custom domain.

<ol>
    <li>
        Change the nginx configuration to match your domain name.</p>

        In your control panel, select your droplet, and choose 'access', then press the 'Console Access' button. Once your console loads you'll need to log in. You should have received an email from DigitalOcean with the login details for your new droplet.

        <p>Type <code>nano /etc/nginx/sites-available/ghost</code> to open the nginx config file for editing in the <strong>nano</strong> editor. Change the current <code>server_name</code> from <code>my-ghost-blog.com</code> to your domain name.</p>

        <img src="https://assets.digitalocean.com/articles/ghost/nginx-config.png" alt="nginx config">

        <strong>Note on using nano:</strong> Use the arrow keys to move the cursor around not the mouse. When you're finished, press <kbd>ctrl</kbd> + <kbd>x</kbd>  to exit. Nano will ask you if you want to save, type <kbd>y</kbd> for yes, and press <kbd>enter</kbd> to save the file.
    </li>
    <li>
        <p class="step">Edit the Ghost configuration file</p>
        <p>Still in the control panel, enter <code>nano /var/www/ghost/config.js</code> to open the Ghost configuration file for editing.</p>
        <p>The Ghost <code>config.js</code> file contains configuration for different environments, your Droplet is automatically configured to run in production mode. Production mode comes second in the configuration file, after development mode. Move down the file until you find the production url setting, and change this to your domain name.</p>
        <p><img src="https://assets.digitalocean.com/articles/ghost/ghost-config.png" alt="Ghost config"></p>
        <p>There are several other options in this file which can be configured, see the <a href="http://docs.ghost.org/usage/">Ghost usage documentation</a> for more information.</p>
    </li>
    <li>
        <p class="step">You'll need to follow <a href="https://www.digitalocean.com/community/articles/how-to-set-up-a-host-name-with-digitalocean">DigitalOcean's instructions</a> on how to point your domain name at your server.</p>
    </li>
</ol>

<div name="step-3-get-blogging" data-unique="step-3-get-blogging"></div><h4>Step 3: Get Blogging</h4>

<p>Browse to your newly configured blog, and then change the url to <code>your-url/ghost</code>. You'll see the Ghost sign up screen. Enter your details to create your admin user account. You'll be automatically logged in when you're done.</p>

<p><img src="https://assets.digitalocean.com/articles/ghost/ghost-signup.png" alt="Ghost signup"></p>

<p>Once you've logged in, you'll be taken to the Ghost content screen. You'll see a welcome blog post, and a green <kbd>+</kbd> button. Press that button to get started writing your first blog post in Ghost.</p>

<div name="maintaining-your-blog" data-unique="maintaining-your-blog"></div><h4>Maintaining your blog</h4>

<p>You now have a fully working Ghost blog. Your Ghost Droplet is setup to make it as easy as possible to look after your blog in the long term.</p>

<h4>Starting and stopping Ghost</h4>

<p>Under certain situations, such as installing themes or upgrading, you may need to start, stop, or restart your Ghost blog. You can do this by using the <code>start</code>, <code>stop</code> and <code>restart</code> commands provided by the Ghost service. For example, after installing a theme, you can restart Ghost by typing <code>service ghost restart</code>. To see the current status of your Ghost blog just type <code>service ghost status</code>.</p>

<h4>Upgrading Ghost (<i>updated as of Ghost 0.4</i>)</h4>

<ul>
    <li>First you'll need to find out the URL of the latest Ghost version. It should be something like <code>http://ghost.org/zip/ghost-latest.zip</code>.</li>
    <li>Once you've got the URL for the latest version, in your Droplet console type <code>cd /var/www/</code> to change directory to where the Ghost codebase lives.</li>
    <li>Next, type <code>wget http://ghost.org/zip/ghost-latest.zip</code></li>
    <li>Remove the old core directory by typing <code>rm -rf ghost/core</code>
    </li><li>Unzip the archive with <code>unzip -uo ghost-latest.zip -d ghost</code></li>
    <li>Make sure all of the files have the right permissions with <code>chown -R ghost:ghost ghost/*</code></li>
    <li>Change into your Ghost directory with <code>cd ghost</code>, then run <code>npm install --production</code> to get any new dependencies</li>
    <li>Finally, restart Ghost so that the changes take effect using <code>service ghost restart</code></li>
</ul>

<div name="conclusion" data-unique="conclusion"></div><h4>Conclusion</h4>

<p>DigitalOcean's one-click application feature (and the image created by <a href="https://github.com/sebgie/">Sebastian Gierlinger</a>) makes it incredibly easy to get started blogging with Ghost.</p>

<p>This article details 3 steps, but Ghost is running and ready for you to add blog posts by the end of the first, head over to the <a href="http://docs.ghost.org">Ghost Guide</a> for more information on how to get the most out of Ghost.</p>

<p>We hope you enjoy blogging with Ghost, and continue to find maintaining your Ghost installation on DigitalOcean straightforward!</p>
</div>
