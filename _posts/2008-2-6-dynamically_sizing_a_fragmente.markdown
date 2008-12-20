---
id: 1434
layout: post
title: >
    Dynamically sizing a fragmented mnesia store
---

Not too long ago Mark Zweifel introduced me to Erlang. There are plenty of websites that explain what it is, how it works and where it came from so I'm not going to go into those details right here.

What I've really been having fun with is mnesia, the native data storage application. With it you can do some really powerful things like advanced data distribution, federation, complex queriers, full/compartmental replication and the list goes on and on.

The documentation is pretty good and Joe Armstrong's book [Programming Erlang: Software for a Concurrent World](http://www.pragprog.com/titles/jaerlang) has a huge collection of example snippets putting many of the concepts in action. What isn't covered includes a lot of the advanced mnesia subjects. These include fragmented tables, multi-node datastores and events.

So over the past few days I've been plowing through a lot of this and figuring out how it works. The first on the was federated/fragmented tables.

Consider a grid of three erlang nodes connected to each other with a common cookie. For the sake of this example each node lives in its own directory on the same server, but this example could apply to nodes on more than one machine. In this example the hostname is set to 'icedcoffee'.

    ic:~/tmp/erl1 $ erl -sname node1 -setcookie 622c84b69ee448a07d80de5cbeb13e3d

    ic:~/tmp/erl2 $ erl -sname node2 -setcookie 622c84b69ee448a07d80de5cbeb13e3d

    ic:~/tmp/erl3 $ erl -sname node3 -setcookie 622c84b69ee448a07d80de5cbeb13e3dTo create our setup we want to define a record and create a fragmented table over nodes 1, 2 and 3. We start by starting the initial connection to node2 and node3 from node1 in the erlang shell through net:ping/1. Then store the list of nodes in a variable and pass it to mnesia:create_schema/1. Then, on each node we start the mnesia application through mnesia:start/0.

    erl1 erl> net:ping('node2@icedcoffee').
     pong
    erl1 erl> net:ping('node3@icedcoffee').
     pong
    erl1 erl> StorageNodes = [node() | nodes()].
     [node1@icedcoffee, node2@icedcoffee, node3@icedcoffee]
    erl1 erl> mnesia:create_schema(StorageNodes).
    ok

    erl1 erl> mnesia:start().
     ok

    erl2 erl> mnesia:start().
     ok

    erl3 erl> mnesia:start().
     ok

Once mnesia is running on our grid we can verify that everything is running as expected using mnesia:system_info/1 and mnesia:info/0.

    erl1 erl> mnesia:system_info(running_db_nodes).
     [node1@icedcoffee, node2@icedcoffee, node3@icedcoffee]
    erl1 erl> mnesia:info().
     ...
     [{'node1@icedcoffee',disc_copies},
      {'node2@icedcoffee',disc_copies},
      {'node3@icedcoffee',disc_copies}] = [schema]
     ...

At this point the initial fragmented mnesia table needs to be created and verified across these three nodes. We start by using rd/1 to define a record and then mnesia:create_table/2 to create the table. The table in this demonstration is a simple key/value pair dictionary. When we create our table will will create one fragment for each node (3 fragments) and set the table as disc-only.

    erl1 erl> rd(dictionary, {key, value}).
     dictionary
    erl1 erl> FragProps = [{node_pool, StorageNodes}, {n_fragments, 3}, {n_disc_only_copies, 1}].
     [{node_pool,[node1@icedcoffee, node2@icedcoffee, node3@icedcoffee]}, {n_fragments,3}, {n_disc_only_copies,1}]
    erl1 erl> mnesia:create_table(dictionary, [{frag_properties, FragProps}, {attributes, record_info(fields, dictionary)}]).
     {atomic,ok}

We can verify that the table was created using mnesia:table_info/2. Then verify that each node has one fragment of the table. That is done with mnesia:info/0 and mnesia:table_info/2.

    erl1 erl> mnesia:table_info(dictionary, frag_properties).
     [{base_table,dictionary},
      {foreign_key,undefined},
      {hash_module,mnesia_frag_hash},
      {hash_state,{hash_state,3,2,1,phash2}},
      {n_fragments,3},
      {node_pool,[node1@icedcoffee, node2@icedcoffee, node3@icedcoffee]}]
    erl1 erl> mnesia:info().
     ...
     [{node1@icedcoffee,disc_only_copies}] = [dictionary_frag3]
     [{node2@icedcoffee,disc_only_copies}] = [dictionary_frag2]
     [{node3@icedcoffee,disc_only_copies}] = [dictionary]
     ...
    erl1 erl> Info = fun(Item) -> mnesia:table_info(dictionary, Item) end.
     #Fun<erl_eval.6.35866844>
    erl1 erl> mnesia:activity(sync_dirty, Info, [frag_dist], mnesia_frag).
     [{node1@icedcoffee,1},
      {node2@icedcoffee,1},
      {node3@icedcoffee,1}]

