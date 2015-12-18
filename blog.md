---
layout: blog
title: "The latest posts from my blog"
permalink: "blog/index.html"
---

{% for post in site.posts limit:site.data.theme.num_home_posts %}
<article class="h-entry">
  <h5 class="post-title-home">
    <a href="{{ post.url | prepend:site.base-url }}">{{ post.title }}</a>
  </h5>
  <p class="meta-section tags">
      Posted:
      <time class="dt-published" datetime="2013-06-13 12:00:00"><span class="tutorial-date">Oct 14, 2013</span></time>
       <span class="hashtag-icon"> Categories: </span> <a class="" href="/community/tags/one-click-install-apps?type=tutorials">One-Click Install Apps</a>, <a class="" href="/community/tags/ghost?type=tutorials">Ghost</a>, <a class="" href="/community/tags/nginx?type=tutorials">Nginx</a> <a class="" href="/community/tags/ubuntu?type=tutorials">Ubuntu</a></span>
    </p>
  <div class="p-summary">
    {{ post.excerpt }}
  </div>
    <p><a href="{{ post.url | prepend:site.baseurl }}">Continue Reading &rarr;</a></p>
  </article>
<div class="section-spacer"></div>
<br />
{% endfor %}
<div class="home-read-more">
  <p>
    <a href="{{ "/archive" | prepend:site.baseurl }}" class="btn btn-primary btn-block btn-lg">View All {{ site.posts | size }} Articles →</a>
  </p>
  <br />
</div>
