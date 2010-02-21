---
id: 1452
layout: post
title: >
    Creating Stylesheets with CloudNine
---

I've had a few users ask me if it would be possible to separate the css from the items in the cloud. After trying a few different things I've found a temporary solution.

In <a href="http://blog.socklabs.com/cloudnine/2006/02/20/cloudnine-25-released/">release 2.5</a> there were a few changes made to make it much easier to do this. Mainly the addition of the CatCloudCSSID tag. Look at the following example and consider ways to adjust it to your own templates.

The CSS:
<blockquote>
&lt;style>
&lt;MTCatCloud>
.&lt;$MTCatCloudCSSID$> {
    &lt;$MTCatCloudCSS$>
}
&lt;/MTCatCloud>
&lt;/style>
</blockquote>

The cloud:
<blockquote>
&lt;MTCatCloud>
&lt;a href="http://blog.socklabs.com/tags/<$MTCatCloudStub$>" class="&lt;$MTCatCloudCSSID$>">&lt;$MTCatCloudLabel$>&lt;/a>
&lt;/MTCatCloud>
</blockquote>
