%%%-------------------------------------------------------------------
%%% @author tom
%%% @copyright (C) 2014, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 17. gru 2014 09:55
%%%-------------------------------------------------------------------
-module(rAddressBook).
-author("tom").

%% API
-export([]).
-export([start/0]).
-export([start_link/0]).
-export([init/0]).
-export([loop/1]).
-export([addContact/2]).
-export([crash/0]).

start() ->
   register(server, spawn(rAddressBook,init,[])),
  {ok}.

start_link() ->
  register(server, spawn_link(rAddressBook,init,[])),
  {ok}.


init()->
  loop(adressBook:createAdressBook()).

loop(AdressBook) ->
  receive
    {Pid,addContact, Name, Surname} ->
      case adressBook:addContact(Name,Surname,AdressBook) of
        {error, Track } -> Pid ! Track, loop(AdressBook);
        NewAdressBook -> loop(NewAdressBook)
      end;

    stop -> ok;
    crash -> 0/1;
    _ -> "e"
  end.


  addContact(Name, Surname) ->
     server ! {self(),addContact, Name, Surname},
    receive
      Cos -> Cos
    after
      100 -> {ok}
    end.



stop() ->
  server ! stop.


crash() -> server ! crash.



