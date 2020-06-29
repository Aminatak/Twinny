#!/usr/bin/env python


import socket, select
import Facenet_detection
imgcounter = 1
basename = "cr7%s.jpg"

HOST = '127.0.0.1'
PORT = 12345

connected_clients_sockets = []

server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

server_socket.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
server_socket.bind((HOST, PORT))
server_socket.listen(10)

connected_clients_sockets.append(server_socket)

while True:

    read_sockets, write_sockets, error_sockets = select.select(connected_clients_sockets, [], [])

    for sock in read_sockets:

        if sock == server_socket:

            sockfd, client_address = server_socket.accept()
            connected_clients_sockets.append(sockfd)

        else:
            try:
                print("ok")
                data = sock.recv(4096)


                if data:
                    
                    if data.startswith(str.encode('SIZE')) :
                        print(data)
                        txt = str(data.decode())
                        
                        tmp = txt.split()
                        size = int(float(tmp[1]))
                        print(size)

                        print('got size')

                        sock.sendall("GOT SIZE".encode())

                    elif data.startswith(str.encode('BYE')):
                        sock.shutdown(0)

                    else :
                        
                        myfile = open("cr7load.jpg", 'wb')
                        myfile.write(data)

                        data = sock.recv(40960000)
                        if not data:
                            myfile.close()
                            break
                        myfile.write(data)
                        myfile.close()

                        sock.sendall(str.encode("GOT IMAGE"))
                        Facenet_detection.get_gimine_pictur("cr7load.jpg")
                        sock.shutdown(0)
            except Exception as e :
                print(e)
                sock.close()
                connected_clients_sockets.remove(sock)
                continue
        imgcounter += 1
server_socket.close()
