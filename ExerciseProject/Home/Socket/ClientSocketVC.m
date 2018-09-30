//
//  ClientSocketVC.m
//  ExerciseProject
//
//  Created by 天空吸引我 on 2018/9/30.
//  Copyright © 2018年 天空吸引我. All rights reserved.
//

#import "ClientSocketVC.h"
#import <sys/socket.h>
#import <netinet/in.h>
#import <arpa/inet.h>
#import <unistd.h>
#import <netinet/tcp.h>

@interface ClientSocketVC ()<NSStreamDelegate>
{
    CFSocketRef _socket;
}
@end

static ClientSocketVC *selfClass = nil;//在c函数里可使用其调自身方法或属性
@implementation ClientSocketVC


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    selfClass = self;
    [self creatConnect];

}

/**
 创建连接
 */

- (void)creatConnect {

    CFSocketContext sockContext = {0,NULL, NULL,NULL,NULL};
    _socket = CFSocketCreate(kCFAllocatorDefault,//为对象分配内存 可为nil,
                             PF_INET,//协议族，0或负数 默认为 PF_INET,
                             SOCK_STREAM,//套接字类型，协议族为PF_INET 默认,
                             IPPROTO_TCP,//套接字协议,
                             kCFSocketConnectCallBack,//触发回调消息类型,
                             TCPServerConnectCallBack ,//回调函数,
                              &sockContext//一个持有CFSocket结构信息的对象，可以为nil
                             );

    if (_socket != nil) {
        //配置服务器地址
         struct sockaddr_in addr4; //IPV4
        memset(&addr4, 0, sizeof(addr4));
        addr4.sin_len=sizeof(addr4);
        addr4.sin_family=AF_INET;//协议族
        addr4.sin_port=htons(1234);//端口号
        addr4.sin_addr.s_addr=inet_addr([@"172.30.14.63" UTF8String]); // 把字符串的地址转换为机器可识别的网络地址

        CFDataRef address=CFDataCreate(kCFAllocatorDefault, (UInt8 *)&addr4 , sizeof(addr4));
        //绑定socket
        CFSocketConnectToAddress(_socket, address, -1);//连接超时时间，如果为负，则不尝试连接，而是把连接放在后台进行，如果_socket消息类型为kCFSocketConnectCallBack，将会在连接成功或失败的时候在后台触发回调函数

        CFRunLoopRef cRunRef = CFRunLoopGetCurrent();
        CFRunLoopSourceRef sourceRef=CFSocketCreateRunLoopSource(kCFAllocatorDefault, _socket, 0);
        CFRunLoopAddSource(cRunRef, sourceRef, kCFRunLoopCommonModes);
        CFRelease(sourceRef);
    }

}

static void TCPServerConnectCallBack(CFSocketRef s,CFSocketCallBackType type,CFDataRef address,const void *data,void *info) {

    NSLog(@"%@",info);

    if (data!=NULL && type ==kCFSocketConnectCallBack) {
        NSLog(@"连接失败");
        return;
    }

    //使用异步线程监听有没有收到数据
    [NSThread detachNewThreadSelector:@selector(readMessage) toTarget:selfClass withObject:nil];
}

- (void)readMessage {

    //监听收到的数据
    char buf[2048];
    NSString *logStr;
    do {

        // 接收数据
        ssize_t recvLen = recv(CFSocketGetNative(_socket), buf,
                               sizeof(buf), 0);

        if (recvLen > 0) {

            logStr = [NSString stringWithFormat:@"%@\n", [NSString stringWithFormat:@"%s", buf]];

            // 回到主线程刷新UI
            [self performSelectorOnMainThread:@selector(showMessage:) withObject:logStr waitUntilDone:YES];
        }

    } while (strcmp(buf,"exit") != 0);

}

- (void)sendMessage {

    NSString*stringTosend = @"发送数据";
    const char *data = [stringTosend UTF8String];

    send(CFSocketGetNative(_socket), data,strlen(data) + 1,0);
}

- (void)showMessage:(NSString *)message {

    NSLog(@"%@",message);

}
- (void) touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self sendMessage];
}
@end
