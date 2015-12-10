---
layout: post
title: Using minimal Sculpin docker image to developing static sites - Part 2 of 4
Categories: docker
---
We most frequently use Curl in the form of `libcurl`, a C library providing function transferring data between servers using many of the popular protocols like HTTP, FTP, SCP, and so on. This library is the foundation things like all the curl_*() functions in PHP, which are useful for writing code that interacts with various web services.

<!--more-->

### Summary

This is sample project for Test Driven Development (TDD) of Dockerfile by RSpec. This means developing dockerfile by below cycle.

<img src="https://blog.phusion.nl/wp-content/uploads/2013/11/docker.png" /> <img src="http://symfony.com/uploads/projects/sculpin.png" />

### Overview

Allow your teams to use their favorite Agile lifecycle tools while maintaining full visibility and control.
Requirements

### Getting started  

- what this section is about
- why it matters
- research or examples
- takeaways

### Installing Test kitchen

- what this section is about
- why it matters
- research or examples
  - Installing with docker
  - Installing with Vagrant
- takeaways

### Copy the skeleton sculpin project to the current directory

- what this section is about
- why it matters
- research or examples

##### Step 1: Install dependencies with bundler

<pre><code  data-language="shell">
git clone https://github.com/sculpin/sculpin-blog-skeleton.git .
</code></pre>

Now with our updated.
<pre><code  data-language="shell">
├── app
│   └── config
├── composer.json
├── Dockerfile
├── LICENSE
├── publish.sh
├── README.md
├── run.sh
├── s3.conf.dist
├── s3-publish.sh
├── sculpin.json
├── sculpin.lock
└── source
    ├── 404.html
    ├── ...
</code></pre>

##### Step 2: Start the sculpin container

Install ruby and the bundler gem so it is available within the container.
<pre><code  data-language="shell">
# Build the local docker image
docker build .

# List the available images
docker images

# Create a sculpin container
# `-v`: within the host machine within the container so sculpin can be built in
#       the container and previewed on the host machine.
# `-p`: Expose the port `8000`  within the host machine and the container.
# `timani/sculpin`: The command that will be executed when the container build
        process is complete.
# `/bin/run.sh`: The command that will be executed when the container build
        process is complete.
docker run  -v ./:/var/www/ -p 8000:8000 timani/sculpin /bash
</code></pre>

We can quickly test the new container by going to the URL that is returned. The docker logs command allows us to see output from within the STDOUT of the container.

##### Step 3: List the currently running container
<pre><code  data-language="shell">
docker ps

# Output the logs from the Sculpin container
docker logs
</code></pre>

This will allow us to read the output of STDOUT from the container so we keep track of the composer install and sculpin site generation process. When the installation process is complete, you can check out the new site.

#### Previewing the Sculpin site

- what this section is about
- why it matters
- research or examples

Next we use the docker run command to set up a container that will come bundled with PHP, Composer and sculpin ready to go.

<img src="https://www.evernote.com/shard/s389/sh/a7b0da9b-ed77-4ed2-a7fd-1a08168be31a/49be0473012d50347c8c8cec5b8ca0bd/res/432689fc-0b9b-431d-b9a5-efc8ffd78536/.jpg" width="100%" />

- takeaways

#### Create post


<img src="https://asciinema.org/a/624fjx2rx7k3pctdozw7m8b24.png" width="100%" />


#### Conclusion

Use composer to download and manage the dependencies for the project. When that is done, we can proceed to install sculpin and generate the project.

#### What's next?

Use the Research tool's dictionary to search for definitions, synonyms, and usage examples. If you don't already have the Research tool open, you can access the dictionary by clicking the Tools menu and then selecting Define.
