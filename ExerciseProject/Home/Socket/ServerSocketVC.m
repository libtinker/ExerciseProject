//
//  ServerSocketVC.m
//  ExerciseProject
//
//  Created by 天空吸引我 on 2018/9/30.
//  Copyright © 2018年 天空吸引我. All rights reserved.
//

#import "ServerSocketVC.h"
#include <sys/socket.h>
#include <netinet/in.h>

@interface ServerSocketVC ()
{
    //服务端的标志
    int server_flag;

    //客户端的标志
    int client_flag;

    //具体的计算机
    struct sockaddr_in address;
}
@end

@implementation ServerSocketVC

- (void)viewDidLoad {
    [super viewDidLoad];


    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated {

    //-----服务端，最基本的功能就这7步。

    //1.创建服务端得标识符int。
    server_flag = socket(AF_INET, SOCK_STREAM, 0);
    //第一个参数属于网络类型，ipv4和ipv6,第二个参数为选择协议(流媒体)


    //2.将服务端的标识符绑定到具体的计算机(ip,port)里面。那么，这个计算机就成为了服务器了。
    //生成一个具体的计算机
    address.sin_port = htons(2345);
    address.sin_family = AF_INET;
    address.sin_addr.s_addr = INADDR_ANY;//指的是本机

    //用来判断是否绑定成功
    int error = -1;


    //绑定
    error = bind(server_flag, (struct sockaddr *)&address, sizeof(address));


    //3.服务端要做好能同时处理多少个链接的事情。
    error = listen(server_flag, 100);
    //第一个参数是判定是哪一个服务端，第二个参数代表多少个


    //4.服务端要做好等待的准备，等待客户端连接请求的准备。
    while (1) {
        //5.接到一个请求，将收到的客户端链接请求生成一个标志位，作为某一个客户端的标志。
        client_flag = accept(server_flag, NULL, NULL);

        //指定了有多少个就有多少个大小的数组在服务端存着的。
        //6.通过客户端的标志位，进行消息传输。
        //--6.1 接收数据...
        //声明缓存位置，把接收到得数据存在哪
        char buffer[1024];

        int length = recv(client_flag, buffer, (long)1024, -1);


        buffer[length] = '\0';

        printf("client flag : %s",buffer);

        //--6.2 发送消息...
        send(client_flag, "who are you?\n", 50, -1);

        //所以，从第7步来讲的话，http协议的底层实际上也是用Socket的实现的。因为http是短连接，也就是请求一次，获取一次。这里有取消链接的话，就是每次请求就断开。
        //7.若客户端 取消链接，那么服务端需要关闭该客户端的标志位。
        close(client_flag);
    }

    //之后，比如服务端和客户端通信，客户端和客户端通信，这样的功能属于逻辑方面的考虑。属于高层次的编码。

}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
