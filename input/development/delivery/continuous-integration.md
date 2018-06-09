---
title: CI
---

# Riot Games

Build engineers from Riot Games posted a series of posts describing their continuous delivery setup with containers.

* [Part I: Thinking Inside the Container](https://engineering.riotgames.com/news/thinking-inside-container)
* [Part II: Putting Jenkins in a Docker Container](http://engineering.riotgames.com/news/putting-jenkins-docker-container)
* [Part III: Docker & Jenkins: Data That Persists](http://engineering.riotgames.com/news/docker-jenkins-data-persists)
* [Part IV: Jenkins, Docker, Proxies, and Compose](http://engineering.riotgames.com/news/jenkins-docker-proxies-and-compose)
* [Part V: Taking Control of Your Docker Image](http://engineering.riotgames.com/news/taking-control-your-docker-image)
* [Part VI: Building with Jenkins Inside an Ephemeral Docker Container](http://engineering.riotgames.com/news/building-jenkins-inside-ephemeral-docker-container)
* [Part VII: Tutorial: Building with Jenkins Inside an Ephemeral Docker Container](http://engineering.riotgames.com/news/jenkins-ephemeral-docker-tutorial)
* [Part VIII: DockerCon Talk and the Story So Far](http://engineering.riotgames.com/news/thinking-inside-container-dockercon-talk-and-story-so-far)

Part I lists their principles which underpin the setup

> * We believe that engineering teams have to be able to totally own their technology stacks, down to administrative level control of their build environments.
> * We believe in Configuration as Code. Teams should maintain their build pipeline and environment in source control whenever possible.
> * We believe that every time an engineer performs a build, they need to build a shippable version of their software in all deployable configurations.  A “build” is not a code compile; it’s the entire set of deployable artifacts.
> * We believe that shipping is a product decision. Product teams need to be able to deploy and see the latest shippable version at the push of a button.