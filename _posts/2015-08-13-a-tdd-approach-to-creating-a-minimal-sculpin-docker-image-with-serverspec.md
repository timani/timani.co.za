---
layout: post
title: A TDD approach to creating a minimal Sculpin Docker image with Serverspec - Part 1 of 4
categories: Docker, TDD
---

We most frequently use Curl in the form of `libcurl`, a C library providing function transferring data between servers using many of the popular protocols like HTTP, FTP, SCP, and so on. This library is the foundation things like all the curl_*() functions in PHP, which are useful for writing code that interacts with various web services.

<!--more-->

### Summary

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
  * [Conclusion](#dependency)

### Overview

Allow your teams to use their favorite Agile lifecycle tools while maintaining full visibility and control.
Requirements

- Test Driven Development for containers with serverspec

### Getting started  

- what this section is about
- why it matters

Defining requirements

- research or examples

Here you can search for any topic that interests you, find information, images, quotes, citations and more, and then quickly insert them into your document.

<div style="overflow-x:auto;">
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
</div>
<p class=" mdl-color-text--grey-500">
Table 1: Docker PHP requirements
</p>
- takeaways

##### Build the Development environment

- what this section is about

Once we have the requirements we can proceed to setup and configure test-kitchen.

- why it matters

- research or examples

###### Step 1: Add Test Kitchen to a `Gemfile` within the project:

<pre><code class="language-ruby">#Gemfile
source 'https://rubygems.org'
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

<pre><code class="language-bash"># Install dependencies
$ bundle install
# Verify Test Kitchen is installed, run the kitchen help command:
$ bundle exec kitchen help
# You should see something like:
$ kitchen version   # Print Kitchen's version information
Test Kitchen version 1.4.2
</code></pre>

- takeaways

### Configure Test Kitchen

- what this section is about

The easiest way is to map out a table of the `kitchen.yml` or section that you will want to make sure is configured correctly. For example, in our case we will be looking at the Configuration of the container to make sure ruby is installed.

<pre><code class="language-yaml"># kitchen.yml
---
driver:
  name: docker
provisioner:
  name: ansible_playbook
platforms:
  - name: ubuntu-12.04
suites:
  - name: default
    run_list:
      - recipe[git::default]
    attributes:
</code></pre>

**Drivers**

For example, in our case we will be looking at the Configuration. The easiest way is to map out a table of assignment.

<pre><code class="language-yaml">driver:
  name: docker
</code></pre>

###### Provisioners

Tools used to converge an environment. During convergence the Configuration is run against a set of Platforms.

<pre><code class="language-yaml">provisioner:
  name: ansible_playbook
</code></pre>

###### Platforms

Using the same Serverspec and RSpec tests we already use for our Ansible scripts. Thanks for the heads up and keep up the great work ;-). Operating systems

<pre><code class="language-yaml">platforms:
- name: ubuntu
  driver_config:
    image: ubuntu:14.04
    platform: ubuntu
</code></pre>

###### Test Suites

Using the same Serverspec and RSpec tests we already use for our Ansible scripts. Thanks for the heads up and keep up the great work ;-). Operating systems

<pre><code class="language-yaml">suites:
- name: default
  run_list:
  ubuntu:
</code></pre>

- why it matters
- research or examples
- takeaways

<pre><code class="language-bash">$ kitchen list
Instance             Driver   Provisioner  Last Action
default-ubuntu-1204  Vagrant  ChefSolo     < Not Created>
</code></pre>

So what's this default-ubuntu-1204 thing and what's an "Instance"? A Test Kitchen Instance is a pairwise combination of a Suite and a Platform as laid out in your .kitchen.yml file. Test Kitchen has auto-named your only instance by combining the Suite name ("default") and the Platform name ("ubuntu-12.04") into a form that is safe for DNS and hostname records, namely "default-ubuntu-1204"


### Development workflow

The Platform name ("ubuntu-12.04") into a form that is safe for DNS and hostname records, namely "default-ubuntu-1204"


##### Step 1:Create

Okay, let's spin this Instance up to see what happens. Test Kitchen calls this the Create Action. We're going to be painfully explicit and ask Test Kitchen to only create the default-ubuntu-1204 instance:

<pre><code class="language-bash">#Create the default-ubuntu-1204 instance
$ kitchen create default-ubuntu-1204

$ kitchen list
Instance             Driver   Provisioner  Last Action
default-ubuntu-1204  Vagrant  ChefSolo     Created
</code></pre>

