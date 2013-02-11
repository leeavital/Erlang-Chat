all: main postal_service client_handler 

main: chat_main.erl
	 erlc chat_main.erl
	 
postal_service: postal_service.erl
	erlc postal_service.erl


client_handler: client_handler.erl
	erlc client_handler.erl 

