#!/usr/bin/python


from socket import *
import threading

sock = socket(AF_INET, SOCK_STREAM)
sock.connect(("localhost", 5483))



while True:
   s = raw_input("enter a string")
   sock.send(s)

  
