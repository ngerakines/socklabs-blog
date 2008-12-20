---
id: 1519
layout: post
title: >
    Tag clouds in Erlang with ErlyWeb
---


**Updated** This article was updated to incorporate several changes to the tagcloud.erl module. Thanks Ulf!

There are plenty of ways to render [tag clouds](http://en.wikipedia.org/wiki/Tag_cloud) and Erlang is no exception. With these two small modules you render tag clouds in [ErlyWeb](http://erlyweb.org/). The logic is pretty simple and could be applied to any other tempting system with little effort.

**Listing 1-1: The tagcloud.erl module.**

	-module(tagcloud).
	-export([create_cloud/1, tag_size/4]).
	
	create_cloud([]) -> [];
	create_cloud(Tags) ->
	    AlphaSortedTags = lists:keysort(2, Tags),
	    Counts = [C || {C, _} <- Tags],
	    Max = lists:max(Counts),
	    Min = lists:min(Counts),
	    Diff = Max - Min,
	    Dist = Diff / 3,
	    [{Name, Count, tagcloud:tag_size(Count, Min, Max, Dist)} || {Count, Name} <- AlphaSortedTags].
	
	tag_size(Count, Min, Max, Dist) ->
	    if
	        Count == Min -> smallest;
	        Count == Max -> largest;
	        Count > Min + (Dist * 2) -> large;
	        Count > Min + Dist ->  medium;
	        true -> small
	    end.


In the tagcloud module, the main function used to generate the cloud is create\_cloud/1. That function takes a list of tuples representing tags and their counts. The list is then sorted and the largest and smallest values extracted from the list. It is here that we also calculate the spread and distance between tags.

For each tag the size of the tag is calculated. Based on the max, min and distance values, an atom representing the tag size is associated with the tag and a new list is returned. At first this was done with a separate function that iterated through the list of tags and determined the size. Ulf Wiger pointed out a better way to do this is through a simple list comprehension. Now, the tags are sent through a list comprehension that calls a function to determine the tag size and the final list is returned to the function caller.

	1> RawTags = [{15, "erlang"}, {9, "perl"}, {12, "erlyweb"}, {17, "yaws"}].
	[{15, "erlang"}, {9, "perl"}, {12, "erlyweb"}, {17, "yaws"}].
	2> Tags = tagcloud:create_cloud(RawTags).
	[{"erlang",15,large},
	 {"erlyweb",12,medium},
	 {"perl",9,smallest},
	 {"yaws",17,largest}]
	

Now we can feed in the processed list of tags into the display_tag_cloud/1 function as part of the tagcloudt.et template file. The template does nothing more than apply the style that has already been calculated based on the size atom by iterating through the list of tags and associating a css class to each.

**Listing 1-1: The tagcloudt.et template.**

	<%@ display_tag_cloud(Tags) %>
	<% tag_style() %>
	<div style="padding: 5px;"><% tag_cloud(Tags) %></div>
	<%@ tag_cloud(Tags) %><% tag_cloud_tag(Tags) %>
	<%@ tag_cloud_tag([]) %>
	<%@ tag_cloud_tag([{Name, Count, Size} | Tags]) %>
	 <a href="http://blog.socklabs.com/tag/<% Name %>" class="<% Size %>Tag"><% Name %></a><% tag_cloud_tag(Tags) %>
	<%@ tag_style() %>
	<style>
	.smallestTag { font-size: xx-small; }
	.smallTag { font-size: small; }
	.mediumTag { font-size: medium; }
	.largeTag { font-size: large; }
	.largestTag { font-size: xx-large; }
	</style>

Just add the template file with the rest of your ErlyWeb templates. You can call the display\_tag\_cloud from any of your templates.

	...
	Tags:<br/>
	<% tagcloudt:display_tag_cloud(Tags) %>
	...

It couldn't be easier.
