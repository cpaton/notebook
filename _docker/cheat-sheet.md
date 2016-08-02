---
title: Cheat Sheet
---

### Ctrl+C support

need to add -t -i to support sending ctrl+c to process within powershell

{% highlight powershell %}
docker run -v '/c/_cp/Git/notebook.wiki:/wiki' -p 80:80 -t -i notebook-gollum
{% endhighlight %}

### Configuring PowerShell

Need to start the docker machine (host for containers)

{% highlight powershell %}
docker-machine start default
{% endhighlight %}

configure environment so that it can connect

{% highlight powershell %}
docker-machine env default --shell powershell | invoke-expression
{% endhighlight %}

should then be able to use the docker command line tool e.g. docker images

### IP of the machine

{% highlight shell %}
docker-machine ip defaulta
{% endhighlight %}