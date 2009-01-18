---
layout: post
title: Using processes as caches in Erlang
---

When I'm talking to someone who is new to Erlang, I go out of my way to tell them one very specific thing: Erlang will change the way you write software. I was playing around with a few features in I Play WoW recently, one of which is quasi-dynamic links to wowinsider.com on the My Characters page.

The feature is relatively simple. On the My Characters page, display links for 3 to 5 of the most recently published articles on WoWInsider. This requires some minor RSS/ATOM parsing and a web request. All-in-all, it's a nice feature and something that I think my users would like.

The implementation is pretty simple as well. The module exports a few functions that return articles based on a given RSS feed. The content returned is a list of tuples containing the article title and link. The special sauce of the module is the use of a process to store a cache of articles based on fetch time. When articles are requested, a process is queried to determine if it has a cache and, if it does, should the cached list be refreshed.

{% highlight Erlang %}
%% @doc Pulls wowinsider.com feeds and caches appropiately. Note that inets
%% must be running for this to work. See http://www.wowinsider.com/feeds for
%% all their supported feeds.
%% @type article() = {string(), string()}.
-module(ipwfbfe_wowinsider).

-export([recent/0, feed_articles/1, priest/0]).
-export([ensure_server_started/0, start_server_loop/0, server_loop/1]).

-include_lib("xmerl/include/xmerl.hrl").

%% @spec recent() -> [article()]
%% @doc Returns a list of the most recent articles.
recent() ->
    ensure_server_started(),
    refresh_articles("http://www.wowinsider.com/rss.xml").

%% @spec feed_articles() -> [article()]
%% @doc Returns a list articles based on a url. Note that this does not
%% validate the contents of the url. The only checking performed is a match
%% on the base url.
feed_articles(Url = "http://www.wowinsider.com/" ++ _) ->
    ensure_server_started(),
    refresh_articles(Url).

%% @spec priest() -> [article()]
%% @doc Returns a list of the most recently articles for priests.
priest() ->
    ensure_server_started(),
    refresh_articles("http://www.wowinsider.com/category/priest/rss.xml").

%% @private
refresh_articles(Url) ->
    case should_refresh(Url) of
        true ->
            case fetch(Url) of
                {ok, Body} ->
                    case parse_items(Body) of
                        {error, _} -> [];
                        Articles -> store_articles(Url, Articles), Articles
                    end;
                _ -> {error, fetch}
            end;
        false -> thaw_articles(Url)
    end.    

%% @private
should_refresh(X) ->
    wowinsider_cache ! {self(), should_update, X},
    receive Y -> Y after 1000 -> true end.

%% @private
thaw_articles(X) ->
    wowinsider_cache ! {self(), get, X},
    receive Y -> Y after 1000 -> true end.

%% @private
store_articles(X, Y) ->
    wowinsider_cache ! {self(), store, X, Y}.

%% @private
fetch(Url) ->
    case http:request(get, {Url, []}, [], []) of
        {ok, {_, _, Body}} -> {ok, Body};
        X -> {error, X}
    end.

%% @private
parse_items(Body) ->
    try xmerl_scan:string(Body) of
        {XmlElem, _} ->
            [begin
                [#xmlText{ value = Title }] = xmerl_xpath:string("/item/title/text()", Elem),
                [#xmlText{ value = Link }] = xmerl_xpath:string("/item/link/text()", Elem),
                {Title, Link}
            end || Elem <- xmerl_xpath:string("/rss/channel/item", XmlElem)];
        _ -> {error, unknown}
    catch
        _:_ -> {error, throw}
    end.

%% @private
ensure_server_started() ->
    case whereis(wowinsider_cache) of
        undefined -> proc_lib:start(?MODULE, start_server_loop,[]);
        _ -> ok
    end.

%% @private
start_server_loop() ->
    catch register(wowinsider_cache, self()),
    proc_lib:init_ack(ok),
    ?MODULE:server_loop(dict:new()).

%% @private
server_loop(State) ->
    NewState = receive
        {_From, store, Url, Articles} ->
            Now = calendar:datetime_to_gregorian_seconds({date(), time()}),
            dict:store(Url, {Now, Articles}, State);
        {From, get, Url} ->
            case dict:find(Url, State) of
                {ok, {_, Articles}} -> From ! Articles;
                _ -> From ! []
            end,
            State;
        {From, exists, Url} ->
            Resp = case dict:find(Url, State) of
                {ok, _} -> true;
                _ -> false
            end,
            From ! Resp,
            State;
        {From, should_update, Url} ->
            Now = calendar:datetime_to_gregorian_seconds({date(), time()}) - (60 * 5),
            Resp = case dict:find(Url, State) of
                {ok, {Last, _}} when Last > Now-> false;
                _ -> true
            end,
            From ! Resp,
            State;
        _ -> State
    end,
    ?MODULE:server_loop(NewState).
{% endhighlight %}

This feature went live last night and although the article cache isn't distributed, the data is small enough to cache on each web interface application.
