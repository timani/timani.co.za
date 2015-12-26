---
layout: post
title: Adding PHP libraries to the sculpin docker image - Part 2 of 4
Categories: Docker, TDD
Next: 2015/08/12/publishing-a-docker-image-and-automating-tests-with-circleci/
Prev: 2015/08/13/a-tdd-approach-to-creating-a-minimal-sculpin-docker-image-with-serverspec/
---
We most frequently use Curl in the form of `libcurl`, a C library providing function transferring data between servers using many of the popular protocols like HTTP, FTP, SCP, and so on. This library is the foundation things like all the curl_*() functions in PHP, which are useful for writing code that interacts with various web services.

<!--more-->

##### Summary

This is sample project for Test Driven Development (TDD) of Dockerfile by RSpec. This means developing dockerfile by below cycle.

###### Table of contents

  * [Overview](#gh-md-toc)
    * [Status and Content](#local-files)
  * [Requirements](#installation)
    * [Before you begin](#local-files)
  * [Getting started](#table-of-contents)
    * [Defining Requirements](#local-files)
  * [Tesk Kitchen](#usage)
    * [Kitchen List](#local-files)
    * [Kitchen Converge](#local-files)
    * [Kichen Verify](#multiple-files)
    * [Kitchen Test](#combo)
  * [Build Docker image](#tests)
    * [Kitchen List](#local-files)
    * [Kitchen Converge](#local-files)
    * [Kichen Verify](#multiple-files)
    * [Kitchen Test](#combo)
  * [Conclusion](#dependency)

##### Overview

Allow your teams to use their favorite Agile lifecycle tools while maintaining full visibility and control.
Requirements

- Test Driven Development for containers with serverspec

##### Getting started  

- what this section is about
- why it matters
Defining requirements

- research or examples

Here you can search for any topic that interests you, find information, images, quotes, citations and more, and then quickly insert them into your document.

<table class="mdl-data-table mdl-js-data-table" width="100%">
  <thead>
    <tr>
      <th class="mdl-data-table__cell--non-numeric" >Component</th>
      <th class="mdl-data-table__cell--non-numeric" >Description</th>
      <th class="mdl-data-table__cell--non-numeric" >Type</th>
      <th class="mdl-data-table__cell--non-numeric" >Condition</th>
      <th class="mdl-data-table__cell--non-numeric" >Criteria</th>
      <th class="mdl-data-table__cell--non-numeric" >Status</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td class="mdl-data-table__cell--non-numeric">PHP</td>
      <td class="mdl-data-table__cell--non-numeric">php-common</td>
      <td class="mdl-data-table__cell--non-numeric">file</td>
      <td class="mdl-data-table__cell--non-numeric">Should be</td>
      <td class="mdl-data-table__cell--non-numeric">a file</td>
      <td class="mdl-data-table__cell--non-numeric">****</td>
    </tr>
    <tr>
      <td class="mdl-data-table__cell--non-numeric">PHP</td>
      <td class="mdl-data-table__cell--non-numeric">php-iconv</td>
      <td class="mdl-data-table__cell--non-numeric">file</td>
      <td class="mdl-data-table__cell--non-numeric">Should be</td>
      <td class="mdl-data-table__cell--non-numeric">a file</td>
      <td class="mdl-data-table__cell--non-numeric">****</td>
    </tr>
    <tr>
      <td class="mdl-data-table__cell--non-numeric">PHP</td>
      <td class="mdl-data-table__cell--non-numeric">php-phar</td>
      <td class="mdl-data-table__cell--non-numeric">file</td>
      <td class="mdl-data-table__cell--non-numeric">Should be</td>
      <td class="mdl-data-table__cell--non-numeric">a file</td>
      <td class="mdl-data-table__cell--non-numeric">****</td>
    </tr>
    <tr>
      <td class="mdl-data-table__cell--non-numeric">PHP</td>
      <td class="mdl-data-table__cell--non-numeric">php-ctype</td>
      <td class="mdl-data-table__cell--non-numeric">file</td>
      <td class="mdl-data-table__cell--non-numeric">Should be</td>
      <td class="mdl-data-table__cell--non-numeric">a file</td>
      <td class="mdl-data-table__cell--non-numeric">****</td>
    </tr>
    <tr>
      <td class="mdl-data-table__cell--non-numeric">PHP</td>
      <td class="mdl-data-table__cell--non-numeric">php-zip</td>
      <td class="mdl-data-table__cell--non-numeric">file</td>
      <td class="mdl-data-table__cell--non-numeric">Should be</td>
      <td class="mdl-data-table__cell--non-numeric">a file</td>
      <td class="mdl-data-table__cell--non-numeric">****</td>
    </tr>
    <tr>
      <td class="mdl-data-table__cell--non-numeric">PHP</td>
      <td class="mdl-data-table__cell--non-numeric">php-json</td>
      <td class="mdl-data-table__cell--non-numeric">file</td>
      <td class="mdl-data-table__cell--non-numeric">Should be</td>
      <td class="mdl-data-table__cell--non-numeric">a file</td>
      <td class="mdl-data-table__cell--non-numeric">****</td>
    </tr>
  </tbody>
</table>


Table 1: Docker PHP requirements
- takeaways
##### Building the docker image

- what this section is about
- why it matters
- research or examples

Create a Dockerfile and add it to the repository with the following contents. This will install ruby as well as bundler so we can add the gems for bootstrap and start working on the theme:

<pre><code class="language-docker">FROM centos:7
MAINTAINER timani tunduwani

# Install Remi Collet's repo for CentOS 7
RUN yum -y install \
  http://rpms.famillecollet.com/enterprise/remi-release-7.rpm

# Install PHP and Percona (MySQL) client stuff and the latest stable PHP.
RUN yum -y install --enablerepo=remi,remi-php56 \
  httpd php php-gd php-xml php-zip pwgen psmisc tar git zip

RUN yum -y update && yum clean all

# Add Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
# Install Sculpin
RUN curl -O https://download.sculpin.io/sculpin.phar; chmod +x sculpin.phar; mv sculpin.phar /usr/local/bin/sculpin
# Expose the port for the sculpin server
EXPOSE 8000
# Move to the directory were the sculpin PHP files will be located
WORKDIR /var/www
COPY ./run.sh /var/www/
CMD bash /var/www/run.sh
</code></pre>

Updated project directory with the new Docker tests

<pre><code class="language-bash">├── .gitignore
├── .rspec
├── Dockerfile
├── Gemfile
├── Rakefile
└── specs/
</code></pre>

- takeaways

##### Build Docker image and run test -> `GREEN`

- what this section is about
- why it matters
- research or examples

Running the first serverspec tests
<pre><code  class="language-bash">$ rspec spec/Dockerfile_spec.rb
1 example, 3 failures
</code></pre>

Excellent, 3 success messages just as we had hoped. The reason is because our docker image has met all of the dependencies based on the requirements

- takeaways

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

###### Step 2: Start the sculpin container

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

###### Step 3: List the currently running container
<pre><code  data-language="shell">
docker ps

# Output the logs from the Sculpin container
docker logs
</code></pre>

This will allow us to read the output of STDOUT from the container so we keep track of the composer install and sculpin site generation process. When the installation process is complete, you can check out the new site.

##### Previewing the Sculpin site

- what this section is about
- why it matters
- research or examples

Next we use the docker run command to set up a container that will come bundled with PHP, Composer and sculpin ready to go.

<img src="https://www.evernote.com/shard/s389/sh/a7b0da9b-ed77-4ed2-a7fd-1a08168be31a/49be0473012d50347c8c8cec5b8ca0bd/res/432689fc-0b9b-431d-b9a5-efc8ffd78536/.jpg" width="100%" />

- takeaways

##### Create post

<img src="https://asciinema.org/a/624fjx2rx7k3pctdozw7m8b24.png" width="100%" />


##### Conclusion

Use composer to download and manage the dependencies for the project. When that is done, we can proceed to install sculpin and generate the project.

##### What's next?

Use the Research tool's dictionary to search for definitions, synonyms, and usage examples. If you don't already have the Research tool open, you can access the dictionary by clicking the Tools menu and then selecting Define.
