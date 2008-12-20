---
id: 1518
layout: post
title: >
    A RESTful web service demo in yaws
---

I wrote an article in February about writing [Embedded Applications with Yaws](http://blog.socklabs.com/2008/02/embedded_applications_with_yaw/). That article was just the beginning and I'm pleased to present another piece that extends that article and steps through the creation of a RESTful web service written as a Yaws application.

I'd like to quickly give credit to the article [RESTful Services with Erlang and Yaws](http://www.infoq.com/articles/vinoski-erlang-rest) that gave me just enough umph to push me to finish writing this article. 

This is going to be a very brief guide to creating an erlang application that provides a RESTful interface to create, read, update and delete user records. We also want to provide a very basic means of ensuring that requests are complete and are not missing elements or fields.The name of our example application is **userapp** and its layout looks like this:

     userapp.app
     userapp.hrl
     userapp.erl
     userapp_sup.erl
     userapp.erl
     userapp_handler.erl
     userapp_test.erl

The process topology looks like this:

     userapp
     +- userapp_sup
        +- userapp_server
     yaws
     +- userapp_handler

The userapp.app and userapp.erl files define and implement the basic application behavior. The userapp\_sup.erl module creates the supervisor tree as part of the application. The userapp\_server.erl module manages the embedded yaws application and configuration as part of the gen\_server behavior.

**Listing 1-1: The userapp.app application configuration file.**

    {application, userapp, [
      {description, "A RESTful user-store."},
      {vsn, "0.1"},
      {modules, [userapp, userapp_sup, userapp_server]},
      {registered, [userapp]},
      {env, [
        {port, 8007},
        {working_dir, "/Users/ngerakines/dev/projects/userapp/"}
      ]},
      {applications, [kernel, stdlib, sasl]},
      {mod, {userapp, []}},
      {start_phases, [
        {mnesia, []}
      ]}
    ]}.

The application configure, as seen in listing 1-1, is pretty basic. We define the application and its related modules and then set a few environmental variables. The working\_dir variable is used to determine where the yaws log and tmp directory will be located. We also set the port of our web service. Make a mental note of the addition of the start\_phases tuple, it sets the mnesia start\_phase to init the mnesia tables.

**Listing 1-2: The userapp.hrl file.**

    -record(user, {id, name, password, email, website}).
    -record(counter, {type, count}).

In the userapp.hrl file were we defin the two records used.

**Listing 1-3: The userapp.erl file.**

    -module(userapp).
    -behaviour(application).
    
    -export([start/2, stop/1, start_phase/3]).
    -include("userapp.hrl").
    
    start(_Type, _Args) ->
        application:start(inets),
        Args = lists:map(
            fun (Var) -> {ok, Value} = application:get_env(?MODULE, Var), Value end,
            [port, working_dir]
        ),
        userapp_sup:start_link(Args).
    
    stop(_State) -> ok.
    
    start_phase(mnesia, _, _) ->
        mnesia:create_schema([node()]),
        mnesia:start(),
        mnesia:create_table(user, [{attributes, record_info(fields, user)}]),
        mnesia:create_table(counter, [{attributes, record_info(fields, counter)}]),
        mnesia:activity(transaction, fun() -> mnesia:write(#counter{type = user, count = 1}) end),
        ok.

The userapp.erl file provides the userapp:start/2 and userapp:stop/1 functions as per the application behavior. We also define the userapp:start\_phase/3 function used by the start\_phases tuple in the application configuration. As expected, the two environmental variables are read at this stage and passed down to the supervisor through the userapp\_sup:start\_link/1 function.

**Listing 1-4: The userapp\_sup.erl file.**

    -module(userapp_sup).
    -behaviour(supervisor).
    
    -export([start_link/1, init/1]).
    
    start_link(Args) ->
        supervisor:start_link({local, ?MODULE}, ?MODULE, Args).
    
    init(Args) ->
        {ok, \{\{one_for_one, 2, 10}, [
            {userapp_yaws1, {userapp_server, start_link, [Args]}, permanent, 2000, worker, [userapp_server]}
        ]}}.

The userapp\_sup module defines the supervisor tree for the application. This module includes no magic.

**Listing 1-5: The userapp\_server.erl file.**

    -module(userapp_server).
    -behaviour(gen_server).
    
    -include("/usr/lib/yaws/include/yaws.hrl").
    
    -export([start_link/1, init/1, handle_call/3, handle_cast/2, handle_info/2]).
    -export([terminate/2, code_change/3, set_conf/1]).
    
    start_link(Args) ->
        gen_server:start_link({local, ?MODULE}, ?MODULE, Args, []).
    
    init(Args) ->
        process_flag(trap_exit, true),
        case application:start(yaws) of
            ok -> userapp_server:set_conf(Args);
            Error -> {stop, Error}
        end.
    
    set_conf([Port, WorkingDir]) ->
        GC = #gconf{
            trace = false, logdir = WorkingDir ++ "/logs",
            yaws = "UserApp 1.0", tmpdir = WorkingDir ++ "/.yaws"
        },
        SC = #sconf{
            port = Port, servername = "localhost", listen = {0, 0, 0, 0},
            docroot = "/tmp", appmods = [{"/", userapp_handler}]
        },
        case catch yaws_api:setconf(GC, [[SC]]) of
            ok -> {ok, started};
            Error -> {stop, Error}
        end.
    
    handle_call(Request, _From, State) -> {stop, {unknown_call, Request}, State}.
    
    handle_cast(_Message, State) -> {noreply, State}.
    
    handle_info(_Info, State) -> {noreply, State}.
    
    terminate(_Reason, _State) -> application:stop(yaws), ok.
    
    code_change(_OldVsn, State, _Extra) -> {ok, State}.

The userapp\_server module does the bulk of the work involved in setting up and initializing the embedded yaws application and its configuration. This module is called first through the userapp\_server:start\_link/1 function that implements the gen\_server behavior of the module.

During the init phase the module attempts to start the yaws application, and on success it builds two configuration variables that are then passed to yaws\_api:setconf/2. The configuration variables set the standard options such as trace level, log directory, port, docroot, etc. It also sets the appmod configuration option dictating that the "/" request is handled by the userapp\_handler module.

**Listing 1-6: The userapp\_handler.erl file.**

    -module(userapp_handler).
    
    -export([out/1, handle_request/3, get_path/1, make_response/2]).
    -export([make_response/3, make_all_response/3, validate_request/1]).
    -export([write_record/1, text_or_default/3, object_counter/1]).
    -export([record_to_xml/1, find_record/1, delete_record/1]).
    
    -include("/usr/lib/yaws/include/yaws.hrl").
    -include("/usr/lib/yaws/include/yaws_api.hrl").
    -include_lib("xmerl/include/xmerl.hrl").
    -include_lib("stdlib/include/qlc.hrl").
    -include("userapp.hrl").
    
    out(Arg) ->
        Req = Arg#arg.req,
        ReqPath = userapp_handler:get_path(Req),
        io:format("~p - ~p~n", [Req#http_request.method, ReqPath]),
        userapp_handler:handle_request(Req#http_request.method, ReqPath, Arg).
    
    get_path(Req) -> {_, Path} = Req#http_request.path, Path.
    
    handle_request('GET', "/user/" ++ UserID, _Arg) ->
        case userapp_handler:find_record(UserID) of
            [] -> userapp_handler:make_response(404, "<error>No user for that id.</error>");
            [User] ->
                XmlBody = userapp_handler:record_to_xml(User),
                userapp_handler:make_response(200, XmlBody)
        end;
    
    handle_request('POST', "/user/" ++ UserID, Arg) ->
        case userapp_handler:find_record(UserID) of
            [] -> userapp_handler:make_response(404, "<error>No user for that id.</error>");
            [User] ->
                case userapp_handler:validate_request(Arg#arg.clidata) of
                    {ok, Xml} ->
                        Name = userapp_handler:text_or_default(Xml, "/user/name/text()", "none"),
                        Email = userapp_handler:text_or_default(Xml, "/user/email/text()", "none"),
                        Password = userapp_handler:text_or_default(Xml, "/user/password/text()", "none"),
                        Website = userapp_handler:text_or_default(Xml, "/user/website/text()", "none"),
                        NewUser = User#user{
                            id = UserID, name = Name, email = Email,
                            password = Password, website = Website
                        },
                        case userapp_handler:write_record(NewUser) of
                            ok -> userapp_handler:make_response(201, userapp_handler:record_to_xml(NewUser));
                            _ -> userapp_handler:make_response(500, "<data>Error creating data.</data>")
                        end;
                    _ -> userapp_handler:make_response(500, "<data>Error updating data.</data>")
                end
        end;
    
    handle_request('PUT', "/user" ++ _, Arg) ->
        case userapp_handler:validate_request(Arg#arg.clidata) of
            {ok, Xml} ->
                UserID = case userapp_handler:text_or_default(Xml, "/user/id/text()", none) of
                    none -> userapp_handler:object_counter(user);
                    TmpId -> TmpId
                end,
                Name = userapp_handler:text_or_default(Xml, "/user/name/text()", "none"),
                Email = userapp_handler:text_or_default(Xml, "/user/email/text()", "none"),
                Password = userapp_handler:text_or_default(Xml, "/user/password/text()", "none"),
                Website = userapp_handler:text_or_default(Xml, "/user/website/text()", "none"),
                NewUser = #user{
                    id = UserID, name = Name, email = Email,
                    password = Password, website = Website
                },
                case userapp_handler:write_record(NewUser) of
                    ok -> userapp_handler:make_response(201, userapp_handler:record_to_xml(NewUser));
                    _ -> userapp_handler:make_response(500, "<data>Error creating data.</data>")
                end;
            _ -> userapp_handler:make_response(500, "<data>Error creating data.</data>")
        end;
    
    handle_request('DELETE', "/user/" ++ UserID, _Arg) ->
        case userapp_handler:find_record(UserID) of
            [] -> userapp_handler:make_response(404, "<error>No user for that id.</error>");
            [User] ->
                case userapp_handler:delete_record(User#user.id) of
                    ok -> userapp_handler:make_response(200, "<ok />");
                    _ -> userapp_handler:make_response(500, "<data>Error deleting data.</data>")
                end
        end;
    
    handle_request(_, _, _Arg) -> % catchall
        userapp_handler:make_response(501, "<error>Action not implemented.</error>").
    
    make_response(Status, Message) ->
        userapp_handler:make_response(Status, "application/xml", Message).
    
    make_response(Status, Type, Message) ->
        userapp_handler:make_all_response(Status, make_header(Type), Message).
    
    make_header(Type) -> [{header, ["Content-Type: ", Type]}].
    
    make_all_response(Status, Headers, Message) ->
        [{status, Status}, {allheaders, Headers}, {html, Message}].
    
    validate_request(Xml) when is_binary(Xml) -> validate_request(binary_to_list(Xml));
    
    validate_request(XmlBody) ->
        try xmerl_scan:string(XmlBody, [{validation, schema}, {schemaLocation, [{default, "./user.xsd"}]}]) of
            {XmlElem, _} -> {ok, XmlElem};
            _ -> {error, unknown}
        catch
            _:_ -> {error, throw}
        end.
    
    text_or_default(Xml, Xpath, Default) ->
        case xmerl_xpath:string(Xpath, Xml) of
            [ #xmlText{value = Val} ] -> Val;
            _ -> Default
        end.
    
    object_counter(Name) ->
        [OldRecord] = mnesia:read(counter, Name, write),
        Count = OldRecord#counter.count + 1,
        NewRecord = OldRecord#counter{count = integer_to_list(Count)},
        mnesia:write(NewRecord),
        integer_to_list(Count).
    
    record_to_xml(Rec) ->
        Data = [
            {id, [], [Rec#user.id]},
            {name, [], [Rec#user.name]},
            {email, [], [Rec#user.email]},
            {password, [], [Rec#user.password]},
            {website, [], [Rec#user.website]}
        ],
        {RootEl, _} = xmerl_scan:string("<user xmlns=\"urn:userapp:user\" />"),
        #xmlElement{content = Content} = RootEl,
        NewContent = Content ++ lists:flatten([Data]),
        NewRootEl=RootEl#xmlElement{content=NewContent},    
        Export=xmerl:export_simple([NewRootEl], xmerl_xml),
        lists:flatten(Export).
    
    write_record(Record) ->
        mnesia:activity(transaction, fun() -> mnesia:write(Record) end).
    
    find_record(UserId) ->
        mnesia:activity(transaction, fun() -> qlc:e(qlc:q([R || R <- mnesia:table(user), R#user.id == UserId ])) end).
    
    delete_record(UserId) ->
        mnesia:activity(transaction, fun() -> mnesia:delete(user, UserId, write) end).

The userapp\_handler module is set through the userapp\_server module as the
module to be used by yaws as its appmod. This module is used by yaws to
listen for incoming requests and handle them accordingly. It provides the
userapp\_handler:out/1 function that yaws calls with the record defining the
incoming request. From that method we do some simple dispatching to the
userapp\_handler:handle\_request/3 function with the request method type, 
request uri and the request arg.

Because we are making a RESTful web service we want to implement at least four
features. These include the ability to add a record, get records (by id),
update records and delete records. These actions are represented by the
methods PUT, GET, POST and DELETE.

The handle\_request/3 function that matches GET requests is used to find a
user record based on the User ID as part of the URL. With basic pattern
matching we can automatically throw out any GET requests that do not include
an id after the "/user/" portion of the URL. Inside of this function we
call the userapp\_handler:find\_record/1 function to return zero or one user
records based on the ID in the URL. If none are returned, we return with a
404 indicating that we couldn't find anything. If a user record was returned
then the userapp\_handler:record\_to\_xml/1 function is called to transform
the record into the XML representation of a user and the XML is returned
with a 200.

To update an existing user, the handle\_request/3 function that matches POST
requests is used. Like the GET request, this operation requires an existing
user and it is assumed that the User ID will be a part of the request URL. A
quick check is made to determine if the user we are trying to modify exists
and if it does not a 404 is returned. If the user does exist we continue
by validating the request xml. This is done by calling the
userapp\_handler:validate\_request/1 on the request body. That method will
return either an `{ok, Xml}` or an `{error, Reason}` indicating that the
incoming request is or is not valid. If the request is valid than we attempt
to extract all of the values representing the entire user (minus the ID which
is implied through the URL) and construct a record based on the found record
from the User ID. The userapp\_handler:write\_record/1 is then called and on
success we return a 201 or a 500.

To create a new user the handle\_request/3 function that matches PUT
requests is used. This function is nearly identical to the opperation that
matches POST requests but with several differences:
1.  The URL matched is the base "/user" string. The client shouldn't be trying to set ids for us so we don't look for one.
2.  Since there is no User ID, we don't bother checking the existence of a user and skip the userapp\_handler:find\_record/1 function call.
3.  When setting the fields for the user record, a User ID is generated using then userapp\_handler:object\_counter/1 function.

The final operation we handle is the DELETE. For this operation we extract
target user's User ID from the URL and confirms the user's existence through
the userapp\_handler:find\_record/1 function call. If the user does exist
the userapp\_handler:delete\_record/1 function is called and the user
deleted. A 200 or 500 is returned depending on if the delete operation
succeed or failed.

There are several other functions provided in the userapp\_handler module.
Included are functions to create/update, find and delete user records in a
mnesia table, validate user xml, extract data from user xml and build xml
represented by a user record.

The validate_request/1 function will take an xml string and transform it
into a number of nested tuples via xmerl\_scan. It is here that we apply an
xsd schema validation option to make sure that all user xml conforms to a
single representation of a user.

**Listing 1-7: The user.xsd file.**

    <xs:schema xmlns:xs="http://www.w3.org/2001/XMLSchema" targetNamespace="urn:userapp:user" xmlns="urn:userapp:user" elementFormDefault="qualified">
        <xs:element name="user">
            <xs:complexType>
                <xs:sequence>
                    <xs:element name="id" type="xs:string" minOccurs="0"/>
                    <xs:element name="name" type="xs:string"/>
                    <xs:element name="email" type="xs:string"/>
                    <xs:element name="password" type="xs:string"/>
                    <xs:element name="website" type="xs:string" minOccurs="0"/>
                </xs:sequence>
            </xs:complexType>
        </xs:element>
    </xs:schema>

The user.xsd defines the xsd schema for a user record's xml representation. Make a note of the minOccurs attribute on the id and website elements. It is set to show that although those elements are defined and should be included in that specific order, if they aren't included its ok. This allows us to say that the 'website' field for a user is optional, and doesn't have to be present. This attribute exists on the id element because for PUT operations it won't be present and that shouldn't invalidate the request.

The userapp application provided is merely a template to get you started on creating RESTful webservices with yaws. With it, I've demonstrated how simple it is to create a stateless, service-friendly web service that can manage specific objects. 

Of course you'll need to tweak a few to get it working for you (the yaws paths and directory as per the userapp.app configuration file), but it is generic enough to work for most people as-is.

I use the following shell command to start the erlang shell when running this application:

    erl +A 1 +Ktrue -boot start_sasl +W w -sname userapp -pa /usr/lib/yaws/ebin -yaws embedded true -mnesia dir 'userapp.mnesia'

Once in the shell the application can be started with `application:start(userapp).` to get things going.

To test this web service you can use the functions provided in the userapp\_test.erl file. *Note:* Make sure you've started inets (`inets:start().`) before running these tests.

**Listing 1-8: The userapp\_test.erl module.**

    -module(userapp_test).
    
    -export([get_user/0, update_user/0, delete_user/0, create_user/0]).
    
    get_user() ->
        http:request(get, {"http://localhost:8007/user/12345", []}, [], []).
    
    update_user() ->
        Data = "<user xmlns=\"urn:userapp:user\"><id>12345</id><name>Testy McTester</name><email>testy@mctestor.com</email><password>testy123</password><website>http://www.mctestor.com/</website></user>",
        http:request(post, {"http://localhost:8007/user/12345", [], "application/xml", Data}, [], []).
    
    delete_user() ->
        http:request(delete, {"http://localhost:8007/user/12345", []}, [], []).
    
    create_user() ->
        Data = "<user xmlns=\"urn:userapp:user\"><name>Testy McTester</name><email>testy.mctestor@mctestor.com</email><password>testy123</password></user>",
        http:request(put, {"http://localhost:8007/user/", [], "application/xml", Data}, [], []).
