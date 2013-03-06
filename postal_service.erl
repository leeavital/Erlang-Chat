-module(postal_service).
-export([start/0]).


-include("client_info.hrl").

% when we start, there is no one connected
start() -> loop([]).


% this prcess does not handle any TCP,
% rather it receives message from the main 
% server loop and the client_handlers.
% Connected : a list of connected clients (a list of sockets)
loop(Connected) ->
    receive 
        
        % add a client to the list of clients
        {add_client, Client} ->
            io:format("starting a client handler in loop\n"),
            spawn( client_handler, start, [Client, self()] ),
            io:format("spawned\n"),
            loop(Connected ++ [Client]); 
        
        % send Message to all the clients from User
        {send_all, User, Message} when is_record(User, user) ->
            io:format("sending ~p to everyone", [Message]),
            send_all(User, Message, Connected),
            loop(Connected);
        
        % if we can't match it, log it to the stdio 
        _ ->
            io:format("received an unknown Message\n")
    end.



% send a message to all of the connected clients
send_all( _, _, []) -> ok;

% User : (#user) the user that sent the Message
% Message : (sring) the message to send
send_all(User, Message, [H|T]) ->
   io:format("sending ~p to ~p\n", [Message, H]),
   gen_tcp:send(H, User#user.name ++ ": " ++ Message ++ "\n"),
   send_all(User, Message, T).
