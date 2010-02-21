---
id: 922
layout: post
title: >
    Mailbox.pl
---

A while ago I wrote a small script ( see <a href="http://blog.socklabs.com/2006/03/07/email_feeds_with_procmail/">Email feeds with procmail</a> ) to create a summary rss feed for incoming mail. It runs every 10 minutes and gives me a nice view of my email activity.

I've updated the script and fixed some of the bugs. One of them being that I was using rss 2.0. It now uses XML::Atom to create and construct a very clean atom feed.

Usage is simple. Download the file, rename it to mailbox.pl and give it proper permissions (chmod 755). Open it with your favorite editor and change the default settings to reflect your own setup. You shouldn't need to change anything outside of lines 16 through 49.

<a href="http://blog.socklabs.com/mailbox.txt">Download mailbox.txt</a>
