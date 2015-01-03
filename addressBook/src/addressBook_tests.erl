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

getPhones_test() -> ["1741"] = addressBook:getPhones("tom","b",[{person,{fullname,"tom","b"},["1741"],[]}]).
getPhones1_test() -> [] = addressBook:getPhones("tom","b",[{person,{fullname,"tom","b"},[],[]}]).
getPhonesFail_test() -> {error, _ } = addressBook:getPhones("tom","ba",[{person,{fullname,"tom","b"},["13"],[]}]).

getEmails_test() -> ["ad@da.com"] = addressBook:getEmails("tom","b",[{person,{fullname,"tom","b"},["1741"],["ad@da.com"]}]).
getEmails1_test() -> [] = addressBook:getEmails("tom","b",[{person,{fullname,"tom","b"},[],[]}]).
getEmailsFail_test() -> {error, _ } = addressBook:getEmails("tom","ba",[{person,{fullname,"tom","b"},["13"],["af"]}]).

findByPhone_test() -> "tom b" = addressBook:findByPhone("1741",[{person,{fullname,"tom","b"},["1741"],["ton@com"]}]).
findByPhoneFail_test() ->{error, _} =  addressBook:findByPhone("174",[{person,{fullname,"tom","b"},["1741"],["ton@com"]}]).

findByEmail_test() -> "tom b" = addressBook:findByEmail("ton@com",[{person,{fullname,"tom","b"},["1741"],["ton@com"]}]).
findByEmailFail_test() ->{error, _} =  addressBook:findByEmail("tadac",[{person,{fullname,"tom","b"},["1741"],["ton@com"]}]).

findInAny_test() -> [{person,{fullname,"tom","b"},["1741"],["ton@com"]}] = addressBook:findInAny("17",[{person,{fullname,"tom","b"},["1741"],["ton@com"]}]).
findInAny_fail() -> {error, _ } = addressBook:findInAny("11",[{person,{fullname,"tom","b"},["1741"],["ton@com"]}]).