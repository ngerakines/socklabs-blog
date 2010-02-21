---
id: 1562
layout: post
title: >
    Memoize Erlang function calls
---

The Erlang workshop has been a blast so far. Just wrote this quick snippet to memoize Erlang function calls. Enjoy!

Using it is pretty simple. Just start the memoize server and then send mfas to it.

> 1> memoize:start().<br/>
> 2> memoize:memoize(fun module:function/0, [Arguments]).

<script src="http://gist.github.com/13352.js"></script>

