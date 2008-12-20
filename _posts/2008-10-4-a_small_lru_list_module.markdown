---
id: 1564
layout: post
title: >
    A small LRU list module
---

A small LRU list module

In the upcoming Erlang Web Services book that I'm working on I need a small LRU list and didn't find one in the stdlib so I decided to write one. It's available on GitHub as gist 14833.

Note: This was a really quick module. It should be considered untested and there has been no work or thought put toward performance improvements. Use at your own risk. Comments, feedback and forks are welcome.

Using it is like using any of the other container modules in the stdlib. Create the list and pass it around when writing *and reading* it. Because read ops can affect the contents, please keep in mind that reading values from this list could potentially create a new list.

For example uses see the test\_one/0 or test\_two/0 function calls.

<script src="http://gist.github.com/14833.js"></script>

