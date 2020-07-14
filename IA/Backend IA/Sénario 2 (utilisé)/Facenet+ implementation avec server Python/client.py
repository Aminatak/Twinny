#!/usr/bin/env python


import socket

image = "cr7.jpg"

HOST = '127.0.0.1'
PORT = 12345

sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
server_address = (HOST, PORT)
sock.connect(server_address)

try:

 # open image
    myfile = open(image, 'rb')
    bts = myfile.read()
    size = len(bts)

    # send image size to server
    sock.sendall(str.encode("SIZE %s" % size))
    answer = sock.recv(4096)

    print ('answer = %s' % answer)

    # send image to server
    if answer.decode() == 'GOT SIZE':
        sock.sendall(bts)

        # check what server send
        answer = sock.recv(4096)
        print ('answer = %s' % answer)

    if answer.decode() == 'GOT IMAGE' :
        sock.sendall(str.encode("BYE BYE "))
        print ('Image successfully send to server')

    myfile.close()

finally:
    sock.close()