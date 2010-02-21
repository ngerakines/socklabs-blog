---
id: 1512
layout: post
title: >
    
---


Book: Facebook Application Development
--------------------------------------

Nick Gerakines is the author of the book "[Facebook Application Development](http://www.amazon.com/dp/0470246669/socklabs-20)" (John Wiley & Sons, Inc, published 2008). The book is part of the Wrox Professional Series and covers all aspects of Facebook application development. The book is packed with example projects and source code to give readers a very hands-on guide.

> Developing Facebook applications requires a different way of thinking than traditional web site development. This book guides you step by step through the process, covering topics and theory that can be applied immediately. It also highlights the various challenges and possibilities that you may encounter as you create your own feature-rich Facebook applications.
> 
> The author begins with a look at the Facebook Platform and explores the Facebook application basics. Next, he provides you with an example application to demonstrate some of the introductory concepts. The core components of the Facebook Platform are also presented along with examples and common use cases. You'll then delve deeper into the Facebook Platform to learn how to extend and enhance the applications you've already built.
> 
> This book will help you complete several introductory projects and progress to more advanced concepts. It arms you with the tools and know-how to inject new features and content into the Facebook environment.

Erlang Presentations
--------------------

In September of 2008 I spoke at the [CUFP](http://cufp.galois.com/) conference in Victoria BC about developing [Erlang at Yahoo](http://cufp.galois.com/2008/abstracts.html). The presentation lasted just under 30 minutes and was presented with Mark Zweifel about our experiences using Erlang in the Delicious production system.

Slides are available on request.

I've also given several presentations about Erlang to several groups including the [Bay Area Functional Programmers](http://www.bayfp.org/blog) group and EA.

I Play WoW
----------

[I Play WoW](http://www.facebook.com/apps/application.php?id=2359644980) is a Facebook applications that creates a bridge between the social worlds of Facebook and the World of Warcraft. It allows users to claim World of Warcraft characters to find and interact with other Facebook users that have done the same. I've gotten tremendous feedback from users and its been a lot of fun. At first the project was written in Perl using the Catalyst web framework over MySQL and Memcached. It was then ported to Erlang and is powered by Yaws, Mnesia, CouchDB and Erltl.

Misc GitHub Projects
--------------------

There are numerous projects and libraries available as open source software on Github. The majority of these projects are open source under the MIT license.

These projects include:

* [erlang\_twitter](https://github.com/ngerakines/erlang_twitter) -- An Erlang Twitter client. The twitter\_client.erl module provides an interface to the entire set of Twitter API methods as well as an efficient way of accessing those methods through user specific process templates.
* [WRS](https://github.com/ngerakines/wrs) is the "World of Warcraft Realm Status" project. Included is a daemon, wrsd, that actively monitors the realm status for the US/Pacfic World of Warcraft realms and allows individual status queries.
* [erlang\_geohash](https://github.com/ngerakines/erlang_geohash) is an open source Erlang library to encode and decode [Geohash](http://en.wikipedia.org/wiki/Geohash) tokens to and from latitude and longitude pairs.
* [erlang\_couchdb](https://github.com/ngerakines/erlang_couchdb) -- A CouchDB client written in Erlang.
* [erlang\_facebook](https://github.com/ngerakines/erlang_facebook) -- An interface to the Facebook Platform in the form of a simple gen\_server module.
* [facebook\_wiiinfo](https://github.com/ngerakines/facebook_wiiinfo/tree) -- An open source Facebook application written in Erlang.

CPAN Contributions
------------------

My [CPAN author page](http://search.cpan.org/~sock/) lists a number of my CPAN contributions and works. Some of them havn't been updated in a while, however I do regularly run through the associated test suites to make sure they still work.

