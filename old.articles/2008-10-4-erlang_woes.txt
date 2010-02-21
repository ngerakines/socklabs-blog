---
id: 1565
layout: post
title: >
    Erlang woes
---

This evening I wrote a small [LRU (least recently used)](http://en.wikipedia.org/wiki/Cache_algorithms) [container module](http://blog.socklabs.com/2008/10/a_small_lru_list_module/) for a project that I'm working on and ran into an annoying issue. Which standard of accessor names do I use? This may seem trivial but it leads to a bigger issue: inconsistency in the standard library.

Let's consider 5 basic components that generally apply to all types of containers. Creating new containers, adding items, determining if an item exists, removing items and iterating through all items. Comparing the gb\_trees, gb\_sets, array, orddict, queue and sets modules can give you the run-around.

To create a new gb\_trees variable you use `gb_trees:empty()` but to create a new queue you'd do `queue:new()`. To get retrieve the value for a key out of a gb\_trees variable you'd do either `gb_trees:get/2` or `gb_trees:lookup/2`. To do the same thing with the orddict module you'd do `orddict:fetch/2`. To do the same thing with the proplists module you'd do `proplists:get_value/3`. The queue module even implements multiple getters and setters that do the exact same thing. See where I'm going with this?

With the growth that the Erlang community is seeing, it would be great if there was some unified way of build blocks like this. I've seen people making proof of concept modules for different types of containers and algorithms, but they end up doing things their own way. If I want to implement a simple gen\_server whose state is a container, I should be able to switch out the container type with little effort. The same idea holds true for plenty of other ideas and concepts.

How could this be done? Documentation and a good example are probably the best ways to go about this. Having a container behavior that you would implement would be even better. Do I expect the OTP maintainers to reorg a bunch of the stdlibs any time soon? No, but it'd be really nice if they started thinking about a standards body or document procedure for this sort of thing.
