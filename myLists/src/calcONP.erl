%%%-------------------------------------------------------------------
%%% @author tom
%%% @copyright (C) 2014, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 29. paź 2014 10:47
%%%-------------------------------------------------------------------
-module(calcONP).
-author("tom").

%% API
-export([]).
-export([calc/1]).
-export([envolve/2]).
-export([quicksort/1]).

calc(Onp)->  envolve([], string:tokens(Onp, " ")).
envolve([H|T], [])-> H;
envolve([X,Y | Z ], [H | T] ) when H == "*" ->  envolve([(X*Y)]++Z,T);
envolve([X,Y | Z ], [H | T] ) when H == "+" ->  envolve([X+Y]++Z,T);
envolve([X,Y | Z ], [H | T] ) when H == "-" ->  envolve([Y-X]++Z,T);
envolve([X,Y | Z ], [H | T] ) when H == "/" andalso Y=/=0 -> envolve([Y/X]++Z,T);

envolve([X | Z ], [H | T] ) when H == "sin" ->  envolve([math:sin(X)]++Z,T);
envolve([X | Z ], [H | T] ) when H == "cos" ->  envolve([math:cos(X)]++Z,T);
envolve([X | Z ], [H | T] ) when H == "tan" ->  envolve([math:tan(X)]++Z,T);
envolve([X | Z ], [H | T] ) when H == "ctan" ->  envolve([1/math:tan(X)]++Z,T);
envolve([X,Y | Z ], [H | T] ) when H == "pow" ->  envolve([math:pow(Y,X)]++Z,T);

envolve([], [H|T])   ->   envolve([list_to_float(H)],T);
envolve(Stack, [X|Y])->  envolve([list_to_float(X)]++Stack,Y).

%% quicksort([]) -> [];
%% quicksort([H | T]) -> quicksort([X || X <- T, X =< H])++integer_to_list(H)++quicksort([X || X <- T, X > H]).

%%
%%
quicksort([]) -> [];
quicksort([H | T])-> quicksort([X || X<-T, X =< H])++integer_to_list(H)++quicksort([X || X <- T, X > H]).


