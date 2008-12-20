---
id: 1421
layout: post
title: >
    Multi user screen sessions
---

<div>Josh and I found out how easy it is to setup multiuser screen sessions. Scary easy.</div><div><br class="webkit-block-placeholder" /></div><div>As usera</div><div><br class="webkit-block-placeholder" /></div><div>  screen -S mail</div><div>  &gt; ctl+a, :multiuser on</div><div>  &gt; ctl+a, :acladd userb</div><div><br class="webkit-block-placeholder" /></div><div>As userb</div><div><br class="webkit-block-placeholder" /></div><div>  screen -r usera/mail</div><div><br class="webkit-block-placeholder" /></div>
