---
id: 1573
layout: post
title: >
    Erlang portage overlay
---

I've posted the portage overlay that I use for my Erlang projects. The sources are downloaded from tagged GitHub repositories and all ebuilds have been tested and verified on a fresh 2008.0 Gentoo environment. It assumes that you are using the most recent dev-lang/erlang package based on Erlang/OTP 12-4. I've decided to build and test all of these packages using the standard dev-lang/erlang package instead of using a custom build, so please keep that in mind when preparing your system.

Current ebuilds include:

 * erlang\_twitter
 * erlang\_couchdb
 * erlang\_facebook
 * etap
 * mochiweb

I'm planning on creating ebuilds for the rest of my GitHub projects and then looking at what else is out there. 

Check it out: [http://github.com/ngerakines/erlang_portage/](http://github.com/ngerakines/erlang_portage/)