Test Kitchen has a login subcommand for just these kinds of situations:

<pre><code class="language-bash"># Login to the default-ubuntu-1204 instance
$ kitchen login default-ubuntu-1204
Welcome to Ubuntu 12.04.2 LTS (GNU/Linux 3.5.0-23-generic x86_64)

 * Documentation:  https://help.ubuntu.com/
Last login: Sat Nov 30 21:56:59 2013 from 10.0.2.2
vagrant@default-ubuntu-1204:~$
</code></pre>

##### Step 2:Converge

Now that we have some code, let's let Test Kitchen run it for us on our Ubuntu 12.04 instance:

<pre><code class="language-bash"># Update instance Configuration
$ kitchen converge default-ubuntu-1204
-----> Starting Kitchen (v1.0.0)
-----> Converging < default-ubuntu-1204 >...
       Preparing files for transfer
       Preparing current project directory as a cookbook
       Removing non-cookbook files before transfer
-----> Installing Chef Omnibus (true)
       downloading https://www.opscode.com/chef/install.sh
         to file /tmp/install.sh
       trying wget...
Downloading Chef  for ubuntu...
Installing Chef
Selecting previously unselected package chef.
(Reading database ... 53291 files and directories currently installed.)
Unpacking chef (from .../tmp.GUasmrcD/chef__amd64.deb) ...
Setting up chef (11.8.0-1.ubuntu.12.04) ...
Thank you for installing Chef!
       Transfering files to < default-ubuntu-1204 >
[2013-11-30T21:55:45+00:00] INFO: Forking chef instance to converge...
Starting Chef Client, version 11.8.0
[2013-11-30T21:55:45+00:00] INFO: *** Chef 11.8.0 ***
[2013-11-30T21:55:45+00:00] INFO: Chef-client pid: 1162
[2013-11-30T21:55:46+00:00] INFO: Setting the run_list to ["recipe[git::default]"] from JSON
[2013-11-30T21:55:46+00:00] INFO: Run List is [recipe[git::default]]
[2013-11-30T21:55:46+00:00] INFO: Run List expands to [git::default]
[2013-11-30T21:55:46+00:00] INFO: Starting Chef Run for default-ubuntu-1204
[2013-11-30T21:55:46+00:00] INFO: Running start handlers
[2013-11-30T21:55:46+00:00] INFO: Start handlers complete.
Compiling Cookbooks...
Converging 2 resources
Recipe: git::default
  * package[git] action install[2013-11-30T21:55:46+00:00] INFO: Processing package[git] action install (git::default line 1)

    - install version 1:1.7.9.5-1 of package git

  * log[Well, that was too easy] action write[2013-11-30T21:56:14+00:00] INFO: Processing log[Well, that was too easy] action write (git::default line 3)
[2013-11-30T21:56:14+00:00] INFO: Well, that was too easy


[2013-11-30T21:56:14+00:00] INFO: Chef Run complete in 28.139177847 seconds
[2013-11-30T21:56:14+00:00] INFO: Running report handlers
[2013-11-30T21:56:14+00:00] INFO: Report handlers complete
Chef Client finished, 2 resources updated
       Finished converging < default-ubuntu-1204 > (1m3.91s).
-----> Kitchen is finished. (1m4.22s)
</code></pre>

Converge will always exit with code 0 if my operation was successful.

Let's check the status of our instance:
<pre><code class="language-bash">$ kitchen list
Instance             Driver   Provisioner  Last Action
default-ubuntu-1204  Vagrant  ChefSolo     Converged
</code></pre>

##### Step 3:Verify

Excellent, 3 success messages just as we had hoped. The reason is because our docker image has met all of the dependencies based on the requirements

### Initialize Serverspec

and create the first outline of our tests.

##### Step 1:Create Serverspec within the project

<pre><code class="language-bash">$ serverspec-init
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

<pre><code  class="language-ruby"># spec/Dockerfile_spec.rb

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

<pre><code  class="language-bash">├── .gitignore
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

<pre><code class="language-bash">$ rspec spec/Dockerfile_spec.rb
1 example, 3 failures
</code></pre>

Excellent, 3 failures messages just as we had hoped. The reason is because our docker image has not been created yet and does not meet the requirements.

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

##### Adding Vagrant Support

- what this section is about
- why it matters
- research or examples
- takeaways

https://robots.thoughtbot.com/tdd-your-dockerfiles-with-rspec-and-serverspec
