%%%-------------------------------------------------------------------
%%% @author tom
%%% @copyright (C) 2014, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 17. gru 2014 10:48
%%%-------------------------------------------------------------------
-module(rAddressBookSup).
-author("tom").

%% APIcrashcrash
-export([]).
-export([start/0]).

start() ->
  register(supervisor,spawn(rAddressBookSup,init,[])).

init() ->
  process_flag(trap_exit,true),
  rAddressBook:start_link(),
  loop().


loop() ->
  receive
    {'EXIT', Module , Reason } -> io:format("Removed"), rAddressBook:start_link(), loop()
  end.


