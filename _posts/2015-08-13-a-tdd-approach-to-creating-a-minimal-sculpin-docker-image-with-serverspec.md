---
layout: post
title: A TDD approach to creating a minimal Sculpin Docker image with Serverspec - Part 1 of 4
---
We most frequently use Curl in the form of `libcurl`, a C library providing function transferring data between servers using many of the popular protocols like HTTP, FTP, SCP, and so on. This library is the foundation things like all the curl_*() functions in PHP, which are useful for writing code that interacts with various web services.

<!--more-->

##### Summary

This is sample project for Test Driven Development (TDD) of Dockerfile by RSpec. This means developing dockerfile by below cycle.

<img src="https://blog.phusion.nl/wp-content/uploads/2013/11/docker.png" /> <img src="http://symfony.com/uploads/projects/sculpin.png" />

##### Overview

Allow your teams to use their favorite Agile lifecycle tools while maintaining full visibility and control.
Requirements

- Test Driven Development for containers with serverspec

##### Getting started  

- what this section is about
- why it matters
- research or examples
- takeaways

### Defining requirements

- what this section is about
- why it matters
- research or examples

Here you can search for any topic that interests you, find information, images, quotes, citations and more, and then quickly insert them into your document.

<table class="mdl-data-table mdl-js-data-table" />
  <thead>
    <tr>
      <th class="mdl-data-table__cell--non-numeric" >Section</th>
      <th class="mdl-data-table__cell--non-numeric" >Description</th>
      <th class="mdl-data-table__cell--non-numeric" >Status</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td class="mdl-data-table__cell--non-numeric">Configuration</td>
      <td class="mdl-data-table__cell--non-numeric">Branch</td>
      <td class="mdl-data-table__cell--non-numeric" >Failed</td>
    </tr>
    <tr>
      <td class="mdl-data-table__cell--non-numeric" >Configuration</td>
      <td class="mdl-data-table__cell--non-numeric" >Tag</td>
      <td class="mdl-data-table__cell--non-numeric" >Failed</td>
    </tr>
    <tr>
      <td class="mdl-data-table__cell--non-numeric" >Configuration</td>
      <td class="mdl-data-table__cell--non-numeric">Tag</td>
      <td class="mdl-data-table__cell--non-numeric" >Failed</td>
    </tr>
    <tr>
      <td class="mdl-data-table__cell--non-numeric" >Configuration</td>
      <td class="mdl-data-table__cell--non-numeric" >Branch</td>
      <td class="mdl-data-table__cell--non-numeric" >Failed</td>
    </tr>
  </tbody>
</table>
Table 1:

- takeaways

##### Installing Test kitchen

- what this section is about
- why it matters
- research or examples
- takeaways

##### Write initial Serverspec tests

- what this section is about

The easiest way is to map out a table of the group or section that you will want to make sure is configured correctly. For example, in our case we will be looking at the Configuration of the container to make sure ruby is installed.

<img src="http://serverspec.org/images/logo.png" width="100%" />

- why it matters
- research or examples
- takeaways


##### Step 1: Install dependencies with bundler

In the root of the project directory add a file named Gemfile with the following:

<pre><code  data-language="shell">
$ bundle install
docker
serverspec
rspec
rake
</code></pre>

##### Step 2: Initialize Serverspec and create the first outline of our tests.

<pre><code  data-language="shell">
$ serverspec-init
Select OS type:

  1) UN*X
  2) Windows

Select number: 1

Select a backend type:

  1) SSH
  2) Exec (local)

Select number: 1

Vagrant instance y/n: n
Input target host name: www.example.jp
 + spec/
 + spec/www.example.jp/
 + spec/www.example.jp/sample_spec.rb
 + spec/spec_helper.rb
 + Rakefile
 + .rspec
</code></pre>

- takeaways

##### Step 3: Create Serverpec tests

Based on the requirements we defined in the dependencies we can create the matching test suite

<pre><code  data-language="ruby">
# spec/Dockerfile_spec.rb

require "serverspec"
require "docker"

describe "Dockerfile" do
  before(:all) do
    image = Docker::Image.build_from_dir('.')

    set :os, family: :debian
    set :backend, :docker
    set :docker_image, image.id
  end

  it "installs the right version of Ubuntu" do
    expect(os_version).to include("Ubuntu 14")
  end

  def os_version
    command("lsb_release -a").stdout
  end
end
</code></pre>

Updated project directory with the new infrastructure tests

<pre><code  data-language="shell">
├── .gitignore
├── .rspec
├── Gemfile
├── Rakefile
└── specs/
</code></pre>

### Run initial tests -> `RED`

- what this section is about
- why it matters
- research or examples

Running the first serverspec tests
<pre><code  data-language="shell">
$ rspec spec/Dockerfile_spec.rb
1 example, 3 failures
</code></pre>

Excellent, 3 failures messages just as we had hoped. The reason is because our docker image has not been created yet and does not meet the requirements.

- takeaways

##### Building the docker image

- what this section is about
- why it matters
- research or examples

Create a Dockerfile and add it to the repository with the following contents. This will install ruby as well as bundler so we can add the gems for bootstrap and start working on the theme:

<pre><code  data-language="shell">
FROM centos:7
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

<pre><code  data-language="shell">
├── .gitignore
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
<pre><code  data-language="shell">
$ rspec spec/Dockerfile_spec.rb
1 example, 3 failures
</code></pre>

Excellent, 3 success messages just as we had hoped. The reason is because our docker image has met all of the dependencies based on the requirements

<script type="text/javascript" src="https://asciinema.org/a/17516.js" id="asciicast-17516" async></script>

- takeaways

##### Adding Vagrant Support

- what this section is about
- why it matters
- research or examples
- takeaways

https://robots.thoughtbot.com/tdd-your-dockerfiles-with-rspec-and-serverspec
