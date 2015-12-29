---
layout: post
title: A TDD approach to creating a minimal Sculpin Docker image with Serverspec - Part 1 of 5
categories: Docker, TDD
---

We most frequently use Curl in the form of `libcurl`, a C library providing function transferring data between servers using many of the popular protocols like HTTP, FTP, SCP, and so on. This library is the foundation things like all the curl_*() functions in PHP, which are useful for writing code that interacts with various web services.

<!--more-->

#### Summary

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

#### Overview

Allow your teams to use their favorite Agile lifecycle tools while maintaining full visibility and control.
Requirements

<p><img src="https://asciinema.org/a/624fjx2rx7k3pctdozw7m8b24.png" width="100%"></p>

#### Getting started  

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
      <th class="mdl-data-table__cell--non-numeric" >Condition</th>
      <th class="mdl-data-table__cell--non-numeric" >Criteria</th>
      <th class="mdl-data-table__cell--non-numeric" >Status</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td class="mdl-data-table__cell--non-numeric">fcgi</td>
      <td class="mdl-data-table__cell--non-numeric" >Should be</td>
      <td class="mdl-data-table__cell--non-numeric" >Installed</td>
      <td class="mdl-data-table__cell--non-numeric" ><button class="mdl-button mdl-js-button mdl-button--icon">
  <i class="material-icons">close</i>
</button>
</td>
    </tr>
      <tr>
        <td class="mdl-data-table__cell--non-numeric">vim</td>
        <td class="mdl-data-table__cell--non-numeric" >Should be</td>
        <td class="mdl-data-table__cell--non-numeric" >Installed</td>
        <td class="mdl-data-table__cell--non-numeric" ><button class="mdl-button mdl-js-button mdl-button--icon">
    <i class="material-icons">close</i>
  </button>
  </td>
      </tr>
    <tr>
      <td class="mdl-data-table__cell--non-numeric" >zip</td>
      <td class="mdl-data-table__cell--non-numeric" >Should be</td>
      <td class="mdl-data-table__cell--non-numeric" >Installed</td>
      <td class="mdl-data-table__cell--non-numeric" ><button class="mdl-button mdl-js-button mdl-button--icon">
  <i class="material-icons">close</i>
</button>
</td>
    </tr>
    <tr>
      <td class="mdl-data-table__cell--non-numeric">Tag</td> 
      <td class="mdl-data-table__cell--non-numeric" >Should be</td>
      <td class="mdl-data-table__cell--non-numeric" ><code>Alpine Linux</code></td>
      <td class="mdl-data-table__cell--non-numeric" ><button class="mdl-button mdl-js-button mdl-button--icon">
  <i class="material-icons">close</i>
</button>
</td>
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

###### Step 2: Run the `bundle` command to install

Install the dependencies for the project in the Gemfile we created earlier. If everything goes correctly, we should be able to get list the installed version Test Kitchen.

<pre><code class="language-bash"># Install dependencies
$ bundle install
# Verify Test Kitchen is installed, run the kitchen help command:
$ bundle exec kitchen help
# You should see something like:
$ kitchen version   # Print Kitchen's version information
Test Kitchen version 1.4.2
</code></pre>

- takeaways

##### Initialize a kitchen project

Create a kitchen project using the Docker driver and Ansible as the provisioner.

<pre><code class="language-bash"># Create a kitchend
kitchen init --driver=docker --provisioner=ansible_playbook
      create  .kitchen.yml
      create  chefignore
      append  Rakefile
      create  test/integration/default
      append  .gitignore
</code></pre>

The

##### Configure Test Kitchen

- what this section is about

The easiest way is to map out a table of the `kitchen.yml` or section that you will want to make sure is configured correctly. For example, in our case we will be looking at the Configuration of the container to make sure ruby is installed.

<pre><code class="language-yaml"># kitchen.yml
---
driver:
  name: docker
provisioner:
  name: ansible_playbook
