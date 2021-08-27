

ARP(address Resolution Protocl) 地址解析协议
RARP（Recerse Address Resolution Protocol)反向地址解析协议
round-trip time   RTT  往返时间 TCP用来估算客户和客户端之间的往返时间的算法，以便它知道等待一个确认需要多少时间
flow control 流量控制

# 第一章 简介

err_sys()函数输出我们作为参数提供的出错信息以及所发生的系统错误的描述，然后终止进程。

inet_pton函数

exit()函数终止程序运行，unix在一个进程终止时总是关闭该进程所有打开的描述符。

服务器 socket   bind  listen  这三个调用步骤是任何tcp服务器准备的监听描述符。

服务器进程在accept调用中被置于休眠状态，等待某个客户连接的到达并被内核接受，tcp连接使用的是三次握手来建立连接。握手完毕时accept返回，其返回值是一个称为已连接描述符的新描述符，也就是connfd。

1970:01:01 00:00:00   ctime函数将秒数转化为可以直观可读的时间格式。

ISO（International  Organization  for  Standardization）国际标准化组织。

开放系统互连（open systems  interconnectio） OSI

OSI模型：物理层    数据链路层     网络层    传输层   会话层   表现层  应用层

网际网协议族： 数据链路层   网络层  传输层  应用层







# 第二章 传输层：TCP UDP SCTP

SCTP(Stream  Control Transmission Prorocol) 流控制传输协议

tcp/ip 除了TCP和IP这两个主要协议外，还有许多其他的成员

IPv4 使用32位地址     IPv6使用128位地址

## 2.1 TIME_WAIT 状态存在的原因

1. 可靠的实现TCP全双工连接的终止。
2. 允许老的重复的分节在网络中消逝。
   TCP分节可能由于路由器异常而“迷途”，在迷途期间，TCP发送端可能因确认超时而重发这个分节，迷途的分节在路由器修复后也会被送到最终目的地，这个迟到的迷途分节到达时可能会引起问题。在关闭“前一个连接”之后，马上又重新建立起一个相同的IP和端口之间的“新连接”，“前一个连接”的迷途重复分组在“前一个连接”终止后到达，而被“新连接”收到了。为了避免这个情况，TCP协议不允许处于TIME_WAIT状态的连接启动一个新的可用连接，因为TIME_WAIT状态持续2MSL，就可以保证当成功建立一个新TCP连接的时候，来自旧连接重复分组已经在网络中消逝。因为在2MSl的时间内，迷途重复分组已经消逝了。





















