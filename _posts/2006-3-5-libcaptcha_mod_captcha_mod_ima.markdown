---
id: 844
layout: post
title: >
    libcaptcha, mod_captcha, mod_image and more
---

Fact: People have pictures. Usually lots of them. Images need manipulation. Image manipulation is expensive.

I've been using with libgd and imagemagick to see how image manipulation works and how it can be improved. There are tons of php and perl libraries to do this sort of thing, but it is my thinking that those sort of things only make the relatively simple processes more expensive.

In this day and age we are really starting to look at shaving and optimizing. Cutting down on memory usage or making functions faster. Getting rid of access resource usage and cutting down code.

One of the ways I think this can be done in regard to image manipulation is by doing it at the web server level instead of the application level. If we started putting some of the higher level logic of image manipulation into compiled code, we could really start improving the performance of our logic. 

I've already started libcaptcha, a library to let people create captcha images by using a wide variety of filters, schemas and variations, and will want to have a non developer release ready before I shift agendas. Keep in mind that libcapthca is only the beginning. I've already started writing specs for mod_imaagemanip, a location based image manipulation apache module.
