---
id: 1542
layout: post
title: >
    I Play WoW on CouchDB
---

[I Play WoW](http://www.facebook.com/apps/application.php?id=2359644980) was originally built as a [Catalyst](http://search.cpan.org/dist/Catalyst/) application with Memcached and MySQL as a data store and caching layer. It worked perfectly on my little server until the 30,000th user or so and started to choke on memory. Then I moved it to a dedicated machine and bumped it to 2g of ram and it was happily chugging along until the 60,000th user where it started to choke again.

Around that time I rewrote the entire thing into an Erlang application. Doing so was a real interesting crash course in not only building multi-part Erlang applications but also about migrating data into them. The entire userbase was ported over from MySQL to mnesia (fragmented) and all was good.

In fact things are still good. After doing so I saw that app use increased, there were far fewer errors and crashes and I even downgraded the server to a 512 meg slice ([I love SliceHost](https://manage.slicehost.com/customers/new?referrer=506856932)) and it barely uses 10% of the system's resources.

Lately I rewrote the image gallery functionality of the site away from Facebook's native image/gallery stuff into a distributed, Amazon S3-backed Erlang app (open source and [on GitHub](http://github.com/ngerakines/s3imagehost) I might add).

My interest in [CouchDB](http://incubator.apache.org/couchdb/) has also been ignited. I've been reading a ton of information on it and I'd really love to get my hands dirty. I think that CouchDB would be perfect for some of the features that I'm planning to push soon. I'm still in the planning-phase right now, but I'm moving very quickly toward moving chunks of data over to it.


