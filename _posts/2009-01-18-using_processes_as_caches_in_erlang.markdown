---
layout: post
title: Using processes as caches in Erlang
---

When I'm talking to someone who is new to Erlang, I go out of my way to tell them one very specific thing: Erlang will change the way you write software. I was playing around with a few features in I Play WoW recently, one of which is quasi-dynamic links to wowinsider.com on the My Characters page.

The feature is relatively simple. On the My Characters page, display links for 3 to 5 of the most recently published articles on WoWInsider. This requires some minor RSS/ATOM parsing and a web request. All-in-all, it's a nice feature and something that I think my users would like.

The implementation is pretty simple as well. The module exports a few functions that return articles based on a given RSS feed. The content returned is a list of tuples containing the article title and link. The special sauce of the module is the use of a process to store a cache of articles based on fetch time. When articles are requested, a process is queried to determine if it has a cache and, if it does, should the cached list be refreshed.

<script src="http://gist.github.com/48763.js"></script>

This feature went live last night and although the article cache isn't distributed, the data is small enough to cache on each web interface application.
