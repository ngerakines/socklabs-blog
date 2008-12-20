---
id: 3
layout: post
title: >
    It just flipp'n works
---

For the developers, this is a small guide to using and administrating <a href="http://www.edgewall.com/trac/">Trac</a>. Please let me know if it works for you or if you have any corrections.

Trac is a developer's tool. Its not a complete all-in-one solution nor will it make your coffee and write your code for you. It will, however combine several usefull tools into one slick interface to make development easier for you. The primary functions that Trac serves is (A) Wiki (B) Ticket system (C) SVN Repository Browser (D) Trac's Tools. This really gives trac the ability to rock.

I'll start off with the wiki. The wiki itself is tied into every other aspect of Trac. When creating or modifying a ticket or even adjusting the comment on an svn commit, the data is parsed by the wiki parser and displayed. This makes linking to changesets, other tickets and source very easily. Instead of having to write a complex changelog, you can make all your commit notation inline and have it generate them for you. When creating tickets it is very easy to reference other tickets and even files in the repository.

The ticket system is made to be simple and light. Trac admin can easily add fields and adjust the settings relating to components, ownerships and permissions. The description and comment fields for tickets is parsed by the wiki which makes it very easy to describe situations and problems by making links to changesets, files or including information with tables or the like. One of the things that I love about the ticket system is how it handles reports. Users can create custom reports based on ticket severity, ownership, status and more. Best of all, all of these reports and bits of ticket information are available not just through the web interface but through raw text, csv and rss feeds.

The built in subversion repository browser really gives Trac the edge over the other project management toolkits out there. From the web browswer it is very easy to browse the repository, look at details of a changeset ( commit ), look at complex diffs and comparisons, and make links to changesets, sources and versions with the wiki syntax.

The tools that Trac uses are a mixture of several things. This includes the permissions and access control for restricting and maintaining control over the project. It is very easy to setup admin, developer, user and guest groups with there own roles and permissions. Not all users need to be able to look at the repository itself or have the ability to create milestones and such. This is all easily doable from the trac-admin interface. I'll walk through setting this up below. Another feature that is included in this is the Milestone view. This is a section inside the application that allows people to get a feel for where the project is going and how it is getting there. Tickets can be associated with milestones and the milestone reports are very detailed. It is possible to get a complete breakdown of the status of a milestone by component and user. There is also the Timeline view which gives you a quick overview of all of the changes of the project. It includes changes to wiki pages, changesets ( repository commits ), ticket and milestone changes and is broken down on a daily basis for simplicity. This is also viewable as a feed which makes it very handy for fast paced projects.

Administration can at first be confusing, but when you break it down it becomes very simple. The base steps are:
<blockquote>
* SVN Repository Creation
* Trac Installation
* Trac Configuration
* Trac Tweaking
</blockquote>

I'm going to assume that the reader has gone through the repository creation and Trac installation and have configured the basics already.

Lets say we have a basic application that is starting from scratch. The developers have decided to keep the source closed during alpha and beta testing. The project is small and only has 3 groups of users: Developers who have complete access, Users who have semi-limited access and Guests who have very little access. In this case the project has 4 components: Development, Debugging, Deployment and Documentation.

<em>This guide to be continued .. </em>
