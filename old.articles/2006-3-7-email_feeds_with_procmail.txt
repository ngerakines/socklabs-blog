---
id: 848
layout: post
title: >
    Email feeds with procmail
---

With a little bit of hacking you can easily setup procmail to create a rss or atom feeds to let you know about new messages. I'm going to try to keep this simple. Setting this up assumes that you have a working procmail installation going for you.

First, download and take a look at the following scripts: <a href="http://blog.socklabs.com/wp-content/mail2rss.txt">mail2rss.pl</a> and <a href="http://blog.socklabs.com/wp-content/proclog.txt">proclog.pl</a>.

mail2rss.pl simply takes a subject and from string via getopts and writes it to a file in the form of an rss feed. You could easily extend it with extra information and headers and such, but for the sake of this example I'm keeping it simple. You'll want to edit the output file that it writes to. I write to a file called mail-rss.xml which lives in my home directory, netnewswire reads local feeds just fine and that works for me. You'll also want to adjust the cleanup period, in the example it is set to 6 hours, to make it longer or shorter depending on how much mail you normally get.

proclog.pl takes the output of mailstat and pipes it to the feed as well. This script you'll need to put on a cron to run every hour or so to get the best use out of it. It is more for information purposes than anything else.

Now take a look at the following procmail config file: <a href="http://blog.socklabs.com/wp-content/procmailrc">procmailrc</a>. Specifically, note it sucks the subject and from headers and puts them into variables that are then passed to the mail2rss.pl script. It also forces a lockfile to be used when writing to the mail feed for data sanity.

With this configuration, every time procmail runs (which is when new mail arrives) it updates the mail feed. There are some caveats, like broken encoding and such in subject lines, but overall it works really well. In combination with the proclog.pl script running every hour, I can get a nice feel for what mail I got and where it went.

Every so often I get a warning that pops up in my procmail log that looks like this: <code>procmail: Error while writing to "/Users/ngerakines/bin/mail2rss.pl"</code>. If anyone knows why, drop me a line. I'm still very new to procmail configuration.
