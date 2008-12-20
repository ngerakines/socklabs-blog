---
id: 831
layout: post
title: >
    Tagging and site organization
---

With the release of <a href="http://blog.socklabs.com/cloudnine/2006/02/20/cloudnine-30/">CloudNine 3.0</a> the site is now using tags as the primary way of organizing posts.

To make tags look more friendly, I'm using the following rewrite rules:
<blockquote><code>
RewriteRule ^tag/(.*)$ /mt-search.cgi?IncludeBlogs=3&tag=$1 [QSA,L]
RewriteRule ^cloudnine/tag/(.*)$ /mt-search.cgi?IncludeBlogs=7&tag=$1 [QSA,L]
</code></blockquote>
