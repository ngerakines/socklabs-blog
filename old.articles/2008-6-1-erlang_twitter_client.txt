---
id: 1532
layout: post
title: >
    Erlang Twitter client
---

Last night I started an Erlang Twitter client. The module allows you to start a twitter\_client process with a username and password and then make Twitter API calls from that process. Implemented API calls include verify\_credentials, public\_timeline and friends\_timeline with more on the way. I'd also like to add API throttling and content caching.

[http://github.com/ngerakines/erlang_twitter](http://github.com/ngerakines/erlang_twitter)
