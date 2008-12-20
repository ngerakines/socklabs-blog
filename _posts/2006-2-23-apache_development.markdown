---
id: 833
layout: post
title: >
    Apache development
---

I've been looking at ways of shifting responsibility with webservers. One of the ways that stands out the most is with image manipulation. In many ways we put alot of resource intensive load on our scripts and web app when it comes to image manipulation.

I thought to myself, if I could take one piece of code out of a web app and put onto the webserver it would be captcha creation and verification. So a few days ago I started on an apache module called mod_captcha. It will take all the work of creating captcha images and validating captcha images against user text.

Development has come along really well. The entire process has been real educating. The module framework is complete and now I'm looking at implementing image creaetion through GD and ImageMagick. I'll release code when its ready.
