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
-export([addEmail/3, addPhone/3, removeContact/2, getEmails/2, getPhones/2, findByEmail/1, findByPhone/1, findInAny/1, removePhone/1, removeEmail/1]).
-export([start/0]).
-export([start_link/0]).
-export([init/0]).
-export([loop/1]).
-export([addContact/2]).
-export([crash/0]).
-export([stop/0]).

start() ->
   register(server, spawn(rAddressBook,init,[])),
  {ok}.

start_link() ->
  register(server, spawn_link(rAddressBook,init,[])),
  {ok}.


init()->
  loop(addressBook:createAddressBook()).

loop(AddressBook) ->
  receive
    {Pid, addContact, Name, Surname} ->
      case addressBook:addContact(Name,Surname,AddressBook) of
        {error, Track } -> Pid ! Track,
          loop(AddressBook);
        NewAddressBook -> Pid ! {ok},
          loop(NewAddressBook)
      end;

    {Pid, addEmail, Name, Surname, Email} ->
      case addressBook:addEmail(Name,Surname,Email,AddressBook) of
        {error, Track } -> Pid ! Track,
          loop(AddressBook);
        NewAddressBook -> Pid ! {ok},
          loop(NewAddressBook)
      end;

    {Pid, addPhone, Name, Surname, Phone} ->
      case addressBook:addPhone(Name,Surname,Phone,AddressBook) of
        {error, Track } -> Pid ! Track,
          loop(AddressBook);
        NewAddressBook -> Pid ! {ok},
          loop(NewAddressBook)
      end;

    {Pid, removeContact, Name, Surname} ->
      case addressBook:removeContact(Name,Surname,AddressBook) of
        {error, Track } -> Pid ! Track,
          loop(AddressBook);
        NewAddressBook -> Pid ! {ok},
          loop(NewAddressBook)
      end;

    {Pid, removeEmail, Email} ->
      case addressBook:removeEmail(Email,AddressBook) of
        {error, Track } -> Pid ! Track,
          loop(AddressBook);
        NewAddressBook -> Pid ! {ok},
          loop(NewAddressBook)
      end;

    {Pid, removePhone, Phone} ->
      case addressBook:removePhone(Phone,AddressBook) of
        {error, Track } -> Pid ! Track,
          loop(AddressBook);
        NewAddressBook -> Pid ! {ok},
          loop(NewAddressBook)
      end;

    {Pid, getEmails, Name, Surname} ->
      case addressBook:getEmails(Name,Surname,AddressBook) of
        {error, Track } -> Pid ! Track,
          loop(AddressBook);
        Response -> Pid ! Response ,
          loop(AddressBook)
      end;
    {Pid, getPhones, Name, Surname} ->
      case addressBook:getPhones(Name,Surname,AddressBook) of
        {error, Track } -> Pid ! Track,
          loop(AddressBook);
        Response -> Pid ! Response,
          loop(AddressBook)
      end;
    {Pid, findByEmail, Email} ->
      case addressBook:findByEmail(Email,AddressBook) of
        {error, Track } -> Pid ! Track,
          loop(AddressBook);
        Response -> Pid ! Response,
          loop(AddressBook)
      end;

    {Pid, findByPhone, Phone} ->
      case addressBook:findByEmail(Phone,AddressBook) of
        {error, Track } -> Pid ! Track,
          loop(AddressBook);
        Response -> Pid ! Response,
          loop(AddressBook)
      end;

    {Pid, findInAny, Pattern} ->
      case addressBook:findInAny(Pattern,AddressBook) of
        {error, Track } -> Pid ! Track,
          loop(AddressBook);
        Response -> Pid ! Response,
          loop(AddressBook)
      end;
    stop -> ok;
    crash -> 0/1;
    _ -> "e"
  end.


addContact(Name, Surname) ->
    server ! {self(),addContact, Name, Surname},
   receive
     X -> X
   end.

addEmail(Name, Surname, Email) ->
  server ! {self(),addEmail, Name, Surname, Email},
  receive
    X -> X
  end.

addPhone(Name, Surname, Phone) ->
  server ! {self(),addPhone, Name, Surname, Phone},
  receive
    X -> X
  end.

removeContact(Name, Surname) ->
  server ! {self(),removeContact, Name, Surname},
  receive
    X -> X
  end.

removeEmail(Email) ->
  server ! {self(),removeEmail, Email},
  receive
    X -> X
  end.

removePhone(Phone) ->
  server ! {self(),removePhone,Phone},
  receive
    X -> X
  end.

getEmails(Name, Surname) ->
  server ! {self(),getEmails, Name, Surname},
  receive
    X -> X
  end.

getPhones(Name, Surname) ->
  server ! {self(),getPhones, Name, Surname},
  receive
    X -> X
  end.

findByEmail(Email) ->
  server ! {self(),findByEmail, Email},
  receive
    X -> X
  end.

findByPhone(Phone) ->
  server ! {self(),findByPhone, Phone},
  receive
    X -> X
  end.

findInAny(Pattern) ->
  server ! {self(),findInAny, Pattern},
  receive
    X -> X
  end.

stop() ->
  server ! stop.


crash() -> server ! crash.