platforms:
  - name: alpine # Docker image on the hub
suites:
  - name: default
    run_list:
      - recipe[git::default]
    attributes:
</code></pre>

###### Drivers

Cloud providers like EC2, Digital Ocean, Rackspace, Azure and in our case Google Compute Engine. In a later post we will see how we can verify that our infrastructure runs as expected on in the environment it will reside.

This way you can anticipate any potential caveats, exception handling or patches that need to be applied prior to release in production.

Test Kitchen also support Virtualization drivers like Vagrant, Docker, LXC and VMWare among others. For this tutorial the driver can is set to docker.

<pre><code class="language-yaml">driver:
  name: docker
</code></pre>

###### Provisioners

This tells Test Kitchen how to run Chef, to apply the code in our cookbook to the machine under test. The default and simplest approach is to use chef-solo, but other options are available, and ultimately Test Kitchen doesn't care how the infrastructure is built

<pre><code class="language-yaml">provisioner:
  name: ansible_playbook
</code></pre>

It could theoretically be with Puppet, Ansible, or Perl for all it cares.

**Creating an Ansible playbook**

<pre><code class="language-yaml">---
# provision.yml
- hosts: docker
- sudo: true
- user: root

  tasks:
    - name: Build Alpine linux image
      local_action:
          module: docker_image
          path: .
          name: sculpin
          state: present
</code></pre>

###### Platforms

 This is a list of operation systems on which we want to run our code. Note that the operating system's version, architecture, cloud environment, etc. might be relevant to what Test Kitchen considers a Platform.

<pre><code class="language-yaml">platforms:
- name: alpine
</code></pre>

We want to keep our containers as lean as possible and Alpine Linux is a great distribution that is lightweight and easy to use. The main benefit is the docker image is only 5 MB so it slim and has fair number of packages available.

###### Suites

This section defines what we want to test. It includes the Chef run-list and any node attribute setups that we want run on each Platform above. For example, we might want to test the MySQL client cookbook code separately from the server cookbook code for maximum isolation.

<pre><code class="language-yaml">suites:
- name: default
  run_list:
  default:
</code></pre>

- why it matters
- research or examples

The suites are the tests that are going to be run.
- `name`: The suite we will be running is called `default` and we will be using Serverspec to  to create the infrastructure tests later on.
- `run_list`: The serverspec tests

- takeaways

<pre><code class="language-bash">$ kitchen list
Instance             Driver   Provisioner  Last Action
default-ubuntu-1204  Vagrant  ChefSolo     < Not Created>
</code></pre>

So what's this default-ubuntu-1204 thing and what's an "Instance"? A Test Kitchen Instance is a pairwise combination of a Suite and a Platform as laid out in your .kitchen.yml file.

- `Instance`: A "Test Kitchen driver" - it tells test-kitchen how to interact with an appliance (machine), such as Vagrant, EC2, Rackspace, etc.
- `Driver`: To validate the images we will use serverspec.
- `provisioner`: A "Test Kitchen driver" - it tells test-kitchen how to interact with an appliance (machine), such as Vagrant, EC2, Rackspace, etc.
- `Last Action`: To validate the images we will use serverspec.

Test Kitchen has auto-named your only instance by combining the Suite name ("default") and the Platform name ("ubuntu-12.04") into a form that is safe for DNS and hostname records, namely "default-ubuntu-1204"

##### Building test suites with Serverspec

and create the first outline of our tests.

###### Step 1: Create Serverspec within the project

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


###### Step 2: Create default test suite

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

###### Step 3: Run test suite

 A Test Kitchen Instance is a pairwise combination of a Suite and a Platform as laid out in your .kitchen.yml file.

<pre><code class="language-bash">$ kitchen test default-ubuntu-1204
-----> Starting Kitchen (v1.0.0)
-----> Cleaning up any prior instances of < default-ubuntu-1204>
-----> Destroying < default-ubuntu-1204>...
       [default] Forcing shutdown of VM...
       [default] Destroying VM and associated drives...
       Vagrant instance < default-ubuntu-1204> destroyed.
       Finished destroying < default-ubuntu-1204> (0m3.06s).
