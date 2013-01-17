-module(chat_main).
-export([start/0]).

-define(TCP_OPTIONS, [binary, {packet, 0}, {active, false}, {reuseaddr, true}]).
-define(PORT, 5483).


% get a server socket and start looping with it.
start() -> 
   {ok, ServerSocket} = gen_tcp:listen(?PORT, ?TCP_OPTIONS),
   loop(ServerSocket, spawn(postal_service, start, [])).



loop(Server, PPostalService) ->
   case gen_tcp:accept(Server) of
      {ok, Client} -> 
         io:format("recieved a client\n"),
         PPostalService ! {add_client, Client},
         loop(Server, PPostalService);
      _ ->
         io:format("recieved\n")
   end.

