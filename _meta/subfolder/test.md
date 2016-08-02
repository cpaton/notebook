---
title: Subfolder test
---

Sample file in subfolder


{% assign pages = site.['meta'] %}
{% for page in pages %}
{{ page.path }}
{% endfor %}
