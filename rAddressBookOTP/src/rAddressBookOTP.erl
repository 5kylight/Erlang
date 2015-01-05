%%%-------------------------------------------------------------------
%%% @author tom
%%% @copyright (C) 2015, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 04. sty 2015 12:06
%%%-------------------------------------------------------------------
-module(rAddressBookOTP).
-author("tom").

-behaviour(gen_server).

%% API
-export([start_link/0, stop/0, addContact/2, handle_call/3, handle_call/3, addEmail/3, addPhone/3, removeContact/2, removeEmail/1, removePhone/1, getEmails/2, getPhones/2, findByEmail/1, findByPhone/1, findInAny/1]).

%% gen_server callbacks
-export([init/1,
  handle_call/3,
  handle_cast/2,
  handle_info/2,
  terminate/2,
  code_change/3]).

-define(SERVER, ?MODULE).

-record(state, {}).

%%%===================================================================
%%% API
%%%===================================================================

%%--------------------------------------------------------------------
%% @doc
%% Starts the server
%%
%% @end
%%--------------------------------------------------------------------
-spec(start_link() ->
  {ok, Pid :: pid()} | ignore | {error, Reason :: term()}).
start_link() ->
  gen_server:start_link({local, ?SERVER}, ?MODULE, [], []).

%%%===================================================================
%%% gen_server callbacks
%%%===================================================================

stop() -> terminate(normal, []).

addContact(Name, Surname) ->
  gen_server:call(rAddressBookOTP,{addContact,Name,Surname}).

addEmail(Name,Surname,Email) ->
  gen_server:call(rAddressBookOTP,{addEmail, Name, Surname, Email}).

addPhone(Name, Surname, Phone) ->
  gen_server:call(rAddressBookOTP,{addPhone, Name, Surname, Phone}).

removeContact(Name, Surname) ->
  gen_server:call(rAddressBookOTP,{removeContact, Name, Surname}).

removeEmail(Email) ->
  gen_server:call(rAddressBookOTP,{removeEmail, Email}).

removePhone(Phone) ->
  gen_server:call(rAddressBookOTP,{removePhone,Phone}).

getEmails(Name, Surname) ->
  gen_server:call(rAddressBookOTP,{getEmails, Name, Surname}).

getPhones(Name, Surname) ->
  gen_server:call(rAddressBookOTP,{getPhones, Name, Surname}).

findByEmail(Email) ->
  gen_server:call(rAddressBookOTP,{findByEmail, Email}).

findByPhone(Phone) ->
  gen_server:call(rAddressBookOTP, {findByPhone, Phone}).

findInAny(Pattern) ->
  gen_server:call(rAddressBookOTP, {findInAny, Pattern}).


