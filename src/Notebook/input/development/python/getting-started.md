---
layout: page
title: Getting Started
page_display_sort_order: 1
---

* [Hitchhikers Guide to Python](https://docs.python-guide.org/)

Don't upgrade the system level packages on Linux.  Use virtual environments instead
[Linuxize Instructions](https://linuxize.com/post/how-to-install-python-3-7-on-ubuntu-18-04/)

```
sudo apt update
sudo apt install software-properties-common
sudo add-apt-repository ppa:deadsnakes/ppa
sudo apt update
sudo apt install python3.7
```

```
sudo apt install python3-venv
python3 -m venv my-project-env
source my-project-env/bin/activate
```


[Style Guide](https://www.python.org/dev/peps/pep-0008/)