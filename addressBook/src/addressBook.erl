%%%-------------------------------------------------------------------
%%% @author tom
%%% @copyright (C) 2014, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 19. lis 2014 10:50
%%%-------------------------------------------------------------------
-module(addressBook).
-author("tom").

%% API
-compile(export_all).
-record(fullname, {name, surname}).
-record(person, {fullname,phone, mail}).

createAddressBook() ->
  [].
getContact(Name, Surname, AddressBook) ->
  lists:filter(fun (X) -> X#person.fullname == #fullname{name = Name, surname = Surname} end, AddressBook).

addContact(Name, Surname, AddressBook) ->
  case getContact(Name, Surname, AddressBook) of
      [_] -> {error, "Sorry, Contact with this name already exists"};
      [] -> AddressBook++[#person{fullname = #fullname{name=Name, surname = Surname}, phone = [], mail = []}]
  end.

addEmail(Name, Surname, Mail, AddressBook) ->
  addEmail(Name, Surname, Mail, AddressBook, getContact(Name, Surname, AddressBook),findByEmail(Mail,AddressBook)).
addEmail(Name, Surname, Mail, AddressBook, X,Y) when length(X)==0, is_tuple(Y) ->
  AddressBook ++ [#person{fullname = #fullname{name=Name, surname = Surname}, phone = [], mail = [Mail]}];
addEmail( _, _, _, _, _,Y) when is_list(Y) ->
  {error, "Sorry, Contact with this email already exists"};
addEmail(_, _, Mail, AddressBook, X,_) ->
    case lists:any(fun (M) -> M == Mail end, (lists:last(X))#person.mail) of
      true -> {error, "Sorry, Contact with this email already exists"};
      false -> lists:delete(lists:last(X), AddressBook) ++ [(lists:last(X))#person{mail= (lists:last(X))#person.mail++[Mail]}]
    end.

addPhone(Name, Surname, Phone, AddressBook) ->
  addPhone(Name, Surname, Phone, AddressBook, getContact(Name, Surname, AddressBook), findByPhone(Phone,AddressBook)).
addPhone(Name, Surname, Phone, AddressBook, X,Y) when length(X)==0, is_tuple(Y) ->
  AddressBook ++ [#person{fullname = #fullname{name=Name, surname = Surname}, phone = [Phone], mail = []}];
addPhone(_, _, _, _, _,Y) when is_list(Y) ->
  {error, "Sorry, Contact with this phone already exists"};
addPhone(_, _, Phone, AddressBook, X,_) ->
  case lists:any(fun (M) -> M == Phone end, (lists:last(X))#person.phone) of
    true -> {error, "Sorry,This contact has  this phone already in addressbook"};
    false -> lists:delete(lists:last(X), AddressBook) ++ [(lists:last(X))#person{phone= (lists:last(X))#person.phone++[Phone]}]
  end.

removeEmail(Mail, AddressBook) ->
  case lists:filter( fun(X) -> lists:any(fun (Y) -> Y == Mail end, X#person.mail) end, AddressBook) of
     [] -> {error, "Sorry, No Contact with this Email in this AddressBook"};
     [Z] -> lists:delete(Z, AddressBook) ++ [Z#person{mail = lists:delete(Mail,Z#person.mail)}]
  end.

removeContact(Name, Surname, AddressBook) ->
  case getContact(Name,Surname,AddressBook) of
      [] -> {error, "Sorry, No Contact with this Name"};
      [Z] -> lists:delete(Z,AddressBook)
  end.

removePhone(Phone, AddressBook)->
  case lists:filter( fun(X) -> lists:any(fun (Y) -> Y == Phone end, X#person.phone) end, AddressBook) of
    [] -> {error, "Sorry, No Contact with that Phone in this AddressBook"};
    [Z] -> lists:delete(Z, AddressBook) ++ [Z#person{phone = lists:delete(Phone,Z#person.phone)}]
  end.

getEmails(Name, Surname, AddressBook) ->
  case getContact(Name,Surname,AddressBook) of
    [] -> {error, "Sorry, No person with this Name in AddressBook"};
    [Z] -> Z#person.mail
  end.

getPhones(Name, Surname, AddressBook) ->
  case getContact(Name,Surname,AddressBook) of
    [] -> {error, "Sorry, No person with this Name in AddressBook"};
    [Z] -> Z#person.phone
  end.

findByPhone(Phone, AddressBook) ->
  case lists:filter( fun(X) -> lists:any(fun (Y) -> Y == Phone end, X#person.phone) end, AddressBook) of
    [] -> {error, "Sorry, Any person has that Phone"};
    [Z] -> Z#person.fullname#fullname.name ++ " " ++ Z#person.fullname#fullname.surname
  end.

findByEmail(Mail, AddressBook) ->
  case lists:filter( fun(X) -> lists:any(fun (Y) -> Y == Mail end, X#person.mail) end, AddressBook) of
    [] -> {error, "Sorry, Any person has that Phone"};
    [Z] -> Z#person.fullname#fullname.name ++ " " ++ Z#person.fullname#fullname.surname
  end.

regex(String, Pattern) ->
  case re:run(String, ".*("++Pattern++").*",[]) of
    {match, _} -> true;
    nomatch -> false
  end.

contactToList(X) ->
  [X#person.fullname#fullname.name, X#person.fullname#fullname.surname]++X#person.mail++X#person.phone.

findInAny(Pattern,[H | T]) ->
  case lists:any(fun(M) -> regex(M,Pattern) end, contactToList(H)) of
    true -> [H]++findInAny(Pattern,T);
    false -> findInAny(Pattern,T)
  end;
findInAny(_Pattern,[])-> [].
