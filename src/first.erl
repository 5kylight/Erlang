%%%-------------------------------------------------------------------
%%% @author tom
%%% @copyright (C) 2014, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 29. paź 2014 10:14
%%%-------------------------------------------------------------------
-module(first).
-author("tom").

%% API
-export([]).
-export([power/2]).


power(N,0) ->
  1;
power(N,E) ->
  N*power(N,E-1).