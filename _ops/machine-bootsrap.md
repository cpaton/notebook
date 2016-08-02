---
title: Machine Bootstrap
---

### Boxstarer

Boxstarter provides a way to easily bootstrap a machine by installing packages from chocolately plus it provides utility functions for configuring windows. It supports starting from nothing via visiting a URL which accepts a path to a configuration script that is publicly accessbile e.g. GitHub gist. This URL uses a Click Once installer to install Boxstarter and then run the script. Initial trials with this approach weren't ideal

Uses a private version of chocolately. So after boxstarter is complete chocolately is not available on the machine
Want to use a packages.config file with chocolately so that it can be used at bootstrap time and also later. These require a specific filename so doesn't work well with GitHub gists
As a result decided to get with a seperate powershell script as the start point. This is made available on a public share on the internal network. Once this script is on the machine to setup it is a single command to bootstrap the machine which

* Installs chocolately
* Installs Boxstarter via chocolately
* Takes a template box starter script and adds paths to packages.config files at the end to specify the chocolately packages to install