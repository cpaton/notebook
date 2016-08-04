---
layout: null
---

<ul>
  {% for post in site.testing %}
    <li>
      <a href="{{ post.url }}">{{ post.title }}</a>
      {{ post.excerpt }}
    </li>
  {% endfor %}
</ul>

<!-- TODO: can we get an item in the collection via a name or some kind of other tag.
           could be useful if had a collection of vimeo videos to place links easier -->
{% assign the_page = (site.testing | where:"url","/testing/index.html") | first ) %}
{{ the_page.url }}


           
           
