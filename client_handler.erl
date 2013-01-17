-module(client_handler).
-export([start/0]).

start( Client, PPostalService ) ->
  loop( Client, PPostalService ). 
  
  
loop(Client, PPostalService) -> 
  case gen_tcp:recv(Client) of 
      
      {ok, Message} ->
         PPostalService ! {send_all, Message};
      _ -> 
         io:format("there was an error receiving the message\n") 
  end. 
    
