---
title: Docker
---

``` shell
docker run --label=jekyll -v '/c/_cp/Git/notebook.pages:/srv/jekyll' -e 'POLLING=true' -i -t -p 4000:4000 jekyll/jekyll:3.2.0
```