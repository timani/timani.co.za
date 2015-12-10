---
layout: post
title: Publishing a docker image and automating tests with travisci - Part 3 of 4
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
### Publish and share the images

#### Create a github repo
Images will appear in the general search, as well as an image search. Narrow your search results to only images by selecting “Images”.

 - Here you can search for any topic that interests you,
 -  find  information, images, quotes, citations  
 - More, and then quickly insert  them into your document.

#### Committing the changes
Create a new post in `source/_posts` and add the snippet below to a file named brining-documentation-to-life-with-docker.md

<pre><code  data-language="shell">
### Check for the current list of changes
git status

# Add the unstaged changes
git add .

# Commit the updates to the link color
git commit -m “Adding spacing and changing the post link color”

# Update the github repo with the latest changes
git push origin docker_sculpin
</code></pre>

#### Continuous Integration with CircleCI

When conducting a search, the Research tool will show you different types of results — web results, images, tables, quotations, maps, reviews, personal results, and more.

##### Configuring the build

When conducting a search in the Research tool for a geographic location, your search results may include a map.

1.  Open a document or presentation.
2.  Do one of the following:
    *   Go to the **Tools** menu > **Research**.
    *   Use the keyboard shortcut (**Ctrl + ⌘ + Shift + I** on a Mac, **Ctrl + Alt + Shift + I** on a PC).
    *   Right-click on a specific word and select **Research**.
3.  The Research tool will appear along the right-hand side. Start a search by typing into the search bar.
4.  You can narrow your search to specific types of results (e.g. images, quotations) by using the drop-down menu in the search bar.

##### Add circle.yml

<pre><code  data-language="shell">
machine:
  services:
    - docker
dependencies:
  override:
    - docker build -t sculpin .
test:
  override:
    - docker run -t -i -p 8000:8000 sculpin /bin/bash
    - git clone https://github.com/sculpin/sculpin-blog-skeleton.git test-blog
    - cd test-blog
    - sculpin install
    - sculpin generate --watch --server
    - curl --retry 10 --retry-delay 5 -L -I http://localhost:8000
</code></pre>

* `-v`: within the host machine within the container so sculpin can be built in the container and previewed on the host machine.
* `-p`: Expose the port `8000`  within the host machine and the container.
* `timani/sculpin`: The command that will be executed when the container build process is complete.
* `/bin/run.sh`: The command that will be executed when the container build process is complete.

- takeaways

#### Copy the skeleton sculpin project to the current directory

- what this section is about
- why it matters
- research or examples
- takeaways


#### Conclusion

Use composer to download and manage the dependencies for the project. When that is done, we can proceed to install sculpin and generate the project.

#### What's next?

Use the Research tool's dictionary to search for definitions, synonyms, and usage examples. If you don't already have the Research tool open, you can access the dictionary by clicking the Tools menu and then selecting Define.
