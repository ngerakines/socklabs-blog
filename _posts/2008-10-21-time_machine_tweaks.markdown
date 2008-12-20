---
id: 1568
layout: post
title: >
    Time Machine Tweaks
---

Our Time Capsule is a great device and it's definitely proven it's worth on a few occasions, but sometimes it can go overboard. These are the tweaks that I use.

The default backup interval is one hour, that is too much for me so I moved it to every two hours. This is a simple command line call.

> sudo defaults write /System/Library/LaunchDaemons/com.apple.backupd-auto StartInterval -int 7200

This is the list of folders that are ignored.

* ~/tmp
* ~/Desktop
* ~/Downloads
* ~/Music/iTunes/iTunes Music/Podcasts
* /Volumes/Backup of Nicholas Gerakines' Computer (time capsule mount)
* /Applications

