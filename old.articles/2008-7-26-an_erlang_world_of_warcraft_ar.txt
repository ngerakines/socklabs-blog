---
id: 1544
layout: post
title: >
    An Erlang World of Warcraft Armory client ... and more
---

I've been really crunching lately to give [I Play WoW](http://www.facebook.com/apps/application.php?id=2359644980) some serious love before I get too involved in my next book. I've been heavily invested in the [Things](http://culturedcode.com/things/) application, plowing through tasks and bugs like it's nobody's business.

There are three major things on the plate right now. The first is, and now was, an overhaul of the image upload system. I'm pretty happy with the [s3images](http://github.com/ngerakines/s3imagehost/) project, and so far it has been relatively low-maintenance. 

The second is the introduction of [CouchDB](http://incubator.apache.org/couchdb/) into the mix of I Play WoW technologies. I'm really excited to say that I've made a major dent and I've got an active and working CouchDB instance serving I Play WoW users. The load is relatively low, but there are a few hundred thousand documents in the system now and things are looking up. I'd love to write more about that experience, but I'm going to hold off until I feel comfortable enough to say that there is no going back.

The third goal includes introducing an external component to I Play WoW. I've got lots of data from over a year of use about how Facebook users use the application and connect with people. I'm eager to start opening up the floodgates and making parts of the application available to non-Facebook users. This feature is still on the drawing board and may be scrapped entirely, but I'm feeling good about what I've got so far.

In and around all of this activity, I feel compelled to open up as much as possible. With that said I posted the Erlang library that I use to connect to the armory. [erlang\_wowarmory](http://github.com/ngerakines/erlang_wowarmory) is a simple gen_server based Erlang module that allows you to throttle World of Warcraft Armory requests and handle them in an offline manor. See the library and README file for more information.
