#!/usr/bin/python


from socket import *
import threading
import sys




class Listener(threading.Thread):
   
   def __init__(self, sock):
      threading.Thread.__init__(self)
      self.socket = sock
      self.cont = True

   def run(self):
      while self.cont:
         s = sock.recv(100)
         sys.stdout.flush()
         print s
      print "done"

   def stop(self):
      self.cont = False



         
sock = socket(AF_INET, SOCK_STREAM)
sock.connect(("localhost", 5483))

l = Listener(sock)
l.start()


while True:
   sys.stdout.flush()
   s = raw_input("enter a string")
   sock.send(s)


l.stop()  