The next step is to populate the table with data and verify the data distribution across the fragments and nodes.

    erl1 erl> WriteFun = fun() -> [mnesia:write({dictionary, K, -K}) || K <- lists:seq(1, 30)], ok end.
     #Fun<erl_eval.20.117942162>
    erl1 erl> mnesia:activity(sync_dirty, WriteFun, mnesia_frag).
     ok
    erl1 erl> mnesia:activity(sync_dirty, Info, [frag_size], mnesia_frag).
     [{dictionary,3},{dictionary_frag2,15},{dictionary_frag3,12}]

At this point we have distributed mnesia table over a set of nodes. We've essentially trippled the number of transactions that we can handle compared to running a non distributed-fragmented mnesia store. But lets consider the situation that comes when we need to grow to another node, either for mnesia load or table size.

The demonstration continues by lighting an additional node.

    ic:~/tmp/erl4 $ erl -sname node4 -setcookie 622c84b69ee448a07d80de5cbeb13e3d

What we do now is start mnesia on node4 and then reconfigure node1 to recognize node4.

    erl4 erl> mnesia:start().
     ok

    erl1 erl> net:ping('node4@icedcoffee').
     pong
    erl1 erl> mnesia:change_config(extra_db_nodes, [node4@icedcoffee]).
     {ok,['node4@icedcoffee']}

On node4 when we run mnesia:info/0 we will now see all of the other nodes on our grid.

    erl4 erl> mnesia:info().
     ...
     [{'node1@icedcoffee',disc_copies},
      {'node2@icedcoffee',disc_copies},
      {'node3@icedcoffee',disc_copies},
      {'node4@icedcoffee',ram_copies}] = [schema]
     ...

What you'll notice is that the schema on node4 is still a ram copy. This isn't compatible with the disc-only table setup we have on our other nodes. Before we can continue adding the node to the table schema, we need to transform that using mnesia:change_table_copy_type/3.

    erl4 erl> mnesia:change_table_copy_type(schema, node(), disc_copies).
     {atomic,ok}
    erl4 erl> mnesia:info().
     ...
     [{'node1@icedcoffee',disc_copies},
      {'node2@icedcoffee',disc_copies},
      {'node3@icedcoffee',disc_copies},
      {'node4@icedcoffee',disc_copies}] = [schema]
     ...

Now that all of the nodes are in order we can add the node to the dictionary table schema and add another fragment to the table. This is done with mnesia:change_table_frag/2 calling the add_node and add_frag forms of this function.

    erl1 erl> mnesia:change_table_frag(dictionary, {add_node, 'node4@icedcoffee'}).
     {atomic,ok}
    erl1 erl> NodeLayout = mnesia:activity(sync_dirty, Info, [frag_dist], mnesia_frag).
     [{'node4@icedcoffee',0},
      {'node1@icedcoffee',1},
      {'node2@icedcoffee',1},
      {'node3@icedcoffee',1}]
    erl1 erl> mnesia:change_table_frag(dictionary, {add_frag, NodeLayout}).
      {atomic,ok}

On the initial call to mnesia:change_table_frag/2 the second parameter is the {add_node, 'node4@icedcoffee'} tuple. The second call creates a list that represents the node layout that is then fed into the third call to mnesia:change_table_frag/2 that sends the {add_frag, NodeLayout} tuple telling mnesia to add another table fragment to the table. With that done we can see that our table has been adjusted and rebalanced accordingly.

    erl1 erl> mnesia:activity(sync_dirty, Info, [frag_dist], mnesia_frag).
     [{'node1@icedcoffee',1},
      {'node2@icedcoffee',1},
      {'node3@icedcoffee',1},
      {'node4@icedcoffee',1}]
    erl1 erl> mnesia:activity(sync_dirty, Info, [frag_size], mnesia_frag).
     [{dictionary,3},
      {dictionary_frag2,8},
      {dictionary_frag3,12},
      {dictionary_frag4,7}]

If we wanted to add a fragment to a specific node we use the mnesia:change_table_frag/2 function but instead of passing a list we pass the node that we want to adjust.

    erl1 erl> mnesia:change_table_frag(dictionary, {add_frag, ['node4@icedcoffee']}).
      {atomic,ok}
    erl1 erl> mnesia:change_table_frag(dictionary, {add_frag, ['node4@icedcoffee']}).
      {atomic,ok}
    erl1 erl> mnesia:change_table_frag(dictionary, {add_frag, ['node4@icedcoffee']}).
      {atomic,ok}
    erl1 erl> mnesia:activity(sync_dirty, Info, [frag_dist], mnesia_frag).
     [{'node1@icedcoffee',1},
      {'node2@icedcoffee',1},
      {'node3@icedcoffee',1},
      {'node4@icedcoffee',4}]
    erl1 erl> mnesia:activity(sync_dirty, Info, [frag_size], mnesia_frag).
     [{dictionary,1},
      {dictionary_frag2,6},
      {dictionary_frag3,6},
      {dictionary_frag4,7},
      {dictionary_frag5,2},
      {dictionary_frag6,2},
      {dictionary_frag7,6}]


