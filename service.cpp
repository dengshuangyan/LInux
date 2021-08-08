//
// Created by wsrnd on 2021/8/8.
//
#include <iostream>
#include <cstdio>
#include <cstring>
#include <sys/socket.h>
#include <netinet/in.h>

using namespace std;

#define portnum 3333

int main()
{
    int sockfd, fd;

    struct sockaddr_in server_addr;
    struct sockaddr_in client_addr;

    char buffer[129];
    int nbyte, sin_size;

    if((sockfd = socket(AF_INET, SOCK_STREAM, 0)) == -1)
    {
        cout<< " create socket erro \n" ;
        exit(1);
    }

    bzero(&server_addr, sizeof(struct sockaddr_in));
    server_addr.sin_family = AF_INET;
    server_addr.sin_port = htons(portnum);
    server_addr.sin_addr.s_addr = htonl(INADDR_ANY);

    bind(sockfd, (struct sockaddr*)(&server_addr), sizeof(struct sockaddr));

    listen(sockfd, 5);

    while(1)
    {
        sin_size = sizeof(struct sockaddr);
        fd = accept(sockfd, ((struct sockaddr*)(&client_addr)), &sin_size);
        printf("service get connetion from %s\n",inet_ntoa(client_addr.sin_addr));

        nbyte = recv(fd, buffer, 128, 0);
        buffer[nbyte] = '\0';
        printf("server reciivd : %s\n",buffer);

        close(fd);
    }

    close(fd);


    return 0;
}
