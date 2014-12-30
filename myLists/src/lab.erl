%%%-------------------------------------------------------------------
%%% @author tom
%%% @copyright (C) 2014, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 18. lis 2014 18:49
%%%-------------------------------------------------------------------
-module(lab).
-author("tom").

%% API
-export([]).
-export([quicksort/1]).
-export([pierwsza/2]).
-export([pierw/1]).
-export([optQuick/1]).
-export([podzielna/1]).
quicksort([])->[];
quicksort([H | T])-> quicksort([X || X<-T, X =< H])++[H]++quicksort([X || X <- T, X > H]).

optQuick([]) -> [];
optQuick([H | T])-> quicksort([X || X<-T, X < H])++[X || X <- T, X==H]++[H]++quicksort([X || X <- T, X > H]).

%% quicksort([]) -> [];
%% quicksort([H | T])-> quicksort([X || X<-T, X =< H])++integer_to_list(H)++quicksort([X || X <- T, X > H]).

pierw(X)-> pierwsza(X,trunc(math:sqrt(X))).

pierwsza(X,1) -> true;
pierwsza(X,Y) ->
if
  X rem Y == 0 -> false;
  true -> pierwsza(X,Y-1)
end.

podzielna(X)->
  if
    (X rem 13 == 0 ) and (X rem 3 == 0 ) -> true;
      true -> false
    end.



%lab 2
% fun S(0) -> 0; S(N) -> (N rem 10 ) + S(trunc(N/10)) end.

%list comperehentions

%%adres book



