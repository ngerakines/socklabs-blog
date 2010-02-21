---
id: 1541
layout: post
title: >
    Erlang Snippet: Remove stale iplaywow cache files
---


> `Now = calendar:datetime_to_gregorian_seconds(erlang:universaltime()), [begin {ok, [\{\{time, Time}, _}]} = file:consult(File), case Time < Now - 14400 of true -> file:delete(File); _ -> ok end end || File <- filelib:wildcard("cache/*")].`

*Updated* This snippet now lives in gist: [http://gist.github.com/1843](http://gist.github.com/1843)
