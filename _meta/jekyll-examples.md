---
title: Jekyll Examples
---

### Referencing collection via name

You can access a collection by its name via array access from site.  For example given a collection call Synology it can be accessed via

{% highlight ruby %}
site['synology']
{% endhighlight %}

Note the collection name is case sensitive.

For example the below is a list of pages in that collection

<ul>
{% for page in site['synology'] %}
{% unless page.published == false %}
    <li><a href="{{ site.url }}{{ page.url }}">{{ page.title }}</a></li>
{% endunless %}
{% endfor %}
</ul>

### Display collections in sorted order

Use Liquid function to sort the collection array by a custom property defined in the ``_config.yml``

{% highlight ruby %}
assign sorted_collections = site.collections | sort: 'display_order'
{% endhighlight %}

For example below is a list of collcetions labels in display order

<ul>
{% assign sorted_collections = site.collections | sort: 'display_order' %}
{% for c in sorted_collections %}
   {% assign collection_name=c.label %}
   {% unless collection_name == 'posts' %}
   <li>{{ c.label }}</li>
   {% endunless %}
{% endfor %}
</ul>