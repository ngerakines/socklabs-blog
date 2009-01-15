---
layout: post
title: Code Coverage w/ Etap
---

I added a small, somewhat experimental, feature to [etap](http://github.com/ngerakines/etap/tree/master) a few days ago. With etap, you can now use the Erlang cover module to determine how much of your code is being testing by your tests. I've already started using it on several of my modules and projects to enhance the test suites. It's pretty easy to use and in this small demo, I'll run through the basics.

In the [erlang\_protobuffs](http://github.com/ngerakines/erlang_protobuffs/tree/master) project I'm using etap to test basic functionality. With code coverage analysis I can increase the module's stability by making sure more of it's functionality is tested.

    $ cd ~/dev/erlang_protobuffs
    $ make test
    ... 
    All tests successful.
    Files=8, Tests=35,  5 wallclock secs ( 0.06 usr  0.03 sys +  3.58 cusr  0.67 csys =  4.34 CPU)
    Result: PASS

To enable code coverage analysis, all you have to do is set the COVER=1 environmental variable while running your tests. None of the TAP output will change but it will write a number of .coverdata files, one for each etap test group.

    $ COVER=1 make test
    ... 
    All tests successful.
    Files=8, Tests=35,  5 wallclock secs ( 0.06 usr  0.03 sys +  3.58 cusr  0.67 csys =  4.34 CPU)
    Result: PASS

The .coverdata files hold the exported cover data as per the cover module. With a little bit of Erlang we can aggregate the results from those files and create reports.

    $ erl
    1> [cover:import(File) || File <- filelib:wildcard("*coverdata")].
    [ok,ok,ok,ok,ok,ok,ok,ok,ok,ok,ok,ok,ok,ok,ok,ok]
    2> Cover = fun(M, Out) -> cover:analyse_to_file(M, Out, []) end.
    #Fun<erl_eval.12.113037538>
    3> Mods = cover:imported_modules().
    [protobuffs_compile,protobuffs]
    4> [Cover(Mod, atom_to_list(Mod) ++ "_coverage.txt") || Mod <- Mods].
    Analysis includes data from imported files
    [".../dev/erlang_protobuffs/fc4046de9a9bb3efdf53d1d698797bc.coverdata",
     ".../dev/erlang_protobuffs/f27caf5168ce8d77b3fde6a4411cfc11.coverdata",
     ... ]
    Analysis includes data from imported files
    [".../dev/erlang_protobuffs/fc4046de9a9bb3efdf53d1d698797bc.coverdata",
     ".../dev/erlang_protobuffs/f27caf5168ce8d77b3fde6a4411cfc11.coverdata",
     ... ]
    [{ok,"protobuffs_compile_coverage.txt"},
     {ok,"protobuffs_coverage.txt"}]
    5> q().

The files protobuffs\_compile\_coverage.txt and protobuffs\_coverage.txt will breakdown your modules line by line and show how much of the code has been executed and how many times. From this I can see that lines that have "0..|" have code that has never been called, hence there is 0 code coverage there.

An example can be seen in the protobuffs\_coverage.txt file around the encoding of bools.

       |  %% @doc Encode an Erlang data structure into a Protocol Buffers value.
       |  encode(FieldID, false, bool) ->
    0..|      encode(FieldID, 0, bool);
       |  encode(FieldID, true, bool) ->
    0..|      encode(FieldID, 1, bool);
       |  encode(FieldID, Integer, enum) ->

To remedy this I'll create a test that calls this code. As I'm writing this, it turns out that there is actually a bug in my implementation of bools and writing the test for it surfaced that bug.

    cat protobuffs_t_009.t << EOF
    #!/usr/bin/env escript
    %% -*- erlang -*-
    %%! -pa ./ebin -sasl errlog_type error -boot start_sasl -noshell

    main(_) ->
        etap:plan(2),
        etap:is(protobuffs:encode(1, true, bool), [8, 1], "1, true, bool"),
        etap:is(protobuffs:encode(19, false, bool), [<<129,24>>,0], "19, false, bool"),
        etap:end_tests().
    EOF

Now that the test exists (and the bug fixed!) I'll clear my cover data and reports and generate new reports.

    $ make clean && rm -rfv *.coverdata *.txt
    $ COVER=1 make test
    $ erl ...

What's different is that now it is visible that the bool encoding functionality has been executed once (as per the newly created test).

       |  encode(FieldID, false, bool) ->
    1..|      encode(FieldID, 0, int32);
       |  encode(FieldID, true, bool) ->
    1..|      encode(FieldID, 1, int32);

Regular code coverage analysis is important to reducing test debt. It helps find bugs and saves you time, effort and energy. 
