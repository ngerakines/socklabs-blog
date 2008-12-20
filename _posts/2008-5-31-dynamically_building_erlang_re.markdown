---
id: 1530
layout: post
title: >
    Dynamically building Erlang release files
---

Creating an application release file should be as easy as possible. For the ErlyFlux project I use this little snippet to develop/build/test on my local MacBook Pro and then build/test/deploy on the Debian machine that it runs on. Ideally there are very few differences between the libraries used but in the real world it happens and you have to work around it.

The example below is taken from the [fluxhp/src/fluxhp.erl](http://github.com/ngerakines/erlyflux/tree/master/fluxhp/src/fluxhp.erl) module.

    %% @spec build_rel() -> ok
    %% @doc Creates a .rel script for the project.
    build_rel() ->
        {ok, FD} = file:open("fluxhp.rel", [write]),
        RootDir = code:root_dir(),
        Patterns = [
            {RootDir ++ "/", "erts-*"},
            {RootDir ++ "/lib/", "kernel-*"},
            {RootDir ++ "/lib/", "stdlib-*"},
            {RootDir ++ "/lib/", "sasl-*"},
            {RootDir ++ "/lib/", "crypto-*"},
            {RootDir ++ "/lib/", "inets-*"},
            {RootDir ++ "/lib/", "mnesia-*"}
        ],
        [Erts, Kerne, Stdl, Sasl, Cryp, Inet, Mnes] = [begin
            [R | _ ] = filelib:wildcard(P, D),
            [_ | [Ra] ] = string:tokens(R, "-"),
            Ra
        end || {D, P} <- Patterns],
        RelInfo = {release,
            {"fluxhp", fluxhp:version()},
            {erts, Erts}, [
                {kernel, Kerne},
                {stdlib, Stdl},
                {sasl, Sasl},
                {crypto, Cryp},
                {inets, Inet},
                {mnesia, Mnes},
                {fluxhp, fluxhp:version()}
            ]
        },
        io:format(FD, "~p.", [RelInfo]),
        file:close(FD),
        systools:make_script("fluxhp", [local, {path, ["./ebin"]}, {path, ["./src"]}, {path, ["./src/components"]}]),
        ok.

The Makefile has a 'dist' command that executes that function from the command line and prepares the application for deployment.

    erl -s make all load -run fluxhp build -run fluxhp build_rel -s init stop

Works like a charm.
