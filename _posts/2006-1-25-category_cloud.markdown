---
id: 740
layout: post
title: >
    Category Cloud
---

<em>Update:</em> The <em>CategoryCloud</em> plugin has been renamed to <a href="http://blog.socklabs.com/cloudnine/">CloudNine</a>. Please go to the <a href="http://blog.socklabs.com/cloudnine/">CloudNine project blog</a> for any and all updates, documentation and downloads.

There are also several posts around this blog that have been tagged <a href="http://blog.socklabs.com/tags/cloudnine/">cloudnine</a> that may contain usefull information, but the CloudNine project page is where you really want to go.

---

CategoryCloud is a plugin for MovableType that allows users to generate weighed clouds based on the number of posts a category has.

<a href="http://blog.socklabs.com/wp-content/CategoryCloud.tgz">Download 1.0 </a>

To use this just download and extract into the plugins directory and adjust your templates:

<blockquote>
&lt;MTCatCloud>
&lt;!-- &lt;$MTCatCloudWeight$> -->
&lt;a href="http://example.com/blog/category/&lt;$MTCatCloudName$>" style="&lt;$MTCatCloudCSS$>">&lt;$MTCatCloudName$>&lt;/a>
&lt;/MTCatCloud>
</blockquote>
