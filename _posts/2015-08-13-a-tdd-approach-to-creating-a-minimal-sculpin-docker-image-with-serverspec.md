---
layout: post
title: A TDD approach to creating a minimal Sculpin Docker image with Serverspec - Part 1 of 4
categories: Docker, TDD
---

We most frequently use Curl in the form of `libcurl`, a C library providing function transferring data between servers using many of the popular protocols like HTTP, FTP, SCP, and so on. This library is the foundation things like all the curl_*() functions in PHP, which are useful for writing code that interacts with various web services.

<!--more-->

##### Summary

This is sample project for Test Driven Development (TDD) of Dockerfile by RSpec. This means developing dockerfile by below cycle.

###### Table of contents

  * [Overview](#gh-md-toc)
    * [TDD](#local-files)
  * [Getting started](#table-of-contents)
    * [Defining Requirements](#local-files)
  * [Setting up Development environment](#installation)
    * [Drivers](#local-files)
    * [Provisioners](#local-files)
    * [Platforms](#multiple-files)
    * [Suites](#combo)
  * [Tesk Kitchen](#usage)
    * [Write a test](#remote-files)
    * [Writing a playbook](#stdin)
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
      <td class="mdl-data-table__cell--non-numeric">Base</td>
      <td class="mdl-data-table__cell--non-numeric">fcgi</td>
      <td class="mdl-data-table__cell--non-numeric">package</td>
      <td class="mdl-data-table__cell--non-numeric" >Should be</td>
      <td class="mdl-data-table__cell--non-numeric" >Installed</td>
      <td class="mdl-data-table__cell--non-numeric" >****</td>
    </tr>
    <tr>
      <td class="mdl-data-table__cell--non-numeric" >Base</td>
      <td class="mdl-data-table__cell--non-numeric" >git</td>
      <td class="mdl-data-table__cell--non-numeric" >package</td>
      <td class="mdl-data-table__cell--non-numeric" >Should be</td>
      <td class="mdl-data-table__cell--non-numeric" >Installed</td>
      <td class="mdl-data-table__cell--non-numeric" >****</td>
    </tr>
    <tr>
      <td class="mdl-data-table__cell--non-numeric" >Base</td>
      <td class="mdl-data-table__cell--non-numeric" >tar</td>
      <td class="mdl-data-table__cell--non-numeric" >package</td>
      <td class="mdl-data-table__cell--non-numeric" >Should be</td>
      <td class="mdl-data-table__cell--non-numeric" >Installed</td>
      <td class="mdl-data-table__cell--non-numeric" >****</td>
    </tr>
    <tr>
      <td class="mdl-data-table__cell--non-numeric" >Base</td>
      <td class="mdl-data-table__cell--non-numeric" >zip</td>
      <td class="mdl-data-table__cell--non-numeric" >package</td>
      <td class="mdl-data-table__cell--non-numeric" >Should be</td>
      <td class="mdl-data-table__cell--non-numeric" >Installed</td>
      <td class="mdl-data-table__cell--non-numeric" >****</td>
    </tr>
    <tr>
      <td class="mdl-data-table__cell--non-numeric" >Base</td>
      <td class="mdl-data-table__cell--non-numeric">Tag</td>
      <td class="mdl-data-table__cell--non-numeric" >file</td>
      <td class="mdl-data-table__cell--non-numeric" >Should be</td>
      <td class="mdl-data-table__cell--non-numeric" ><code>Alpine Linux</code></td>
      <td class="mdl-data-table__cell--non-numeric" >****</td>
    </tr>
    <tr>
      <td class="mdl-data-table__cell--non-numeric" >Base</td>
      <td class="mdl-data-table__cell--non-numeric" >composer</td>
      <td class="mdl-data-table__cell--non-numeric" >command</td>
      <td class="mdl-data-table__cell--non-numeric" >Should match</td>
      <td class="mdl-data-table__cell--non-numeric" ><code>/usr/local/bin/composer</code></td>
      <td class="mdl-data-table__cell--non-numeric" >****</td>
    </tr>
    <tr>
      <td class="mdl-data-table__cell--non-numeric" >Base</td>
      <td class="mdl-data-table__cell--non-numeric" >sculpin</td>
      <td class="mdl-data-table__cell--non-numeric" >command</td>
      <td class="mdl-data-table__cell--non-numeric" >Should match</td>
      <td class="mdl-data-table__cell--non-numeric" ><code>/usr/local/bin/sculpin</code></td>
      <td class="mdl-data-table__cell--non-numeric" >****</td>
    </tr>
  </tbody>
</table>

Table 1: Docker PHP requirements
- takeaways

##### Setup the Development environment

- what this section is about

Once we have the requirements we can proceed to setup and configure test-kitchen.

- why it matters

- research or examples

###### Step 1: Add Test Kitchen to a `Gemfile` within the project:

<pre><code  data-language="ruby">source 'https://rubygems.org'
gem 'test-kitchen', '~> 1.0'
gem 'docker'
gem 'serverspec'

group :integration do
  gem 'kitchen-docker', '~> 0.11'
end
</code></pre>

This will install `test-kitchen`, `kitchen-docker` and `kitchen-ansible` to provision and test the docker image to make sure it meets our requirements.

- `docker`: A "Test Kitchen driver" - it tells test-kitchen how to interact with an appliance (machine), such as Vagrant, EC2, Rackspace, etc.
- `serverspec`: To validate the images we will use serverspec.
- `kitchen-docker`: A "Test Kitchen driver" - it tells test-kitchen how to interact with an appliance (machine), such as Vagrant, EC2, Rackspace, etc.
- `kitchen-ansible`: A provisioner for Test Kitchen to create and manage instances.

###### Step 2: Run the `bundle` command to install

<pre><code  data-language="shell"># Install dependencies
$ bundle install
# Verify Test Kitchen is installed, run the kitchen help command:
$ bundle exec kitchen help
# You should see something like:
$ kitchen version   # Print Kitchen's version information
Test Kitchen version 1.4.2
</code></pre>

- takeaways

##### Create the `kitchen.yml`

- what this section is about

The easiest way is to map out a table of the group or section that you will want to make sure is configured correctly. For example, in our case we will be looking at the Configuration of the container to make sure ruby is installed.

<pre><code  data-language="yaml">---
driver:
  name: docker

platforms:
- name: ubuntu
  driver_config:
    image: ubuntu:14.04
    platform: ubuntu
  run_list:
  - recipe[apt]
</code></pre>

###### Step 1: Drivers

For example, in our case we will be looking at the Configuration. The easiest way is to map out a table of assignment.

<pre><code  data-language="yaml">driver:
  name: docker
</code></pre>

###### Step 2: Provisioners

Tools used to converge an environment. During convergence the Configuration is run against a set of Platforms.

<pre><code  data-language="yaml">provisioner:
  name: ansible_playbook
</code></pre>

###### Step 3: Platforms
Using the same Serverspec and RSpec tests we already use for our Ansible scripts. Thanks for the heads up and keep up the great work ;-). Operating systems

<pre><code  data-language="yaml">platforms:
- name: ubuntu
  driver_config:
    image: ubuntu:14.04
    platform: ubuntu
</code></pre>

###### Step 4: Test Suites

Using the same Serverspec and RSpec tests we already use for our Ansible scripts. Thanks for the heads up and keep up the great work ;-). Operating systems

<pre><code  data-language="yaml">
suites:
- name: default
  run_list:
  ubuntu:
</code></pre>

- why it matters
- research or examples
- takeaways


#### Initialize Serverspec and create the first outline of our tests.

##### Step 1:Initialize Serverspec within the project

<pre><code  data-language="shell">$ serverspec-init
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

##### Step 2: Create Serverpec tests

Based on the requirements we defined in the dependencies we can create the matching test suite

<pre><code  data-language="ruby"># spec/Dockerfile_spec.rb

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


- takeaways

##### Adding Vagrant Support

- what this section is about
- why it matters
- research or examples
- takeaways

https://robots.thoughtbot.com/tdd-your-dockerfiles-with-rspec-and-serverspec
