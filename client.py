#!/usr/bin/python


from socket import *
import threading

socket = socket(AF_INET, SOCK_STREAM)
socket.connect(("localhost", 5483))


  
