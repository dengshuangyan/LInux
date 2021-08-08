//
// Created by wsrnd on 2021/8/8.
//

#include <iostream>
#include <cstdio>
#include <cstring>
#include <sys/socket.h>
#include <netinet/in.h>

#define porenum 3333
using namespace std;

int main()
{
    struct sockaddr_in server_addr;
    char buffer[129];

    //创建套接字
    int sockfd;
    if((sockfd = socket(AF_INET, SOCK_STREAM, 0) == -1))
    {
        cout << " create socket error \n";
        exit(1);
    }

    bzero(&server_addr, sizeof(struct sockaddr_in));
    server_addr.sin_addr = AF_INET;
    server_addr.sin_port = htons(portnum);
    server_addr.sin_addr.s_addr = inet_addr("192.168.191.3");

    if(connect(sockfd, (struct sockaddr*)(&server_addr), sizeof(struct sockaddr)) == -1)
    {
        cout << " connect error \n";
        exit(1);
    }

    printf("please input char:\n");
    fget(buffer,128,stdin);
    send(sockfd, buffer, strlen(buffer), 0);

    close(sockfd);
    return 0;
}
