---
id: 1436
layout: post
title: >
    Introducing MT-KeywordExtractor
---

MT-KeywordExtractor is a movable type plugin that will allow you to extract relevant keywords from your entry content. Currently it uses the Yahoo Keyword Extractor API but it may not be limited to this in the future.

In its current state it is very simple. It attaches to the post_save hook to automatically submit your content to the keyword extractor api and takes the contents and fills the entry 'keywords' text with them.

This allows you to easily create tags and such with the suggested keywords it returns.

In its current version there is no configuration required.
