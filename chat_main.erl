-module(chat_main).
-export([start/0]).

-define(TCP_OPTIONS, [binary, {packet, 2}, {active, false}, {reuseaddr, true}]).
-define(PORT, 5483).


start() -> 
   {ok, ServerSocket} = gen_tcp:listen(?PORT, ?TCP_OPTIONS),
   loop(ServerSocket).



loop(Server) ->
   case gen_tcp:accept(Server) of

      _ ->
         io:format("recieved\n")
   end.