%%----------------------
%%---------------------------------------------------------------------------------------------------
%% @private
%% @doc
%% Initializes the server
%%
%% @spec init(Args) -> {ok, State} |
%%                     {ok, State, Timeout} |
%%                     ignore |
%%                     {stop, Reason}
%% @end
%%--------------------------------------------------------------------
-spec(init(Args :: term()) ->
  {ok, State :: #state{}} | {ok, State :: #state{}, timeout() | hibernate} |
  {stop, Reason :: term()} | ignore).
init(X) ->
  {ok, X}.

%%--------------------------------------------------------------------
%% @private
%% @doc
%% Handling call messages
%%
%% @end
%%--------------------------------------------------------------------
-spec(handle_call(Request :: term(), From :: {pid(), Tag :: term()},
    State :: #state{}) ->
  {reply, Reply :: term(), NewState :: #state{}} |
  {reply, Reply :: term(), NewState :: #state{}, timeout() | hibernate} |
  {noreply, NewState :: #state{}} |
  {noreply, NewState :: #state{}, timeout() | hibernate} |
  {stop, Reason :: term(), Reply :: term(), NewState :: #state{}} |
  {stop, Reason :: term(), NewState :: #state{}}).


handle_call({addContact, Name, Surname}, _From, AddressBook)->
   sendReply(addressBook:addContact(Name, Surname, AddressBook), AddressBook);

handle_call({addPhone, Name, Surname, Phone}, _From, AddressBook)->
  sendReply(addressBook:addPhone(Name, Surname, Phone, AddressBook), AddressBook);

handle_call({addEmail, Name, Surname, Email}, _From, AddressBook)->
  sendReply(addressBook:addEmail(Name, Surname, Email, AddressBook), AddressBook);

handle_call({removeContact, Name, Surname}, _From, AddressBook)->
  sendReply(addressBook:removeContact(Name, Surname, AddressBook), AddressBook);

handle_call({removeEmail, Email}, _From, AddressBook)->
  sendReply(addressBook:removeEmail(Email, AddressBook), AddressBook);

handle_call({removePhone, Phone}, _From, AddressBook)->
  sendReply(addressBook:removePhone(Phone, AddressBook), AddressBook);

handle_call({getEmails, Name, Surname}, _From, AddressBook)->
  sendResponse(addressBook:getEmails(Name, Surname, AddressBook), AddressBook);

handle_call({getPhones, Name, Surname}, _From, AddressBook)->
  sendResponse(addressBook:getPhones(Name, Surname, AddressBook), AddressBook);


handle_call({findByEmail, Email}, _From, AddressBook)->
  sendResponse(addressBook:findByEmail(Email, AddressBook), AddressBook);

handle_call({findByPhone, Phone}, _From, AddressBook)->
  sendResponse(addressBook:findByPhone(Phone, AddressBook), AddressBook);

handle_call({findInAny, Pattern}, _From, AddressBook)->
  sendResponse(addressBook:findInAny(Pattern, AddressBook), AddressBook);



handle_call(_Request, _From, State) ->
  {reply, ok, State}.%%



%%--------------------------------------------------------------------
%% @private
%% @doc
%% Handling cast messages
%%
%% @end
%%--------------------------------------------------------------------
-spec(handle_cast(Request :: term(), State :: #state{}) ->
  {noreply, NewState :: #state{}} |
  {noreply, NewState :: #state{}, timeout() | hibernate} |
  {stop, Reason :: term(), NewState :: #state{}}).
handle_cast(_Request, State) ->
  {noreply, State}.

%%--------------------------------------------------------------------
%% @private
%% @doc
%% Handling all non call/cast messages
%%
%% @spec handle_info(Info, State) -> {noreply, State} |
%%                                   {noreply, State, Timeout} |
%%                                   {stop, Reason, State}
%% @end
%%--------------------------------------------------------------------
-spec(handle_info(Info :: timeout() | term(), State :: #state{}) ->
  {noreply, NewState :: #state{}} |
  {noreply, NewState :: #state{}, timeout() | hibernate} |
  {stop, Reason :: term(), NewState :: #state{}}).
handle_info(_Info, State) ->
  {noreply, State}.

%%--------------------------------------------------------------------
%% @private
%% @doc
%% This function is called by a gen_server when it is about to
%% terminate. It should be the opposite of Module:init/1 and do any
%% necessary cleaning up. When it returns, the gen_server terminates
%% with Reason. The return value is ignored.
%%
%% @spec terminate(Reason, State) -> void()
%% @end
%%--------------------------------------------------------------------
-spec(terminate(Reason :: (normal | shutdown | {shutdown, term()} | term()),
    State :: #state{}) -> term()).
terminate(_Reason, _State) ->
  ok.

%%--------------------------------------------------------------------
%% @private
%% @doc
%% Convert process state when code is changed
%%
%% @spec code_change(OldVsn, State, Extra) -> {ok, NewState}
%% @end
%%--------------------------------------------------------------------
-spec(code_change(OldVsn :: term() | {down, term()}, State :: #state{},
    Extra :: term()) ->
  {ok, NewState :: #state{}} | {error, Reason :: term()}).
code_change(_OldVsn, State, _Extra) ->
  {ok, State}.

%%%===================================================================
%%% Internal functions
%%%===================================================================

sendReply(Result, AddressBook) ->
  case is_list(Result) of
    true -> {reply, ok, Result};
    false -> {reply, Result, AddressBook}
  end.

sendResponse(Result, AddressBook) ->
  {reply, Result, AddressBook}.