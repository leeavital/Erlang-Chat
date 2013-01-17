from socket import *


socket = socket(AF_INET, SOCK_STREAM)
socket.connect(("localhost", 5483))

