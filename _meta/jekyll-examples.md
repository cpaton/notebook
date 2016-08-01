---
title: Jekyll Examples
---

### Referencing collection via name

You can access a collection by its name via array access from site.  For example given a collection call Synology it can be accessed via

~~~
site['synology']
~~~

Note the collection name is case sensitive.

For example the below is a list of pages in that collection

<ul>
{% for page in site.['synology'] %}
{% unless page.published == false %}
    <li><a href="{{ site.url }}{{ page.url }}">{{ page.title }}</a></li>
{% endunless %}
{% endfor %}
</ul>