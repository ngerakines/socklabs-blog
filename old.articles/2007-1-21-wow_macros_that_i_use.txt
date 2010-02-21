---
id: 1296
layout: post
title: >
    WoW Macros that I use
---

<p>I don't consider myself a power-player by any means but I have written a few macros that I've found to be really useful.</p>
<p><b>Guild Invite</b> - This quick macro makes it much easier to invite people to a guild. Instead of opening the social box and typing the name, you create a macro and drag the button to a bar then simply select the player and click the button.</p>
<blockquote>
/ginvite
</blockquote>
<p><b>Holy Combat</b> - This macro is a castsequence macro that initiates combat and runs through some basic spells. The castsequence command is pretty slick and lets you iterate through a list of spells. The reset=... test before the spells lets me say that the iteration when one of several things happen. Either combat is over, the target change or when I hold shift and click on the macro button. The sequence is per click, so when I click on a target and click on the macro the first time the 'Holy Fire' spell is cast. When I click the macro a second time the 'Shadow Word: Pain' spell is cast and so on.</p>
<blockquote>
/castsequence reset=combat/target/shift Holy Fire, Shadow Word: Pain, Shield
</blockquote>
<p><b>Follow</b> - This small macro targets the closest friend (party member) and follows them</p>
<blockquote>
/script FollowUnit("party1")
</blockquote>
<p><b>Quick Heal</b> - This macro is another cast sequence macro that casts 'Renew' on a player then 'Heal'.</p>
<blockquote>
/castsequence [help] Renew, Heal
</blockquote>
<p><b>Reverse View</b> - This macro flips your view to behind you. Useful when you need to run but still fire off spells.</p>
<blockquote>
/script FlipCameraYaw(180);
</blockquote>
