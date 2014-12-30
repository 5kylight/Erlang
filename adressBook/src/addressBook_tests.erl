%%%-------------------------------------------------------------------
%%% @author tom
%%% @copyright (C) 2014, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 25. lis 2014 12:31
%%%-------------------------------------------------------------------
-module(addressBook_tests).
-author("tom").

%% API
-include_lib("eunit/include/eunit.hrl").
-compile(export_all).


createAddressBook_test() -> []  = addressBook:createAddressBook().
addContactFail_test() -> {error, _ } = addressBook:addContact("toma", "bord",[{person,{fullname,"toma","bord"},[],["halohaldoo"]}] ).
addContactG_test() -> ?assert(is_list(addressBook:addContact("tom","kom",[]))).
addContact_test() -> [{person,{fullname,"tpm","kod"},[],["mail"]}] = addressBook:addEmail("tpm","kod","mail",[]).

addEmailEmpty_test() -> [{person,{fullname,"toma","bord"},[],["halohaldoo"]}] = addressBook:addEmail("toma", "bord","halohaldoo", []).
addEmailSecond_test() -> [{person,{fullname,"tpm","kod"},[],["mail","mot"]}] = addressBook:addEmail("tpm","kod","mot",[{person,{fullname,"tpm","kod"},[],["mail"]}]).
addEmailFail_test() -> {error, _ } = addressBook:addEmail("tpm","kod","mail",[{person,{fullname,"tpm","kod"},[],["mail"]}]).
addEmailFail1_test() -> {error, _ } = addressBook:addEmail("tapm","kaod","mail",[{person,{fullname,"tpdm","dkod"},[],["mail"]}]).

addPhoneEmpty_test() -> [{person,{fullname,"toma","bord"},["12"],[]}] = addressBook:addPhone("toma", "bord","12", []).
addPhoneSecond_test() -> [{person,{fullname,"tpm","kod"},["13","12"],[]}] = addressBook:addPhone("tpm","kod","12",[{person,{fullname,"tpm","kod"},["13"],[]}]).
addPhoneFail_test() -> {error, _ } = addressBook:addPhone("tpm","kod","12",[{person,{fullname,"tpm","kod"},["12"],[]}]).
addPhoneFail1_test() -> {error, _ } = addressBook:addPhone("tpma","ksod","12",[{person,{fullname,"tpm","kod"},["12"],[]}]).

removeEmail_test() -> [{person,{fullname,"tpm","kod"},[],["mail"]}] = addressBook:removeEmail("mot",[{person,{fullname,"tpm","kod"},[],["mail","mot"]}]).
removeEmailFail_test() -> {error,_} = addressBook:removeEmail("kot",[]).

removeContact_test() -> [] = addressBook:removeContact("tpm","kod",[{person,{fullname,"tpm","kod"},[],[]}]).
removeContactFail_test() ->  {error,_} = addressBook:removeContact("kot","mac",[]).

removePhone_test() -> [{person,{fullname,"tpm","kod"},["13"],[]}] = addressBook:removePhone("12",[{person,{fullname,"tpm","kod"},["12","13"],[]}]).
removePhoneFail_test() -> {error,_} = addressBook:removePhone("12",[]).