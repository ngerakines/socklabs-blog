---
layout: post
title: Armory3, a proof of concept RabbitMQ application
---

I've been having a lot of fun with [RabbitMQ](http://www.rabbitmq.com/) lately, the most recent accomplishment being porting the armory2 module to use a RabbitMQ queue instead of an ets table.

With that said, this is the result of that work. The [armory3](http://github.com/ngerakines/erlang_wowarmory/commits/master/src/armory3.erl) module is an extension of the armory module in the [erlang\_wowarmory](http://github.com/ngerakines/erlang_wowarmory) project on GitHub. It is a distributed World of Warcraft Armory character and guild retrieval and processing library. The obvious benefit of doing it this way is that you've got the power of a RabbitMQ application powering your queue and work list, allowing you to gut the complexity of queue processing from your application. The downside is that if RabbitMQ goes down or there is some sort of unexpected hiccup along the way, you may feel some pain.