-----> Testing < default-ubuntu-1204>
-----> Creating < default-ubuntu-1204>...
       Bringing machine 'default' up with 'virtualbox' provider...
       [default] Importing base box 'opscode-ubuntu-12.04'...
       [default] Matching MAC address for NAT networking...
       [default] Setting the name of the VM...
       [default] Clearing any previously set forwarded ports...
       [default] Creating shared folders metadata...
       [default] Clearing any previously set network interfaces...
       [default] Preparing network interfaces based on configuration...
       [default] Forwarding ports...
       [default] -- 22 => 2222 (adapter 1)
       [default] Running 'pre-boot' VM customizations...
       [default] Booting VM...
       [default] Waiting for machine to boot. This may take a few minutes...
[default] Machine booted and ready!       [default] Setting hostname...
       [default] Mounting shared folders...
       Vagrant instance < default-ubuntu-1204> created.
       Finished creating < default-ubuntu-1204> (0m46.22s).
-----> Converging < default-ubuntu-1204>...
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
Unpacking chef (from .../tmp.CLdJIw55/chef__amd64.deb) ...
Setting up chef (11.8.0-1.ubuntu.12.04) ...
Thank you for installing Chef!
       Transfering files to < default-ubuntu-1204>
[2013-11-30T22:10:59+00:00] INFO: Forking chef instance to converge...
Starting Chef Client, version 11.8.0
[2013-11-30T22:10:59+00:00] INFO: *** Chef 11.8.0 ***
[2013-11-30T22:10:59+00:00] INFO: Chef-client pid: 1192
[2013-11-30T22:10:59+00:00] INFO: Setting the run_list to ["recipe[git::default]"] from JSON
[2013-11-30T22:10:59+00:00] INFO: Run List is [recipe[git::default]]
[2013-11-30T22:10:59+00:00] INFO: Run List expands to [git::default]
[2013-11-30T22:10:59+00:00] INFO: Starting Chef Run for default-ubuntu-1204
[2013-11-30T22:10:59+00:00] INFO: Running start handlers
[2013-11-30T22:10:59+00:00] INFO: Start handlers complete.
Compiling Cookbooks...
Converging 2 resources
Recipe: git::default
  * package[git] action install[2013-11-30T22:10:59+00:00] INFO: Processing package[git] action install (git::default line 1)

    - install version 1:1.7.9.5-1 of package git

  * log[Well, that was too easy] action write[2013-11-30T22:11:24+00:00] INFO: Processing log[Well, that was too easy] action write (git::default line 3)
[2013-11-30T22:11:24+00:00] INFO: Well, that was too easy


[2013-11-30T22:11:24+00:00] INFO: Chef Run complete in 24.365178204 seconds
[2013-11-30T22:11:24+00:00] INFO: Running report handlers
[2013-11-30T22:11:24+00:00] INFO: Report handlers complete
Chef Client finished, 2 resources updated
       Finished converging < default-ubuntu-1204> (0m45.17s).
-----> Setting up < default-ubuntu-1204>...
Fetching: thor-0.18.1.gem (100%)
Fetching: busser-0.6.0.gem (100%)
Successfully installed thor-0.18.1
Successfully installed busser-0.6.0
2 gems installed
-----> Setting up Busser
       Creating BUSSER_ROOT in /tmp/busser
       Creating busser binstub
       Plugin bats installed (version 0.1.0)
-----> Running postinstall for bats plugin
      create  /tmp/bats20131130-4164-uxjzr4/bats
      create  /tmp/bats20131130-4164-uxjzr4/bats.tar.gz
Installed Bats to /tmp/busser/vendor/bats/bin/bats
      remove  /tmp/bats20131130-4164-uxjzr4
       Finished setting up < default-ubuntu-1204> (0m4.89s).
