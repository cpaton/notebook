---
title: Microservices
---

# Data Dichotomy

Interesting article by Ben Stopford describing the problem of data management within a microservices architecture.  Services want to encapsulate data, but other services need access to slice and dice that data as needed.  In the article he describes an architecture which uses immutable streams of data accessbile to any service.  A single service is responsible for adding to/mutating the stream

[The Data Dichotomy: Rethinking the Way We Treat Data and Services](https://www.confluent.io/blog/data-dichotomy-rethinking-the-way-we-treat-data-and-services/)