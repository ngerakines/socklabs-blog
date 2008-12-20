---
id: 1062
layout: post
title: >
    Distributed web serving with MogileFS
---

Some of the great minds of LJ created a very fast and efficient distributed file store system called <a href="http://www.danga.com/mogilefs/">MogileFS</a>. Over the past few days I've been working on a module that lets you migrate from serving files using traditional web-servers like apache to using <a href="http://www.danga.com/perlbal/">perlbal</a> + mogileFS in conjunction with Apache.

Thus, <a href="http://search.cpan.org/~sock/Apache2-Mogile-Dispatch/">Apache2::Mogile::Dispatch</a> is born. This module aims to be an easy way to dispatch incoming requests through an apache module which decides if the url is to be handled through mogile, perlbal or reproxied to a legacy web server. This simplifies the process of migrating to mogile for small to very large websites.

Right now the module is available on cpan but is a developer release. There are a few things that I'd like to do like adding a cookbook module with more examples, adding stronger tests, and so forth. Feedback is strongly encouraged.
