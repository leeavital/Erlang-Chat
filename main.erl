#!/usr/bin/escript



% starts the main chat loop
main( _ ) ->
    test:get_person(),
    chat_main:start().
