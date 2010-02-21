---
id: 1340
layout: post
title: >
    WOW Realm Status Server
---

Last night I hacked up a quick little perl module that parses the <a href="http://www.worldofwarcraft.com/realmstatus/status.xml">realm status file</a> provided on <a href="http://www.worldofwarcraft.com/">worldofwarcraft.com</a> and stuffs the individual realm info into memcached for really really fast retrieval. 

Currently it runs on <a href="http://wrs.socklabs.com/">http://wrs.socklabs.com/</a> and has two parameters. They are 'realm' and 'type'. The 'realm' parameter is the exact name of the realm. The 'type' parameter is the output type. The default output type is 'json'. The type can also be 'xml'. The default realm if none is given is Medivh.

An example of the json output:

<code>[{"population":"Medium","status":"up","name":"Medivh","type":"Normal"}]</code>

Feel free to use it in anything you want. The script uses memcached and can really take a beating.

<i>Update 2007-05-04:</i> I've added two small features. The first is a javascript callback parameter. The next is the list type.

If a callback is named on the query string then the json response will be wrapped in a callback call. In other words '?type=json&callback=showRealm' would return the following:

<code>showRealm([{"population":"Medium","status":"up","name":"Medivh","type":"Normal"}])</code>

If the query string has a named type 'list' then the response will be a json formatted list of all of the servers it has the status of. This can be useful to see if a realm exists or not.
