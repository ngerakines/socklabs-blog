---
id: 151
layout: post
title: >
    A small guide to automake and autoconf
---

Recently I've been doing some c/c++ development at work. Its a pretty small project but we are using c++ because its speed over perl. I don't think anyone is really going to argue that point out. Instead of using anything bulky and bloated like KDevelop or the Eclipse I decided to stick wtih vim and make for my compiling needs.

Once I started getting deeper into the project it came to be that I needed a more flexible compiling solution, so I started looking into automake and autoconf. After some googling and alot of trial and error, I found a solution that works well for me. The project consists of building a few libraries and then compiling them into a single executable. It took more effort than it was worth with automake and autoconf but I finally got it working and the results are below.

Hopefully, this step by step guide on using automake and autoconf can help shed some light on any problems you are having. If you have any questions please feel free to leave a comment or something.

I'll start with project layout. Take a look at the following layout and make note of a few things. The sources and headers are branched out in the <code>src</code> directory. Note that every directory that has something to do with source code has an associated <em>Makefile.am</em> contained within. These will be explained down the line. The src directory has 2 sub directories, libapple and libpear, that both contain sources of there own. These are going to be static objects that are compiled into the main project.

<code>
configure.ac
Makefile.am
src
src/Makefile.am
src/main.cpp
src/libapple
src/libapple/Makefile.am
src/libapple/libapple.cpp
src/libapple/libapple.hpp
src/libpear
src/libpear/Makefile.am
src/libpear/libpear.cpp
src/libpear/libpear.hpp
docs/
</code>

This example project has 4 goals. The first is to produce an executable that works. The second is to create libraries that the executable will use, aka libapple and libpear. The third is to automate the build process and check for requirements along the way. The fourth goal is to allow easy documentation generation based on the sources.

The base files of automake and autoconf are `Makefile.am` and `configure.ac`. First lets take a look at configure.ac and see what makes it tick. This the the configure.ac file used in our example project and the comments should make it self explanitory.

<code>
dnl Init with a project name and version
AC_INIT(myproject, 1.0)

dnl Init automake with a version
AM_INIT_AUTOMAKE([foreign 1.9.4])


dnl We will be using g++
AC_PROG_CXX
dnl We will be using libtool
AC_PROG_LIBTOOL

dnl Do a check for stdio.h and friends
AC_CHECK_HEADER([stdio.h])
AC_CHECK_HEADER([math.h])
dnl ...

dnl Check for malloc functionality
AC_FUNC_MALLOC
dnl ...

dnl Do some very basic typechecks
AC_CHECK_TYPES([unsigned long, int, float])

dnl Check for const functionality
AC_C_CONST

dnl Write our files
AC_OUTPUT([Makefile
src/Makefile
src/libapple/Makefile
src/libpear/Makefile]
)
</code>

Next take a look at `Makefile.am`.

<code>
SUBDIRS = src
</code>

Those two files alone won't do it though. If you run `automake` right now you'll get a few errors about missing files. Luckily we can simply run `automake --add-missing` and the missing files will be copied over, or sym linked.

Now that we've run `automake --add-missing` as well as `aclocal` we are in good shape, but we aren't ready quite yet. Enter into the src directory and open Makefile.am. Inside you should put the following.

<code>
# We have 2 sub directories that we want to check
SUBDIRS = libapple libpear
# The namespace for our project, aka bin output
bin_PROGRAMS = myproject
# Our project depends on the following libraries
myproject_DEPENDENCIES = libapple/libapple.la libpear/libpear.la
# The main sources for this project
myproject_SOURCES = main.cpp
# Include these during compile
# INCLUDES = -I./libapple -I./libpear
# These libraries are going to be used
myproject_LDADD = 
        libapple/libapple.o 
        libpear/libpear.o
</code>

As you can see what we do is point the the two sub directories, ala libapple and libpear, and define the dependancies that we have. Next lets look at the `Makefile.am` files in libapple and libpear.

<code>
# libapple/Makefile.am
AUTOMAKE_OPTIONS = foreign
INCLUDES = -I../
noinst_LTLIBRARIES = libapple.la
libapple_la_SOURCES = libapple.cpp
</code>

<code>
# libpear/Makefile.am
AUTOMAKE_OPTIONS = foreign
INCLUDES = -I../
noinst_LTLIBRARIES = libpear.la
libpear_la_SOURCES = libpear.cpp
</code>

Building these sub objects is very simple as we layout what needs to be done. Now lets look at the sources for libapple.

<code>
//! file src/libapple/libapple.hpp
#ifndef LIBAPPLE_HPP
#define LIBAPPLE_HPP

#include <string>
#include <iostream>

using namespace std;

//! The Apple Class
/*!
 * This is the apple class. Add more attributes as needed.
 */
class Apple {
        private:
                string mycolor;
        public:
                Apple()  { mycolor = "red"; }
                ~Apple() {}
                string color (string newcolor);
                string color ();
};

#endif
</code>

<code>
//! file src/libapple/libapple.cpp
#include "libapple.hpp"
#include <string>

string Apple::color (string newcolor) {
        mycolor = newcolor;
        return mycolor;
}

string Apple::color () {
        return mycolor;
}
</code>

The last file to be covered is the main application to be built. As can be seen below.

<code>
#include "libapple/libapple.hpp"
#include "libpear/libpear.hpp"

#include <string>
#include <iostream>

using namespace std;

int main() {
        Apple myapple;
        Pear mypear;
        string pear_color, apple_color;

         apple_color = myapple.color();
         pear_color = mypear.color();

        cout << "The apple is" << apple_color << "." << endl;
        cout << "The pear is" << pear_color << "." << endl;

        mypear.color("yellow-ish");

        pear_color = mypear.color();

        cout << "If the pear sits out for a month it will be " << pear_color << "." << endl;

        return 0;
}
</code>

Now that the basics are covered, it is time to build. Move back to the root directory and perform the following:

<code>
aclocal
automake --add-missing
automake
autoconf
./configure
make
</code>

If you did exactly what I told you the build will be break because we didn't do anything about the libpear sources. The entire project is contained in a tgz file attached to this entry. This project should cover the basics and should get you started on your way. Have fun and happy hacking.
