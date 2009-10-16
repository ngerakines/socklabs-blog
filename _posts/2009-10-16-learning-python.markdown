---
layout: post
title: Learning Python
---

I wrote my first Python/Django app a few days ago, "Top Rupture Games". It was a fun little project for a few reasons. First of all, I've been wanting to play with Rupture data for a little while know and had some time over the weekend to see what I could do with it. Second, I've been itching to play with Python, and subsequently Django, ever since being introduced to it over at Mythic a few months ago. Lastly, I wanted to create a Rupture client library, even if it's just a proof of concept, in Python.

Out of this venture came two new projects on GitHub. The first is [pyRupture](http://github.com/ngerakines/pyRupture), a native Python library/module for interfacing with Rupture. It uses the Python Protocol Buffers library/modules to make API calls against Rupture. It only supports the API calls that I needed for the rupture-stats project, but it's really easy to extend.

The second is [rupture-stats](http://github.com/ngerakines/rupture-stats), a Django project that uses pyRupture to compute and display a list of the top games on Rupture and render a graph of recent gaming activity. You can see a demo of it in action at [http://67.207.133.142/](http://67.207.133.142/).

Without going into too many details, the flow of creating and sorting games by popularity isn't that complex. Every n minutes the app pulls the recent game activity feed and creates an internal list of recently played games. Then, it goes through the process of fetching the feeds for each of those games and aggregates the number of game sessions by day. Once it has that list, it removes any games that have either no recent activity and stores the computed information. The games are ranked via a "score" which is the total number of game sessions over a 21 day period and they are displayed on render.

To generate the graphs, I used the Google Charts API with a list of the number of game sessions over the past n days, filling any any days that didn't have any with 0s.

Both projects are open source under the MIT.
