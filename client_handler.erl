-module(client_handler).
-export([start/2]).

-include("client_info.hrl").

% start a client hanlder
% Client :  a client socket
% PPOstalService : the process that will send messages
%  to all the other connected clients
start( Client, PPostalService ) ->
  io:format("starting a client_handler\n"),
  gen_tcp:send(Client, ok),
  loop( Client, PPostalService ). 
  


% loop while receiveing from the client
% same arguments as above 
loop(Client, PPostalService) -> 
  io:format("looping inside client_handler`\n"),
  case gen_tcp:recv(Client, 0) of 
      
      {ok, Message} ->
         io:format("received a message: ~p\n", [Message]),
         PPostalService ! {send_all, Message},
         loop(Client, PPostalService);    
      {error, Message} -> 
         io:format("there was a connection error: ~p, we are disconnecting this client", [Message])
  end. 
    
