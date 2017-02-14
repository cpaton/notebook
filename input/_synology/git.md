---
title: Git Backup
---

Central repository needs to be bare to support easy pushing

{% highlight shell %}
git init --bare <Repo Name>
{% endhighlight %}

Then setup a copy of the Git Repo, setting the core.filemode configuration option to false. This stops git thinking there are differences on Linux based purely on permisson differences

{% highlight shell %}
git clone -c core.filemode=false <Path to Repo> <Repo Name>
{% endhighlight %}

Within CrashPlan make sure that the .git directory has been setup to be excluded. Settings -> Backup -> Filename Exclusions.

{% highlight shell %}
.*/\.git.*
{% endhighlight %}