---
id: 1546
layout: post
title: >
    More on deploying CouchDB for I Play WoW
---

So its been well over 48 hours with CouchDB as a major data source for the I Play WoW Facebook application. It has been a lot of fun moving over to it and rethinking the way that some things are being done. This is sort of a quick overview of why I wanted to move over and what I got and lost doing so.

CouchDB represents where data storage systems are going and I want to know as much about it as possible. The data structures that I Play WoW uses lend themselves to CouchDB very well. I also really like the model that CouchDB follows with document revisions.

* Win: I'm not bound to table columns! If I want to start supporting  additional fields for characters, I just have to start using them. I don't have to perform table maintenance or require data-store downtime to develop features.
* Win: CouchDB's RESTful JSON over http interface makes caching super simple with something like Varnish. MySQL had some nifty caching internals for frequent queries, but I think the randomness of I Play WoW diminishes the value of them. To my knowledge Mnesia didn't do much at all regarding query caching.
* Win: Another very nice perk to using JSON over http is that I don't need x, y or z libraries to use it. I wrote a really simple (under 200 lines) erlang module for I Play WoW and most of my testing and development just used curl.

        curl -X POST --data '{ "map" : "function(doc) { if (doc.version == 2) { emit(doc.crc, [doc._id, doc._rev, doc.name, doc.version, doc.realm]); } }" }' --header "Content-Type: application/json" http://127.0.0.1:5984/iplaywow/_temp_view

* Win: Views rock! Using view collation I've cut down what would be the number of queries that I have to execute. Loading a guild or realm page is now just one http request as opposed to 3-5 queries.
* Win: The flexibility of "loose" documents let me do really cool things like character versioning. With the World of Warcraft Armory crawler now using CouchDB when I fetch character information and determine that it is newer than what I'm already storing I can archive the old document and create a new character document with an incremented version. The views for characters, guilds and realms use these versions to retrieve the latest versions of characters. I'm excited about this the most because it gives me the ability to develop features that let you "diff" character versions.
* Compromise: I'm not sure if views are as snappy as Mnesia or MySQL queries. Doing direct document fetching is really quick but sometimes it takes a little longer than I expect with complex views. I'm pretty confident that as the project matures this will become less and less of an issue. Varnish also helps.

Right now the main database that I'm using has just over 350,000 documents representing characters, realms and guilds. I've got about 20 views for different things and still exploring ways to better utilize them. I'm still using Mnesia for some things, but I'm actively developing and exploring ways to move away from it.

What I really want to do is find a way to snapshot a table and freeze it on Amazon S3 or something. It'd be really cool to be able to fire up an EC2 instance the creates a replicator that dupes data up to a certain point, dumps the data to some sort of backup file, pushes it to S3 and destroys itself. 
