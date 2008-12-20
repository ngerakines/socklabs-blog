---
id: 719
layout: post
title: >
    Migrating from Wordpress to Movable Type
---

Google yielded very few results on the matter, Although I'm not totally surprised. There isn't much discussion about it and I really havn't met anyone else thats done it either. So here we go.

I started with a very basic MT installation ( mysql db, static page output ). The installation alone took about 10 minutes plus tweaking it to my liking. Then I started wondering how I could move the 3+ years of posts over without loosing any of it. I did some searching and found a few plugins for WP here and there, but I was using Wordpress 2.0 and none of them were compatible with the update DB schema. My next thought was about doing a recreation of the SQL and injecting it all directly into the database. I quickly found that there are far too many inconsistencies for that to work quickly and easily.

So then I started thinking about XMLRPC and API calls. Both MovableType and Wordpress support many XMLRPC calls and doing a direct app to app migration would be great. MovableType and Wordpress don't really know how to talk to each other so there would need to be a middle man acting as a relay for information. I started writing a set of perl modules that would act like a communications relay between two blogging platforms called <a href="http://blog.socklabs.com/wp-content/WWW-Blog-Move-0.01.tar.gz">WWW::Blog::Move</a>. After some tweaking and cleanup I think it is ready for an initial release.

The idea is pretty simple. Have an application do a set of calls from blog a and then a set of writes to blog b. It isn't terribly complex although I do have some more features planned.

What this didn't do was transfer categories, comments or trackbacks. To preserve the categories on posts I had to recreate all of the categories before I started the transfer. The app will get category lists from both blogs and map the ids to each other, but they need to be on blog b first. It can't create categories that don't exist.

Aside from that, it went very smoothly. The next step was hacking the templates that MT used. Some of the css was wonky, but it didn't take long. Now, as you can see, the blog is fully functional and most of the links work just fine.

After all was said and done, it was time to test. The issues that I found were related to links and urls. I wrote some apache rewrite rules to transition old urls to new urls. After a few rules to redirect the feeds and special pages, it was done.

The final product: <a href="http://blog.socklabs.com/">http://blog.socklabs.com/</a>

Send over your questions or comments.
