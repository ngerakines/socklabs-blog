---
id: 1536
layout: post
title: >
    Erlang snippet: Image type detection using binary matching
---

I've been devoting more time to I Play WoW lately and the next feature in the skunkworks is much better image hosting. For a while I was using Facebook's albums to manage all of that stuff but in the end, I think its going to be better if I do it myself. The backend service is going to accept image uploads, track and manage them internally and use amazon s3 for storage.

Tonight I made a breakthrough in figuring out how to make sure that a given file is an image and that its dimensions fit within the expected scope. Basically, I want to restrict image uploads to .jpg, .gif and .png files that are less than 2048x2048 (that might change) and that are under 4 megs in size. I've been looking for a while for Erlang snippets or code that tie into imagemagik or gd to do this sort of detection, but in the end I didn't find anything that fit my needs so I decided to write a small library.To use the module, call the image\_type/1 function with a string representing the path of the image file. You can also call the image\_type/1 function with the binary data as is.

I've run it through a sample of 3k+ images without an issues and its picked up the type and dimensions each time. Depending on how much more image related functionality is added, I might release it on GitHub. This code is made available under the MIT license.

So this is what it looks like:

    -module(ipwfiles_image).
    -compile(export_all).
    
    image_type(Filename) when is_list(Filename) ->
        case file:read_file(Filename) of
            {ok, FileHandle} -> image_type(FileHandle);
            _ -> error
        end;
    
    %% Gif header, width and then height
    image_type(<<71,73,70,56,55,97,Width:16/little,Height:16/little,_/binary>>) -> {gif, Width, Height};
    image_type(<<71,73,70,56,57,97,Width:16/little,Height:16/little,_/binary>>) -> {gif, Width, Height};
    
    %% PNG header, chunk1, width and height
    %% spec: http://www.w3.org/TR/PNG/#
    image_type(<<137,80,78,71,13,10,26,10,_:4/signed-integer-unit:8,73,72,68,82,Width:4/signed-integer-unit:8,Height:4/signed-integer-unit:8,_/binary>>) -> {png, Width, Height};
    
    %% JPEG
    %% ref: http://www.obrador.com/essentialjpeg/headerinfo.htm
    %% thanks http://www.ravenna.com/gifs/isize.pl
    image_type(Data = <<255,216,255,224,_/binary>>) ->
        {H, W} = parse_jpeg(Data),
        {jpeg, H, W};
    
    image_type(_) -> unknown.
    
    %% SOF0: 255 192, SOF3: 255 195
    %% SOI : 255 216, SOS : 255 218, SOF3: 255 195, EOI : 255 217, COM: 255 254
    
    parse_jpeg(Data) -> parse_jpeg(Data, {}).
    parse_jpeg(<<>>, Results) -> Results;
    parse_jpeg(<<255,192,_:16/signed-integer,_:8,Width:16/signed-integer,Height:16/signed-integer,Rest/binary>>, _) ->
        %% io:format("Marker SOF0 hit ~p ~p(~p)~n", [Height, Width, Pos]),
        parse_jpeg(Rest, {Height, Width});
    %% parse_jpeg(<<255,195,Rest/binary>>, Pos) -> parse_jpeg(Rest, Pos);
    %% parse_jpeg(<<255,216,Rest/binary>>, Pos) -> parse_jpeg(Rest, Pos);
    %% parse_jpeg(<<255,218,Rest/binary>>, Pos) -> parse_jpeg(Rest, Pos);
    %% parse_jpeg(<<255,217,Rest/binary>>, Pos) -> parse_jpeg(Rest, Pos);
    %% parse_jpeg(<<255,254,Rest/binary>>, Pos) -> parse_jpeg(Rest, Pos);
    parse_jpeg(<<_,Rest/binary>>, Pos) -> parse_jpeg(Rest, Pos).
