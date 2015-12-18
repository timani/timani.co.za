---
layout: post
title: "Building a Graylog server with Docker, Ansible and Test Kitchen"
---

We most frequently use Curl in the form of `libcurl`, a C library providing function transferring data between servers using many of the popular protocols like HTTP, FTP, SCP, and so on. This library is the foundation things like all the curl_*() functions in PHP, which are useful for writing code that interacts with various web services.

<!--more-->

##### Summary

This is sample project for Test Driven Development (TDD) of Dockerfile by RSpec. This means developing dockerfile by below cycle.

- Overview
- Getting Started

##### Overview

Allow your teams to use their favorite Agile lifecycle tools while maintaining full visibility and control.
Requirements

- Test Driven Development for containers with serverspec

##### Getting started  

- what this section is about
- why it matters
- research or examples

To get started, you'll need to add Test Kitchen to your Gemfile inside your Chef Cookbook:

```
source 'https://rubygems.org'
gem 'test-kitchen', '~> 1.0'

group :integration do
  gem 'kitchen-vagrant', '~> 0.11'
end
kitchen-vagrant is a "Test Kitchen driver" - it tells test-kitchen how to interact with an appliance (machine), such as Vagrant, EC2, Rackspace, etc.
```

And run the bundle command to install:

$ bundle install
To verify Test Kitchen is installed, run the kitchen help command:

$ bundle exec kitchen help
You should see something like:
```
kitchen version                          # Print Kitchen's version information
```

- takeaways

## SECTION 2

- what this section is about
- why it matters
- research or examples
- takeaways

## SECTION 3

- what this section is about
- why it matters
- research or examples
- takeaways

***

conclusion

<small>Image credits:</small>
