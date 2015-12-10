---
title: "Guides and Tutorials"
layout: guides
permalink: "guides/index.html"
---

<div class="mdl-grid">
{% for post in site.posts limit:site.data.theme.num_home_posts %}
<!-- Square card -->
<style>
.demo-card-square.mdl-card {
  height: 320px;
}
.demo-card-square > .mdl-card__title {
  color: #fff;
  background:
    url('../assets/demos/dog.png') bottom right 15% no-repeat #46B6AC;
}
</style>

  <div class="demo-card-square mdl-cell mdl-cell--4-col mdl-cell--3-col-tablet mdl-cell--3-col-phone mdl-card mdl-shadow--3dp">
  <div class="mdl-card__title mdl-card--expand">
    <h2 class="mdl-card__title-text">Update</h2>
  </div>
              <div class="mdl-card__title">
                 <h4 class="mdl-card__title-text">Get going on Android</h4>
              </div>
              <div class="mdl-card__supporting-text">
                <span class="mdl-typography--font-light mdl-typography--subhead">Four tips to make your switch to Android quick and easy</span>
              </div>
              <div class="mdl-card__actions">
                 <a class="android-link mdl-button mdl-js-button mdl-typography--text-uppercase" href="" data-upgraded=",MaterialButton">
                   Make the switch
                   <i class="material-icons">chevron_right</i>
                 </a>
              </div>
            </div>
{% endfor %}
<div class="home-read-more">
  <a href="{{ "/archive" | prepend:site.baseurl }}" class="btn btn-primary btn-block btn-lg">View All {{ site.posts | size }} Articles →</a>
</div>
</div>
