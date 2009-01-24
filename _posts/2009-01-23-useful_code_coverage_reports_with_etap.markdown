---
layout: post
title: Useful Code Coverage Reports with Etap
---

This evening I added the etap\_report module to the [etap](http://github.com/ngerakines/etap) project. This module can be used to create nice looking, well-formatted html code coverage reports. This is a great way to get a quick view into your project's code coverage and determine what areas need to be focused on when creating test code.

Using the etap\_report module is simple. It exports the create/0 function which is called in the directory that your coverdata files are created in. The process looks something like this.

    $ cd ~/dev/erlang_protobuffs
    $ COVER=1 make test
    $ erl -eval 'etap_report:create()' -s init stop
    $ open protobuffs_report.html

An example can be found here: [http://ngerakines.github.com/erlang\_protobuffs/coverage/protobuffs\_report.html](http://ngerakines.github.com/erlang_protobuffs/coverage/protobuffs_report.html)

Just remember: [When do I test?](http://whendoitest.com/)
