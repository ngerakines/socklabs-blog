---
layout: post
title: Erlang Library Best Practices
---

[Joe Williams](http://www.joeandmotorboat.com/) wrote a pretty nifty [Erlang memcached client](http://github.com/joewilliams/merle/tree/master) recently and posted it to GitHub. I sent him some pointers and after writing it, decided it was worth posting.

 * If you've got a library dedicated to interfacing with a particular service, keep the function names simple and direct. Instead of having merle:memcached_set/2, keep it at merle:set/2.

 * In most cases, it's best to directly interact with the target service as opposed to providing an additional layer such as a gen\_server or process. This is something I did with the couchdb, twitter and facebook client libraries. There are some situations where you do want to allow for things like throttling, server settings storage, etc in your client library, but I really don't think that you'll have one of those situations with this one. I'd much rather make a call like merle:set(Server, Key, Value) that directly hits the memcached server than something that may have to sit in a gen\_server message inbox/queue before being executed.

 * Write tests! This sort of thing really needs a test suite. You may even want to investigate creating a mock memcached server that your test suite runs and can push requests against. 

 * Define a good license and add it to the top of each of your source files. I recommend either the MIT or the Mozilla.

 * Use edoc. At the very least add @doc for public functions and @private for internal functions. It only takes about 5 minutes to set one line descriptions for a module and about 20 functions. With GitHub you can publish all of the docs for the project using the gh-pages branch (see [http://ngerakines.github.com/erlang_facebook](http://ngerakines.github.com/erlang_facebook) as an example).

 * For official releases, publish dist-src packages in your gh-pages branch. I keep source tarballs in the "/sources" for all of the packages that I do that with. Makes it really easy to have your packages integrated in system packages like gentoo ebuilds, rpms or debian packages.

 * Use a Makefile or Rakefile to make it easy for people to build and install the package. This is a good practice and enables more wide-spread adoption of your library.

There were some other notes but they were specific to the merle library. All of this got me thinking about putting together a Best Practices wiki or git repository where people can contribute their knowledge and snippets. 
