---
id: 1333
layout: post
title: >
    Disabling spotlight
---

<p>I've been a mac convert for, almost, 2 years now and I really love my machine. One of the things I don't really like or use is Spotlight. Every now and then I'll accidently hit the wrong key which will bring up the Spotlight search window and muck up window focus and everything. I also figure that there is no reason keeping the indexes up to date on my harddrive if I'm not using them so I started searching for a way to disable it.</p>
<p>First disable Spotlight by making a quick edit in /etc/hostconfig</p>
<pre>
< SPOTLIGHT=-NO-
---
> SPOTLIGHT=-YES-
</pre>
<p>Then turn off indexing on the root volume and clear the old indexes.</p>
<pre>
mdutil -i off /
mdutil -E /
</pre>
