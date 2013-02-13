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
      {add_client, Client} ->
         io:format("starting a client handler in loop\n"),
         spawn( client_handler, start, [Client, self()] ),
         io:format("spawned\n"),
         loop(Connected ++ [Client]);
      
      {send_all, User, Message} ->
         io:format("sending ~p to everyone", [Message]),
         send_all(User, Message, Connected),
         loop(Connected);
      _ ->
         io:format("received an unknown\n")
   end.



% send a message to all of the connected clients
send_all( _, _, []) -> ok;

% Message : (sring) the message to send
send_all(User, Message, [H|T]) ->
   gen_tcp:send(H, User#user.name ++ ": " ++ Message),
   send_all(User, Message, T).