-----> Verifying < default-ubuntu-1204>...
       Suite path directory /tmp/busser/suites does not exist, skipping.
Uploading /tmp/busser/suites/bats/git_installed.bats (mode=0644)
-----> Running bats test suite
 ✓ git binary is found in PATH

       1 test, 0 failures

       Finished verifying < default-ubuntu-1204> (0m0.98s).
-----> Destroying < default-ubuntu-1204>...
       [default] Forcing shutdown of VM...
       [default] Destroying VM and associated drives...
       Vagrant instance < default-ubuntu-1204> destroyed.
       Finished destroying < default-ubuntu-1204> (0m3.48s).
       Finished testing < default-ubuntu-1204> (1m43.82s).
-----> Kitchen is finished. (1m44.11s)
</code></pre>


##### Development workflow

The Platform name ("ubuntu-12.04") into a form that is safe for DNS and hostname records, namely "default-ubuntu-1204"

< IMAGE OF FLOW >

###### Step 1:Create

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

###### Step 2:Converge

Now that we have some code, let's let Test Kitchen run it for us on our Ubuntu 12.04 instance:

<pre><code class="language-bash"># Update instance Configuration
$ kitchen converge default-ubuntu-1204
-----> Starting Kitchen (v1.0.0)
-----> Converging < default-ubuntu-1204>...
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
       Transfering files to < default-ubuntu-1204>
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
       Finished converging < default-ubuntu-1204> (1m3.91s).
-----> Kitchen is finished. (1m4.22s)
</code></pre>

Converge will always exit with code 0 if my operation was successful.

Let's check the status of our instance:

<pre><code class="language-bash">$ kitchen list
Instance             Driver   Provisioner  Last Action
default-ubuntu-1204  Vagrant  ChefSolo     Converged
</code></pre>

###### Step 3: Kitchen Test

Now it's time to introduce to the test meta-action which helps you automate all the previous actions so far into one command. Recall that we currently have our instance in a "verified" state. With this in mind, let's run kitchen test:

<pre><code class="language-bash">$ kitchen test default-ubuntu-1204
-----> Starting Kitchen (v1.0.0)
-----> Cleaning up any prior instances of < default-ubuntu-1204>
-----> Destroying < default-ubuntu-1204>...
       [default] Forcing shutdown of VM...
       [default] Destroying VM and associated drives...
       Vagrant instance < default-ubuntu-1204> destroyed.
       Finished destroying < default-ubuntu-1204> (0m3.06s).
-----> Testing < default-ubuntu-1204>
-----> Creating < default-ubuntu-1204>...
       Bringing machine 'default' up with 'virtualbox' provider...
       [default] Importing base box 'opscode-ubuntu-12.04'...
       [default] Matching MAC address for NAT networking...
       [default] Setting the name of the VM...
       [default] Clearing any previously set forwarded ports...
       [default] Creating shared folders metadata...
       [default] Clearing any previously set network interfaces...
       [default] Preparing network interfaces based on configuration...
       [default] Forwarding ports...
       [default] -- 22 => 2222 (adapter 1)
       [default] Running 'pre-boot' VM customizations...
       [default] Booting VM...
       [default] Waiting for machine to boot. This may take a few minutes...
[default] Machine booted and ready!       [default] Setting hostname...
       [default] Mounting shared folders...
       Vagrant instance < default-ubuntu-1204> created.
       Finished creating < default-ubuntu-1204> (0m46.22s).
-----> Converging < default-ubuntu-1204>...
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
Unpacking chef (from .../tmp.CLdJIw55/chef__amd64.deb) ...
Setting up chef (11.8.0-1.ubuntu.12.04) ...
Thank you for installing Chef!
       Transfering files to < default-ubuntu-1204>
