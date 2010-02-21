---
id: 1201
layout: post
title: >
    Doing more with Catalyst
---

I've built, packaged and released my first <a href="http://www.catalystframework.org/">Catalyst</a> web application over the past few days. Its name is '<a href="http://www.infanttracker.com/">InfantTracker</a>' and is a collection of online tools to let parents easily and quickly track the growth, feedings, diapers, etc of their newborn child. I was surprised and amazed at how simple it was to plan, develop and push a full web application with just a few open source tools.

Instead of using <a href="http://search.cpan.org/dist/DBIx::Class/">DBIx::Class</a> or <a href="http://search.cpan.org/dist/Class-DBI/">Class::DBI</a>, I decided to use <a href="http://search.cpan.org/dist/Data-ObjectDriver/">Data::ObjectDriver</a> to power the data storage portion of the application. I use very simple model packages to define the model objects and let Data::ObjectDrvier to take care of the rest. Something I didn't want to worry about was being locked into a single database platform. With Data::ObjectDriver I can specify all of the database connection information at run time and not have to worry about how the internals work. It also lets me segment and partition the data storage over multiple database on multiple platforms allowing me to grow my database architecture as needed.

<img alt="infantracker_model.jpg" src="http://blog.socklabs.com/infantracker_model.jpg" width="529" height="270" />

Caching dynamic content presents a multitude of problems but there are several ways to go about it. Instead of relaying on page caching or content caching I decided to push model caching to focus on saving database resources over web-server resources. Data::ObjectDriver has built in support for object caching and a light sprinkling of <a href="http://www.danga.com/memcached/">memcached</a> caching the several of the Catalyst controllers gave a noticeable increase in performance.

All of this is possible because of Catalyst. Catalyst is an elegant and well made MVC framework that lets the developer keep things as simple as possible and to keep things <a href="http://en.wikipedia.org/wiki/Don't_repeat_yourself">DRY</a>. Its extensive list of plugins let me focus on the web application, not on how to deal with sessions, authentication or any thing else that can distract me from my TODO list.
