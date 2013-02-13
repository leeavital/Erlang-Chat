-module(client_handler).
-export([start/2]).

-include("client_info.hrl").

% start a client hanlder
% Client :  a client socket
% PPostalService : the process that will send messages
%  to all the other connected clients
start( Client, PPostalService ) ->
  io:format("starting a client_handler\n"),
  gen_tcp:send(Client, ok),
  User = #user{},
  loop( Client, PPostalService, User ). 
  


% loop while receiveing from the client
% same arguments as above 
loop(Client, PPostalService, User) -> 
  io:format("looping inside client_handler`\n"),
  case gen_tcp:recv(Client, 0) of 
      
        % if we get a Message, parse it
        {ok, Message} ->
            case binary_to_list(Message) of
                
                % if we get a "NAME=" string, set the new name
                "NAME=" ++ Name ->
                    UpdatedUser = User#user{name=Name},
                    io:format("setting the name to ~w", [Name]),
                    loop(Client, PPostalService, UpdatedUser);

                % if we can't find anything to parse, treat 
                % it as a new message
                _ -> 
                    PPostalService ! {send_all, User, Message},
                    loop(Client, PPostalService, User)
            end;

        % if there is an error, log the message to stdio 
        {error, Message} -> 
            io:format("there was a connection error: ~p, we are disconnecting this client", [Message])
    end. 
    