[2013-11-30T22:10:59+00:00] INFO: Forking chef instance to converge...
Starting Chef Client, version 11.8.0
[2013-11-30T22:10:59+00:00] INFO: *** Chef 11.8.0 ***
[2013-11-30T22:10:59+00:00] INFO: Chef-client pid: 1192
[2013-11-30T22:10:59+00:00] INFO: Setting the run_list to ["recipe[git::default]"] from JSON
[2013-11-30T22:10:59+00:00] INFO: Run List is [recipe[git::default]]
[2013-11-30T22:10:59+00:00] INFO: Run List expands to [git::default]
[2013-11-30T22:10:59+00:00] INFO: Starting Chef Run for default-ubuntu-1204
[2013-11-30T22:10:59+00:00] INFO: Running start handlers
[2013-11-30T22:10:59+00:00] INFO: Start handlers complete.
Compiling Cookbooks...
Converging 2 resources
Recipe: git::default
  * package[git] action install[2013-11-30T22:10:59+00:00] INFO: Processing package[git] action install (git::default line 1)

    - install version 1:1.7.9.5-1 of package git

  * log[Well, that was too easy] action write[2013-11-30T22:11:24+00:00] INFO: Processing log[Well, that was too easy] action write (git::default line 3)
[2013-11-30T22:11:24+00:00] INFO: Well, that was too easy


[2013-11-30T22:11:24+00:00] INFO: Chef Run complete in 24.365178204 seconds
[2013-11-30T22:11:24+00:00] INFO: Running report handlers
[2013-11-30T22:11:24+00:00] INFO: Report handlers complete
Chef Client finished, 2 resources updated
       Finished converging < default-ubuntu-1204> (0m45.17s).
-----> Setting up < default-ubuntu-1204>...
Fetching: thor-0.18.1.gem (100%)
Fetching: busser-0.6.0.gem (100%)
Successfully installed thor-0.18.1
Successfully installed busser-0.6.0
2 gems installed
-----> Setting up Busser
       Creating BUSSER_ROOT in /tmp/busser
       Creating busser binstub
       Plugin bats installed (version 0.1.0)
-----> Running postinstall for bats plugin
      create  /tmp/bats20131130-4164-uxjzr4/bats
      create  /tmp/bats20131130-4164-uxjzr4/bats.tar.gz
Installed Bats to /tmp/busser/vendor/bats/bin/bats
      remove  /tmp/bats20131130-4164-uxjzr4
       Finished setting up < default-ubuntu-1204> (0m4.89s).
-----> Verifying < default-ubuntu-1204>...
       Suite path directory /tmp/busser/suites does not exist, skipping.
Uploading /tmp/busser/suites/bats/git_installed.bats (mode=0644)
-----> Running bats test suite
 ✓ git binary is found in PATH

       1 test, 0 failures

       Finished verifying < default-ubuntu-1204> (0m0.98s).
-----> Destroying < default-ubuntu-1204>...
       [default] Forcing shutdown of VM...
       [default] Destroying VM and associated drives...
       Vagrant instance < default-ubuntu-1204> destroyed.
       Finished destroying < default-ubuntu-1204> (0m3.48s).
       Finished testing < default-ubuntu-1204> (1m43.82s).
-----> Kitchen is finished. (1m44.11s)
</code></pre>

###### Step 3: Verify

Excellent, 3 success messages just as we had hoped. The reason is because our docker image has met all of the dependencies based on the requirements

<pre><code class="language-bash">$ kitchen verify default-ubuntu-1204
-----> Starting Kitchen (v1.0.0)
-----> Setting up < default-ubuntu-1204>...
Fetching: thor-0.18.1.gem (100%)
Fetching: busser-0.6.0.gem (100%)
Successfully installed thor-0.18.1
Successfully installed busser-0.6.0
2 gems installed
-----> Setting up Busser
       Creating BUSSER_ROOT in /tmp/busser
       Creating busser binstub
       Plugin bats installed (version 0.1.0)
-----> Running postinstall for bats plugin
      create  /tmp/bats20131130-4419-1fbu1/bats
      create  /tmp/bats20131130-4419-1fbu1/bats.tar.gz
