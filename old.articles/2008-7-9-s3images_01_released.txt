---
id: 1538
layout: post
title: >
    S3Images 0.1 released
---

Tonight I hacked away at an Erlang application call [s3images](http://github.com/ngerakines/s3imagehost/) that lets you store and  request images. That may seem kind of plain, but real juju is that it uses Amazon S3 as the permanent storage mechanism. The application is pretty basic right now and is available on GitHub.

The idea is inspired by MogileFS and Perlbal. The feature complete goal is to have a webservice that you can post images to that will store the content on amazon s3 and when an image is requested it will find the image on amazon s3 and re-proxy it back to the user for a seamless experience. As it grows and develops there is plenty of room for frequently requested image caches and activity/usage statistics.

It uses yaws, mnesia, the [s3](http://www.nobugs.org/developer/s3erl/) module and [erltl](http://www.erlyweb.org/). Check the [README](http://github.com/ngerakines/s3imagehost/tree/master/README) file for information on how to build, configure and start the service. 

The motivation for building this application is due to the really crappy image gallery feature in [I Play WoW](http://www.facebook.com/apps/application.php?id=2359644980) and the need/desire to overhaul it. My goal is to have production-ready version by Friday to deploy for initial testing and use by Saturday.
