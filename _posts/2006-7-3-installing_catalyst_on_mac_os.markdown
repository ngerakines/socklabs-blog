---
id: 997
layout: post
title: >
    Installing Catalyst on Mac OS X
---

I decided that once Fence became stable and feature complete I would hold off on development for a little while and start looking at some of the other projects that I've got on the shelf.

One of the things that I've been wanting to do for a long time is to revisit Bookmarks and see what can be done with it. This is my dilemma though, do we really need yet another social bookmarking package? I think not. My real reason for blowing off the dust is to start experimenting with Catalyst and possibly converting it over to using the Catalyst engine with Apache2 and mod_perl2.

This is no small task though. The first step is to get apache2, mod_perl2 and the catalyst framework installed and running. Under normal circumstances this wouldn't be an issue, but in the past I've had extremely bad luck with apache2 and mod_perl2. This was decided with hope and faith in the stability of the combination.

Installation was extremely easy. I was surprised.

First download <a href="http://httpd.apache.org/download.cgi">apache2</a>, <a href="http://perl.apache.org/download/index.html">mod_perl2</a> and <a href="http://search.cpan.org/dist/libapreq2/">libapreq2</a> and place them into a temporary directory.

Next configure, compile and install Apache2 with '<code>./configure --prefix=/opt/apache2; make; make install</code>'.

Next do the same for mod_perl2 with '<code>perl Makefile.PL MP_APXS=/opt/apache2/bin/apxs; make; make test; make install</code>'.

Next do the same for libapreq2 with '<code>perl Makefile.PL --with-apache2-apxs=/opt/apache2/bin/apxs; make test install</code>'.

Last, add the 'LoadModule' config to the apache2 config file.
'<code>LoadModule apreq_module    modules/mod_apreq2.so</code>' and '<code>LoadModule perl_module     modules/mod_perl.so</code>'

That should be all you need. Please leave a comment if you have any questions or problems.