Installed Bats to /tmp/busser/vendor/bats/bin/bats
      remove  /tmp/bats20131130-4419-1fbu1
       Finished setting up < default-ubuntu-1204> (0m4.25s).
-----> Verifying < default-ubuntu-1204>...
       Suite path directory /tmp/busser/suites does not exist, skipping.
Uploading /tmp/busser/suites/bats/git_installed.bats (mode=0644)
-----> Running bats test suite
 ✓ git binary is found in PATH

1 test, 0 failures
       Finished verifying < default-ubuntu-1204> (0m0.87s).
-----> Kitchen is finished. (0m5.45s)
$ echo $?</code></pre>

Excellent, 3 failures messages just as we had hoped. The reason is because our docker image has not been created yet and does not meet the requirements.

- takeaways

Here you can search for any topic that interests you, find information, images, quotes, citations and more, and then quickly insert them into your document.

<div style="overflow-x:auto;">
<table class="mdl-data-table mdl-js-data-table" width="100%">
  <thead>
    <tr>
      <th class="mdl-data-table__cell--non-numeric" >Component</th>
      <th class="mdl-data-table__cell--non-numeric" >Type</th>
      <th class="mdl-data-table__cell--non-numeric" >Condition</th>
      <th class="mdl-data-table__cell--non-numeric" >Criteria</th>
      <th class="mdl-data-table__cell--non-numeric" >Status</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td class="mdl-data-table__cell--non-numeric">fcgi</td>
      <td class="mdl-data-table__cell--non-numeric">package</td>
      <td class="mdl-data-table__cell--non-numeric" >Should be</td>
      <td class="mdl-data-table__cell--non-numeric" >Installed</td>
      <td class="mdl-data-table__cell--non-numeric" ><button class="mdl-button mdl-js-button mdl-button--icon">
  <i class="material-icons">check</i>
</button>
</td>
    </tr>
      <tr>
        <td class="mdl-data-table__cell--non-numeric">vim</td>
        <td class="mdl-data-table__cell--non-numeric">package</td>
        <td class="mdl-data-table__cell--non-numeric" >Should be</td>
        <td class="mdl-data-table__cell--non-numeric" >Installed</td>
        <td class="mdl-data-table__cell--non-numeric" ><button class="mdl-button mdl-js-button mdl-button--icon">
    <i class="material-icons">check</i>
  </button>
  </td>
      </tr>
    <tr>
      <td class="mdl-data-table__cell--non-numeric" >zip</td>
      <td class="mdl-data-table__cell--non-numeric" >package</td>
      <td class="mdl-data-table__cell--non-numeric" >Should be</td>
      <td class="mdl-data-table__cell--non-numeric" >Installed</td>
      <td class="mdl-data-table__cell--non-numeric" ><button class="mdl-button mdl-js-button mdl-button--icon">
  <i class="material-icons">check</i>
</button>
</td>
    </tr>
    <tr>
      <td class="mdl-data-table__cell--non-numeric">Tag</td>
      <td class="mdl-data-table__cell--non-numeric" >file</td>
      <td class="mdl-data-table__cell--non-numeric" >Should be</td>
      <td class="mdl-data-table__cell--non-numeric" ><code>Alpine Linux</code></td>
      <td class="mdl-data-table__cell--non-numeric" ><button class="mdl-button mdl-js-button mdl-button--icon">
  <i class="material-icons">check</i>
</button>
</td>
    </tr>
  </tbody>
</table>
</div>

##### Conclusion

Use composer to download and manage the dependencies for the project. When that is done, we can proceed to install sculpin and generate the project.

##### Resources

Determines whether or not a Chef Omnibus package will be installed. There are several different behaviors available.

##### What's next?

Use the Research tool's dictionary to search for definitions, synonyms, and usage examples. If you don't already have the Research tool open, you can access the dictionary by clicking the Tools menu and then selecting Define.
