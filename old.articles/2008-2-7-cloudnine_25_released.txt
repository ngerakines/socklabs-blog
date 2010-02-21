---
id: 1450
layout: post
title: >
    CloudNine 2.5
---

CloudNine has been improved and tweaked and the 2.5 release is ready. This release includes some improvements to category label display and linkage. This release also makes it easier to seperate css and html as per user request. Also in this release was a fix to allow users to set the font size types, aka pt or px.

Please make note of the changes in syntax when building clouds. The tag MTCatCloudName is being phased out and replaced by MTCatCloudLabel. Two additional tags, MTCatCloudStub and MTCatCloudCSSID, have also been added.

Here is an example of usage:
<blockquote>
&lt;MTCatCloud>
&lt;a href="http://blog.socklabs.com/tags/&lt;$MTCatCloudStub$>" style="&lt;$MTCatCloudCSS$>">&lt;$MTCatCloudLabel$>&lt;/a>
&lt;/MTCatCloud>
</blockquote>

<a href="http://blog.socklabs.com/wp-content/CloudNine-2.5.tgz">Download CloudNine-2.5.tgz</a>
