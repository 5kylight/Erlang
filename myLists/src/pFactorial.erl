%%%-------------------------------------------------------------------
%%% @author tom
%%% @copyright (C) 2014, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 10. gru 2014 18:37
%%%-------------------------------------------------------------------
-module(pFactorial).
-author("tom").

%% API
-export([]).
-export([factorial/1]).
-export([seqfactorial/1]).
-export([init/1]).
-export([father/2]).
-export([calcfactorial/2]).
-export([inteligentInit/1]).
-export([intelifactorial/3]).

factorial(1) -> 1;
factorial(N) ->
  N * factorial(N -1).


seqfactorial(N) ->  [ factorial(X) || X <- lists:seq(1,N)].

calcfactorial(N, Pid)->  Pid ! [factorial(N)].

father(List, Pid) ->
  receive
    N ->father(List++N, Pid)
  after
    1000 -> Pid ! List
  end.

init(N) ->
  Pid = spawn(?MODULE, father,[[],self()]),
  lists:foreach(fun (X) -> spawn (?MODULE, calcfactorial, [X,Pid]) end ,lists:seq(1,N)),
  receive
  B -> B
  end.


intelifactorial(L,R,Pid) ->  Pid ! [ factorial(X) || X <- lists:seq(L,R,4) ].

inteligentInit(N) ->
  Serv = spawn(?MODULE, father,[[],self()]),
  spawn(?MODULE, intelifactorial,[1,N,Serv]),
  spawn(?MODULE, intelifactorial,[2,N,Serv]),
  spawn(?MODULE, intelifactorial,[3,N,Serv]),
  spawn(?MODULE, intelifactorial,[4,N,Serv]),
  receive
    B -> B
  end.



%% intelifactorial(L,R,Pid) ->  Pid ! [ factorial(X) || X <- lists:seq(L,R) ].
%%
%% inteligentInit(N) ->
%%   Serv = spawn(?MODULE, father,[[],self()]),
%%   spawn(?MODULE, intelifactorial,[1,trunc(N/4),Serv]),
%%   spawn(?MODULE, intelifactorial,[trunc(N/4)+1, trunc(N/2),Serv]),
%%   spawn(?MODULE, intelifactorial,[trunc(N/2)+1,trunc((3*N)/4),Serv]),
%%   spawn(?MODULE, intelifactorial,[trunc((3*N)/4) + 1 ,N,Serv]),
%%   receive
%%     B -> B
%%   end.