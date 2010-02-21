---
id: 759
layout: post
title: >
    CloudNine 2.1
---

Some afternoon hacking this weekend yielded some productive results. Today marks the release of version 2.1 of CloudNine. This is considered a maintenance and minor feature release.

The first bug was found with categories that have capitol letters in them. Now the cloud will lowercase and scrub all labels going into the cloud creator. This scrubbing also includes converting spaces to underscores.

This release will also include entries with 1 or possibly no entries into the cloud.

This release now allows you to create a cloud from all blog categories. Note that this plugin doesn't automatically create category urls because of the complexity of hierarchies and such, but it will let you create global category clouds.

<pre>
&lt;MTCatCloud all="1">
&lt;span style="&lt;$MTCatCloudCSS$>">&lt;$MTCatCloudName$>&lt;/span>
&lt;/MTCatCloud>
</pre>

Get the latest release: <a href="http://blog.socklabs.com/wp-content/CloudNine-2.1.tgz">CloudNine-2.1.tgz</a>
