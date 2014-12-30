%%%-------------------------------------------------------------------
%%% @author tom
%%% @copyright (C) 2014, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 29. paź 2014 10:23
%%%-------------------------------------------------------------------
-module(myLists).
-author("tom").

%% API
-export([]).
-export([containsa/2]).
-export([duplicateElements/1]).
-export([sumFloats/1]).
-export([sumFla/2]).
containsa([H | T], H) ->
        true;
containsa([H | T], X) ->
    containsa(T,X);
containsa([],X) ->
  false.

duplicateElements([H | T]) ->
      [H,H]++duplicateElements(T);
duplicateElements([])->
  [].
%sumFloaats
sumFloats([H|T]) ->
  if
  is_float(H) -> H + sumFloats(T);
  true -> sumFloats(T)
  end;
sumFloats([])->
  0.

sumFla([H|T], Sum) ->
  if
    is_float(H) -> sumFla(T, Sum + H);
    true -> sumFla(T,Sum)
  end;
sumFla([],Sum)->
  Sum.





