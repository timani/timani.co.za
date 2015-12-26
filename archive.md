---
title: Archive
layout: default
permalink: "archives/index.html"
---
<div class="page-archive">

Almost everybody thinks cloud computing is new concept where as truth is the idea was actually created in the 1960’s. A man called Joseph Carl Robnett Licklider or J.C.R. was one of America’s leading computer scientists. At a similar time another computer scientist called John McCarthy, who was famous for coining the term “artificial intelligence”, also believed that we would have a world-wide computer network.

{% for post in site.posts %}
    {% assign post_month_year = post.date | date: "%B %Y" %}
    {% assign newer_post_month_year = post.next.date | date: "%B %Y" %}
    {% if post_month_year != newer_post_month_year %}
      <h5 class="section-header-archive">
        {{ post_month_year }}
      </h5>
    {% endif %}
    <article>
      <div>
        <a href="{{ post.url | prepend:site.baseurl}}" class="post-title-archive">{{ post.title }}</a>
      </div>
      <p class="mdl-color-text--grey-800">
        Posted: {{ post.date | date_to_string }}  
      </p>
      <br />
    </article>
{% endfor %}
</div>
