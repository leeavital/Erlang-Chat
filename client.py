#!/usr/bin/python


from socket import *
import threading

sock = socket(AF_INET, SOCK_STREAM)
sock.connect(("localhost", 5483))




class Listener(threading.Thread):
   
   def __init__(self, sock):
      threading.Thread.__init__(self)
      self.socket = sock

   def run(start):
      while True:
         s = sock.recv(100)
         print s
         


l = Listener(sock)
l.start()


while True:
   s = raw_input("enter a string")
   sock.send(s)

  
