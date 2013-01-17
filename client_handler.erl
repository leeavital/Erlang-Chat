-module(client_handler).
-export([start/2]).

start( Client, PPostalService ) ->
  io:format("starting a client_handler\n"),
  loop( Client, PPostalService ). 
  
  
loop(Client, PPostalService) -> 
  io:format("looping inside client_handler`\n"),
  case gen_tcp:recv(Client, 500) of 
      
      {ok, Message} ->
         io:format("received a message: ~p\n", [Message]),
         PPostalService ! {send_all, Message};
      
      _ -> 
         io:format("there was an error receiving the message\n") 
  end. 
    
