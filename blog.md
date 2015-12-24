---
layout: blog
title: "The latest posts from my blog"
permalink: "blog/index.html"
---

{% for post in site.posts limit:site.data.theme.num_home_posts %}
<article class="h-entry">
  <h4 class="post-title-home">
    <a href="{{ post.url | prepend:site.base-url }}" >{{ post.title }}</a>
  </h4>
  <div class="p-summary">
    {{ post.excerpt }}
  </div><p class="meta-section mdl-color-text--grey-500">
      Posted:
      <time class="dt-published" datetime="2013-06-13 12:00:00"><span class="tutorial-date">Oct 14, 2013</span></time>
    </p>
  </article>
<div class="separator"></div>
{% endfor %}
<div class="home-read-more">
  <p>
    <a href="{{ "/archive" | prepend:site.baseurl }}" class="btn btn-primary btn-block btn-lg">View All {{ site.posts | size }} Articles →</a>
  </p>
  <br />
</div>
