---
id: 2008123001
layout: post
title: Using Test::Harness with etap
---

This isn't a beginner's walk through. It assumes you know how to use and read Erlang as well as install Erlang and Perl libraries 

I love [TAP](http://search.cpan.org/dist/TAP/). TAP is a protocol used to create and interact with testing frameworks. The general idea is that your unit tests interact with a TAP client which outputs the TAP protocol that is then consumed by a TAP server. What it boils down to is a really simple text based structure used to convey unit test results, with a few added bonuses here and there.

With [etap](http://github.com/ngerakines/etap/tree/master) and Perl's [TAP::Harness](http://search.cpan.org/~andya/Test-Harness/) we can create really slick test result output and move closer to having a continuous integration build environment. Before you get ahead of yourself, you'll need to make sure that you've got etap downloaded and in your Erlang lib path. You'll also have to install TAP::Harness and it's dependancies. 

To demonstrate how this is done, we'll use the [erlang_protobuffs](http://github.com/ngerakines/erlang_protobuffs/tree/master) library. This library is composed of two modules that provide functionality through direct interaction with their exported functions. They don't extend any OTP behaviors and have very few side effects. The project's sources are contained in the `src` directory and it's tests in the `t` directory. There is also a support directory that provides the Makefile include for building the actual modules.

The `test` target in the root Makefile calls the `prove` command with the verbose flag and a glob of the *.t files in the `t` diretory.

    test: all
        prove -v t/*.t

The actual tests for the project are [escript](http://erlang.org/doc/man/escript.html) files with the .t extension. Using the escript hash bang lets us treat each file as it's own complete unit test. They can be run in any order and have their own configuration and directives. Below is the protobuffs_t_001.t file.
    
    #!/usr/bin/env escript
    %% -*- erlang -*-
    %%! -pa ./ebin -sasl errlog_type error -boot start_sasl -noshell
    
    main(_) ->
        etap:plan(8),
        etap_can:loaded_ok(protobuffs, "module 'protobuffs' loaded"),
        etap_can:can_ok(protobuffs, encode),
        etap_can:can_ok(protobuffs, encode, 3),
        etap_can:can_ok(protobuffs, decode),
        etap_can:can_ok(protobuffs, decode, 2),
        etap_can:loaded_ok(protobuffs_compile, "module 'protobuffs_compile' loaded"),
        etap_can:can_ok(protobuffs_compile, scan_file),
        etap_can:can_ok(protobuffs_compile, scan_file, 1),
        etap:end_tests().

Lines 1, 2 and 3 are used by the shell and escript command to set any Erlang vm options necessary. In this case we want to include the `ebin` directory, start sasl with minimal logging and disable the shell.

The `main/0` function is called escript with whatever relevant arguments that may apply, but we don't care about them so we ignore them for now. Here we perform several tests to assert that the project's modules load and export the proper functions.

The `etap:plan/1` and `etap:end_tests/0` functions wrap the `etap*:*` function calls and is used to define the test plan. At this point etap is not designed to work without finite plans.

    #!/usr/bin/env escript
    %% -*- erlang -*-
    %%! -pa ./ebin -sasl errlog_type error -boot start_sasl -noshell
    
    -record(person, {name, address, phone_number, age, location}).
    
    main(_) ->
        etap:plan(1),
        etap:is(protobuffs_compile:scan_file("t/simple.proto"), ok, "simple.proto compiled"),
        compile:file("simple_pb.erl"),
        Data = [{1, <<"Nick">>, string}, {2, <<"Mountain View">>, string}, {3, <<"+1 (000) 555-1234">>, string}, {4, 25, int32}],
        BinData = erlang:iolist_to_binary([protobuffs:encode(Pos, Value, Type) || {Pos, Value, Type} <- Data]),
        #person{ name = <<"Nick">>, address = <<"Mountain View">>, phone_number = <<"+1 (000) 555-1234">>, age = 25} = simple_pb:decode_person(BinData),
        BinData = simple_pb:encode_person(#person{ name = <<"Nick">>, address = <<"Mountain View">>, phone_number = <<"+1 (000) 555-1234">>, age = 25}),
        etap:end_tests().


In the protobuffs_t_005.t file you see that you can do things like define records. In this test unit we call several of the library's exported functions and test some of the more complex functionality. The `protobuffs_compile:scan_file/1` function actually writes several files which are then compiled by `compile:file/1` and used by subsequent test unit function calls.

The output of the `make test` command, as processed by the TAP::Harness perl module, is very clean.

    mbp:erlang_protobuffs ngerakines$ make test
    mkdir -p ebin/
    (cd src;make)
    erlc -W -I ../include  +debug_info -o ../ebin protobuffs.erl
    erlc -W -I ../include  +debug_info -o ../ebin protobuffs_compile.erl
    prove t/*.t
    t/protobuffs_t_001....ok   
    t/protobuffs_t_002....ok   
    t/protobuffs_t_003....ok   
    t/protobuffs_t_004....ok   
    t/protobuffs_t_005....ok   
    t/protobuffs_t_006....ok   
    All tests successful.
    Files=6, Tests=17,  1 wallclock secs ( 0.04 usr  0.02 sys +  0.97 cusr  0.27 csys =  1.30 CPU)
    Result: PASS

Depending on the error and severity, failed tests will either output in a similarly clean fashion or stop the entire suite from processing.

    mbp:erlang_protobuffs ngerakines$ make test
    mkdir -p ebin/
    (cd src;make)
    erlc -W -I ../include  +debug_info -o ../ebin protobuffs.erl
    erlc -W -I ../include  +debug_info -o ../ebin protobuffs_compile.erl
    prove t/*.t
    t/protobuffs_t_001....ok   
    t/protobuffs_t_002....ok   
    t/protobuffs_t_003.... Failed 1/3 subtests 
    t/protobuffs_t_004....ok   
    t/protobuffs_t_005....ok   
    t/protobuffs_t_006....ok   
    
    Test Summary Report
    -------------------
    t/protobuffs_t_003 (Wstat: 0 Tests: 3 Failed: 1)
      Failed test:  2
    Files=6, Tests=17,  2 wallclock secs ( 0.04 usr  0.02 sys +  0.96 cusr  0.26 csys =  1.28 CPU)
    Result: FAIL
    make: *** [test] Error 1

The prove command has a number of options and arguments that augment test execution. Please refer to `prove --help` or the documentation available on CPAN for more information.

There are a few things to take note of. All of the paths to included and referenced files, such as the `simple.proto` file, are relative to where the `prove` command is called. In this case it's in the root directory as part of the `test` target. Also, for some more complex and lengthy tests, please read up on the escript documentation. The compile mode can be used to pre-compile the file before being called but has a few caveats that you should be aware of.

