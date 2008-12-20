---
id: 1552
layout: post
title: >
    erlang_facebook 0.1r1
---

This morning I wrote a small Erlang library to interface with the Facebook Platform API. I've been using something similar in I Play WoW and finally got around to cleaning it up and putting it out there. It is inspired by [Brian Fink](http://beerriot.com/bryan.html)'s [erlang2facebook](http://code.google.com/p/erlang2facebook/) project but doesn't use any of it's code.

> [http://github.com/ngerakines/erlang_facebook/](http://github.com/ngerakines/erlang_facebook/)

The big different is that with this module you don't have to bake your API key and secret into the module. The library is based on the gen\_server behavior (like most of the other API libraries I write) and is very flexible. Out of the box it can handle a very small number of Facebook Platform API methods directly but also provides a simple way to use API methods that the library doesn't know about. See the [README.markdown](http://github.com/ngerakines/erlang_facebook/tree/master/README.markdown) file for more information and a few small examples.

This is only a release candidate and shouldn't be used in a production setting quite yet. The interface is bound to change and there are a number of incomplete features.

This module also requires the [rfc4627](http://hg.opensource.lshift.net/erlang-rfc4627/) JSON module because it uses JSON as the default format for Facebook Platform API requests.

The 'TODO' list includes better out of the box Facebook Platform API method support, xml response parsing, better error handling and real documentation.

This project is open source under the MIT license. 
