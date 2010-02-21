---
id: 1545
layout: post
title: >
    Using Erltl without ErlyWeb
---

Daveb posts about using [ErlyWeb templates with MochiWeb](http://weblog.miceda.org/2008/05/05/using-erlyweb-templates-with-mochiweb/) and this is interesting. I'm a fan of [ErlyWeb](http://erlyweb.org/) and what it officers and, to be quite frank, I don't think there is another Erlang web framework that compares to it regarding features and functionality. With that said, there are a lot of cases where you don't need an entire web framework to do what you want. There are plenty of situations where Erltl-built modules can come in very handy for doing all kinds of content building.

I Play WoW and s3images both use Yaws to handle HTTP requests but instead of using all of ErlyWeb, it cherry-picks the requests that need complex output and uses [ErlTL](http://erlyweb.org/doc/erltl.html) modules as needed.

In the [s3images_ahandler.erl](http://github.com/ngerakines/s3imagehost/tree/master/src/s3images_ahandler.erl) file there is the `s3images_ahandler:wrap_body/3` function that is used to build an outer and inner template content and then render it with Yaws. You can see that in the project's [Makefile](http://github.com/ngerakines/s3imagehost/tree/master/Makefile) there is a quick online command used to build the template files used by the project and dump them into the project's ebin folder for later use. Using a simple interface like this does exactly what I want and gives me the best of both worlds.

The I Play WoW Facebook application, which is much more FBML/HTML intense, also does something very similar to this to render the application content inside the Facebook application canvas.
