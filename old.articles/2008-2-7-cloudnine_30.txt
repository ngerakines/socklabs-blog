---
id: 1453
layout: post
title: >
    CloudNine 3.0
---

CloudNine 3.0 is ready for the world. And when I say world, I mean people who are running MovableType 3.3 with tagging support. Today has been overly productive and the 3.0 release comes with some really cool features.

There is a new container called MTCNTagCloud which allows you to create clouds based on actual MT::Tag objects. It will also show different results depending on if the cloud was created inside of an Entry or not.

<blockquote>
&lt;MTEntries>
&lt;$MTEntryTitle$>&lt;br/>
Tags: &lt;MTCNTagCloud glue=", ">
&lt;a href="http://blog.socklabs.com/tag/&lt;$MTCNTagStub$>">&lt;$MTCNTagLabel$>&lt;/a>
&lt;/MTCNTagCloud>
&lt;/MTEntries>
</blockquote>

<blockquote>
&lt;MTCNTagCloud glue=", ">
&lt;a href="http://blog.socklabs.com/tag/&lt;$MTCNTagStub$>" style="&lt;$MTCNTagCSS$>">&lt;$MTCNTagLabel$>&lt;/a>
&lt;/MTCNTagCloud>
</blockquote>

<em>This release is only known to be compatible with MovableType 3.3 It is not guaranteed to work with release prior to 3.3.</b></em>

<a href="http://blog.socklabs.com/wp-content/CloudNine-3.0.tgz">Download CloudNine-3.0.tgz</a>
