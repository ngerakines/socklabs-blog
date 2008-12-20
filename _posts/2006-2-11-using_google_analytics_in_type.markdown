---
id: 784
layout: post
title: >
    Using Google Analytics in TypePad
---

Subtitle: The very unofficial guide to advanced templating in TypePad.

So Google analytics is extremely cool. With it you can do some very cool measurements of traffic. I use it with <a href="http://blog.socklabs.com/">this site</a> as well as a few others.

This is a small guide written to help TypePad blog owners use some of the unknown power-tools that TypePad offers. In this case there are several ways to use 'advanced templates' to do what you want. It is not endorsed by TypePad or the support staff in any way, shape or form. My ideas on advanced templating do not reflect the ideas or intentions of my employer ( SixApart ) nor should this guide be taken as an endorsement in any way.

This guide is going to assume that you already have a TypePad account. If you don't, then go sign up for the free trial. This guide also assumes that you have a Google Analytics account as well. If you don't have one already, you may or may not get one that easily.

But first a disclaimer: <em>Using 'advanced templates' can be very good but also very bad. Even the smallest change in any of the embedded tags can completely break your blog and leave you screwed. If you are not very familiar with how MovableType or TypePad templates already work, don't use this guide and wait until the TypePad developers build in better stats.</em>

First step is creating your blog. In this example I am going to create a new blog.

<a href="http://www.flickr.com/photos/sock/98547138/" title="Photo Sharing"><img src="http://static.flickr.com/43/98547138_e35905811e_m.jpg" width="240" height="126" alt="Step_1" /></a>

In this guide, since the blog is new I'm going to select a new layout and design to use. If you've already got one then you can ignore this until later.

Head to the 'Design' tab under 'Weblogs' and go to the 'Create New' link. Select a layout that you like and continue to the next step.

<a href="http://www.flickr.com/photos/sock/98547139/" title="Photo Sharing"><img src="http://static.flickr.com/38/98547139_14d1e1a6cd_m.jpg" width="240" height="157" alt="Step_2" /></a>

The next step is content selections. This will vary from blog to blog.

<a href="http://www.flickr.com/photos/sock/98547140/" title="Photo Sharing"><img src="http://static.flickr.com/37/98547140_2f2ce7ae1b_m.jpg" width="240" height="179" alt="Step_3" /></a>

The next step is content ordering. Do what makes you happy.

Once you've gone to through that, you will be at the theme selection part of the 'Template Builder'. I picked the predefined theme 'Vicksburg Red', because I like it. Find something you like here.

Once you've gone through the theme selection you will be asked to give your template a good name and description. Some may not consider this important but it really is vital.

<a href="http://www.flickr.com/photos/sock/98547141/" title="Photo Sharing"><img src="http://static.flickr.com/27/98547141_aad994af0f_m.jpg" width="240" height="132" alt="Step_4" /></a>

Once you've done that click on 'Save and Apply Design' to set it as active. You will then be taken back to the 'Design' section where you can get an overview of the current design. Click through to 'Manage your Designs'

<a href="http://www.flickr.com/photos/sock/98547142/" title="Photo Sharing"><img src="http://static.flickr.com/38/98547142_8babb22561_m.jpg" width="240" height="143" alt="Step_5" /></a>

If you skipped over the theme creation stuff, this is where you want to get back into the guide.

This is where the voodoo comes into the picture. What we are going to do is copy the theme we have and convert it to an advanced template. Select the theme you want to use, in my case it is 'Nick's cool theme' and hit the 'Convert to Advanced' button.

<a href="http://www.flickr.com/photos/sock/98547143/" title="Photo Sharing"><img src="http://static.flickr.com/42/98547143_e501665bb9_m.jpg" width="240" height="77" alt="Step_6" /></a>

A window should come up asking if you really want to do this. I can't stress again that once you've crossed this line you have a very high chance of screwing up in a way that breaks your blog. Please keep in mind that advanced templates are for <em>advanced</em> users and should be used with caution.

<a href="http://www.flickr.com/photos/sock/98547363/" title="Photo Sharing"><img src="http://static.flickr.com/33/98547363_2489baa909_m.jpg" width="240" height="154" alt="Step_7" /></a>

Once you've thought about the consequences of your actions, click 'Yes' to continue. It will bring you back to the 'Manage Your Designs' where you will see that your design has been converted and has a small icon next to it indicating that it special.

<a href="http://www.flickr.com/photos/sock/98547364/" title="Photo Sharing"><img src="http://static.flickr.com/29/98547364_374eb10760_m.jpg" width="240" height="168" alt="Step_8" /></a>

Click on it and then click on 'edit' when it comes up. You will then be brought to a new section with a lot of options regarding your template and what you can do with it. It will look something like this:

<a href="http://www.flickr.com/photos/sock/98547365/" title="Photo Sharing"><img src="http://static.flickr.com/34/98547365_f395a3440b_m.jpg" width="238" height="240" alt="Step_9" /></a>

Now that we have near total control over our template, all we need to do is take the Google Analytics snippet of code and add it to our template. In Google Analytics go through creating a new site and it'll give you a javascript code to insert.

In TypePad select on the 'Main Index Template'.

<a href="http://www.flickr.com/photos/sock/98547366/" title="Photo Sharing"><img src="http://static.flickr.com/39/98547366_40866d58ab_m.jpg" width="240" height="202" alt="Step_10" /></a>

Scroll down to the very bottom of the textarea and aste the javascript code from Google right about the closing body tag.

<a href="http://www.flickr.com/photos/sock/98547367/" title="Photo Sharing"><img src="http://static.flickr.com/31/98547367_f0219317a6_m.jpg" width="240" height="141" alt="Step_11" /></a>

Hit the save button and you'll then get a nice message saying that the changes have been saved.

<a href="http://www.flickr.com/photos/sock/98547368/" title="Photo Sharing"><img src="http://static.flickr.com/19/98547368_5827f91f7e_m.jpg" width="240" height="80" alt="Step_12" /></a>

Now in the Category, DateBased and Individual Archives pages paste the same javascript code right before the closing body tag and you are finished.

Once you've gone through all of that, follow through by hitting the 'Publish Weblog' button to have all of the changes made. Then go back into Google Analytics and check the status of the site. It will then say that it has found the tracking code.

Give Google 24-48 hours for the reports to start populating with information. You should be good to go. You don't have to do anything when you go to create a new post so enjoy your Google Analytics tracking!
