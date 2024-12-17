%%% -*- erlang -*-
%%%
%%% This file is part of couchbeam released under the MIT license.
%%% See the NOTICE for more information.

-module(couchbeam_view_sup).

 -behaviour(supervisor).

%% API.
-export([start_link/0]).

%% supervisor.
-export([init/1]).

-define(SUPERVISOR, ?MODULE).

%% API.

-spec start_link() -> {ok, pid()}.
start_link() ->
    supervisor:start_link({local, ?SUPERVISOR}, ?MODULE, []).

%% supervisor.

init([]) ->

    %% start table to keep async streams ref
    ets:new(couchbeam_view_streams, [set, public, named_table]),

    %% define a stream spec
    Stream = {couchbeam_view_stream, {couchbeam_view_stream, start_link, []},
              temporary, infinity, worker, [couchbeam_view_stream]},

    {ok, {{simple_one_for_one, 10, 3600}, [Stream]}}.
