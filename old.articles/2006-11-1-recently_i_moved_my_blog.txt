---
id: 1188
layout: post
title: >
    Perlbal and Apache2 logging
---

Recently I moved my blog over from a hosted server to a <a href="http://dev.socklabs.com/">personal machine</a>. Visitors shouldn't see anything different but the infrastructure has changed. First of all I'm using Apache 2.0 and FastCGI to power Movable Type. <a href="http://www.bradchoate.com/">Brad Choate</a> wrote a <a href="http://www.bradchoate.com/weblog/2005/08/26/mt-32-and-lighttpd-fastcgi">really good article</a> explaining how to do this.

In front of Apache I have a squid server acting as a cache. Among other reasons and webservices on my server, on my blog I use tags pretty heavily and wanted to be able to cache the output of the tag page views. Squid does an excellent job at doing just that.

Finally, the last piece of the puzzle is perlbal. I use <a href="http://www.danga.com/perlbal/">Perlbal</a> to act as a loadbalancer and delegation service to dispatch requests to the right place. It works out great because it lets me run multiple services and webservers (like <a href="http://blog.socklabs.com/">blog.socklabs.com</a> and <a href="http://www.infanttracker.com/">www.infanttracker.com</a>) on the same machine without anyone knowing otherwise.

The issue I had was with the apache log files. I installed <a href="http://awstats.sourceforge.net/">awstats</a> to crunch at the apache logs and give me meaningful information from the mess of data. I noticed pretty quickly that every single request was coming from the same place and quickly realized that this was because apache thought that the request was coming from perlbal or squid, not the outside world. <a href="http://bradfitz.com/">Brad</a> told me about <a href="http://stderr.net/apache/rpaf/">mod_rpaf</a> and in a matter of minutes, after a '<i>make rpaf-2.0</i>' and some apache config + restart, everything worked fine.
