---
id: 99
layout: post
title: >
    Regex tips
---

I've been doing far more regex than I'd like lately. These are a few handly little regular expression bits that I find most helpful.

To weed out most urls you can use the following:

<blockquote><code>s/(((http|https|file|ftp):)?//)([wd-.]+)(/[^s]+)?(/)?/ /gi</code></blockquote>
