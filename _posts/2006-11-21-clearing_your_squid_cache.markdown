---
id: 1211
layout: post
title: >
     Clearing your squid cache
---

<p>I've found that sometimes doing a simple purge request to a squid cache just doesn't cut it. This is what I've found to be the best practice for starting with a completely clean squid cache.</p>
<pre><code>export SQUIDCACHE=/var/cache/squid
cd $SQUIDCACHE
mkdir JUNK
mv ?? swap.state* JUNK
rm -rf JUNK &
squid -z</code></pre>
<p>Depending on the size of your cache it could be a while to delete everything. Move everything over to a junk folder and delete the junk folder in the background so you can create the new squid cache directory tree and start the squid server as soon as possible, minimizing downtime.</p>
