---
layout: page
title: Testing
sub-title: Testing Sub Title
# permalink: /testing/
---

some text

some other text
{% assign video = site.data.vimeo["electronics_101"] %}
<iframe src="{{video.player_url}}" width="500" height="281" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen> </iframe>
<p><a href="{{ video.video_url}}">{{ video.title }}</a> {{ video.from }}</p>

<ul>
{% for collection in site.testing %}
              <li>{{ collection.title }}</li>
              {% endfor %}
              
</ul>              
