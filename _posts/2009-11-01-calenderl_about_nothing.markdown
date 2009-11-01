---
layout: post
title: CalendERL About Nothing
---

Recently I create a site called [CalendERL About Nothing](http://www.calenderlaboutnothing.com/). I've used the original [Calendar About Nothing](http://www.calendaraboutnothing.com/) for a long time and played with the idea of rewriting it in Erlang. I finally made the leap and as a result the [cerlan](http://github.com/ngerakines/cerlan) and [githubby](http://github.com/ngerakines/githubby) projects were born.

If you don't know what CAN is, it is a site that tracks your GitHub commits and creates a calendar based on your activity. Each day that you commit to a public project, you get a big red "X". The more you commit, the more "X"s are displayed and you can build streaks. A streak is simply a set of more than one days where you've made commits. The site will track your current streak, assuming you've made a commit that day, and your longest streak. You can use [my calender](http://www.calenderlaboutnothing.com/~ngerakines) as an example.

There are a few reasons why I decided to create this site.

 * I love a good challenge. 
 * There aren't enough open source Erlang sites out in the wild.
 * I've been looking for a good excuse to write a GitHub API client library in Erlang.
 * I didn't like the fact that CAN doesn't use the GitHub API and instead uses user feeds.
 * I think Erlang is better suited to support concurrent data processing applications than Ruby is.

The site is currently live at [http://www.calenderlaboutnothing.com/](http://www.calenderlaboutnothing.com/). It tried duplicating all of the CAN functionality (and also added a few features of my own) and feedback is welcome.

To use the site you will need a GitHub account. Just go to http://www.calenderlaboutnothing.com/~\[YourGitHubUserName\] to activate tracking for your GitHub and it'll start polling your information.

Both projects are open source under the MIT.
