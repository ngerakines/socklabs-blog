---
id: 1457
layout: post
title: >
    Cloudnine 3.1 is almost ready
---

I'm working on some of the finishing touches on the latest CloudNine MovableType plugin. The focus of this release was simplicity because I felt like the 3.0 release added a lot of complexity with the addition of tag clouds. I also made a goal for myself to make it more xhtml+css friendly.

Instead of having seperate tag blocks for tag and category clouds there is one tag block called 'CloudNine'. By default it will create a tag cloud of the tags used on the blog, but by passing a 'type' argument you can easily switch to a category cloud, top tags (25) and recent tags.

In addition you can pass ' type="css" ' to create a clean css style that takes color settings from the plugin config.
