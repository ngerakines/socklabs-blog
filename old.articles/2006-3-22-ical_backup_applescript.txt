---
id: 869
layout: post
title: >
    iCal backup applescript
---

A few days ago there was an incident with my mobile phone and I lost an entire calendar in iCal. Since then I've found a new need to have daily backups. I first thought of writing a perl script to open ical and address book and backup the data to a local place. Then I realized that it would be easier and more effecient just write an apple script to do that.

So here it is. This apple script will go through the process of backing up iCal and AddressBook to a folder, tar+gzip the folder and scp it to a remote host. It is pretty simple and self explanitory. If you have any questions, just ask.

<a href="http://blog.socklabs.com/wp-content/icalbackup.scpt.txt">Download file</a>
