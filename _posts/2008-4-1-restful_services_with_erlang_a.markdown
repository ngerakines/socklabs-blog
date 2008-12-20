---
id: 1515
layout: post
title: >
    Restful services with erlang and yaws
---

It looks like Steve Vinoski beat me to it and put out [an article](http://www.infoq.com/articles/vinoski-erlang-rest) about creating RESTful web-services with Yaws. This is something that I've been thinking a lot about lately. Erlang is a beautiful language and allows you to not worry about seemingly basic concepts like concurrency, data storage and complex structures. With [Yaws](http://yaws.hyber.org/) it is incredibly easy to create very specific, fine-tuned web services to interact and provide interfaces to your erlang applications. 

These are some things that come to mind when I start thinking about this:

*   Websites and services, in their current state, do an extremely poor job at communicating, presenting and referencing information.
*   A website/service shouldn't be a set of scripts that talk to a database and handle tons of business logic. Websites should be simple front-ends to applications and data-stores. A lot of developers just don't get this.
*   XML, JSON and HTML are just part of the presentation used to render information. 
*   Simple things like user/client authentication is a **process**, not just an action. Processes can and should have a lifespan that can go beyond the request that initiates the process. That same process can represent a user, their actions, their resources and their state. Sessions and cookies are just the beginning.
*   Databases (like mysql) can be a source of truth, but don't have to be the only one. Having components that represent data (using mnesia or ets/dets for example) or memcached clusters can help out in more than the obvious ways.
