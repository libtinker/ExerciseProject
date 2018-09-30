//
//  ServerSocketVC.m
//  ExerciseProject
//
//  Created by 天空吸引我 on 2018/9/30.
//  Copyright © 2018年 天空吸引我. All rights reserved.
//

#import "ServerSocketVC.h"
#import <sys/socket.h>
#import <netinet/in.h>
#import <arpa/inet.h>
#import <unistd.h>
#import <netinet/tcp.h>

@interface ServerSocketVC ()
{
    CFSocketRef _socket;
    NSMutableArray *addressArr;
}
@end

static CFWriteStreamRef outputStream;
static ServerSocketVC *selfClass = nil;

@implementation ServerSocketVC

- (void)viewDidLoad {
    [super viewDidLoad];

    selfClass = self;
    outputStream = NULL;
        if ([self creatConnect]) {

//            CFRunLoopRun();
        }
    // Do any additional setup after loading the view.
}

- (BOOL) creatConnect{

    _socket=CFSocketCreate(kCFAllocatorDefault,
                               PF_INET, SOCK_STREAM,
                               IPPROTO_TCP, kCFSocketAcceptCallBack,
                               TCPServerAcceptCallBack,
                               NULL);


    if (_socket==NULL) {
        NSLog(@"cannot creat socket");
        return 0;
    }

    int optval=1;
    setsockopt(CFSocketGetNative(_socket),
                   SOL_SOCKET, SO_REUSEADDR, (void *)&optval,
                   sizeof(optval));

    struct sockaddr_in addr4;
    memset(&addr4,0, sizeof(addr4));
    addr4.sin_len=sizeof(addr4);
    addr4.sin_family=PF_INET;
    addr4.sin_port=htons(8888);
    addr4.sin_addr.s_addr=htonl(INADDR_ANY);

    CFDataRef address=CFDataCreate(kCFAllocatorDefault, (UInt8*)&addr4,
                                       sizeof(addr4));


    if (CFSocketSetAddress(_socket, address) !=kCFSocketSuccess) {
        NSLog(@"Bind to address failed!");
        if (_socket) {
            CFRelease(_socket);
            _socket=NULL;
        }
        return 0;
    }

    CFRunLoopRef cRunLoop=CFRunLoopGetCurrent();
    CFRunLoopSourceRef source=CFSocketCreateRunLoopSource(kCFAllocatorDefault,
                                                              _socket,
                                                              0);
    CFRunLoopAddSource(cRunLoop, source,
                           kCFRunLoopCommonModes);
    CFRelease(source);
    return 1;

}

static void TCPServerAcceptCallBack(CFSocketRef socket,CFSocketCallBackType
                                    type,CFDataRef address,const
                                    void *data,void *info){

    if (kCFSocketAcceptCallBack == type) {

        CFSocketNativeHandle nativeSocketHandle=*(CFSocketNativeHandle *)data;
        uint8_t name[SOCK_MAXADDRLEN];
        socklen_t nameLen=sizeof(name);

        if (getpeername(nativeSocketHandle, (struct sockaddr*)name, &nameLen)) {

            NSLog(@"error");
            exit(1);
        }

        NSLog(@"%s connected",inet_ntoa(((struct sockaddr_in*)name)->sin_addr));

        CFReadStreamRef readStream;
        CFWriteStreamRef writeStream;

        CFStreamCreatePairWithSocket(kCFAllocatorDefault, nativeSocketHandle, &readStream, &writeStream);

        if (readStream && writeStream) {

            [selfClass->addressArr addObject:(__bridge  id _Nonnull)(writeStream)];

            NSString *addre=[NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in*)name)->sin_addr)];

            NSLog(@"%@",addre);

            CFStreamClientContext streamContext={0,(__bridge void*)(addre),NULL,NULL};
            if (!CFReadStreamSetClient(readStream,kCFStreamEventHasBytesAvailable,readStreamFunc, &streamContext)) {
                exit(1);
            }

            if (!CFWriteStreamSetClient(writeStream,kCFStreamEventCanAcceptBytes,writeStreamFunc, &streamContext)) {

                exit(1);
            }

            CFReadStreamScheduleWithRunLoop(readStream,CFRunLoopGetCurrent(),kCFRunLoopCommonModes);

            CFWriteStreamScheduleWithRunLoop(writeStream,CFRunLoopGetCurrent(),kCFRunLoopCommonModes);
            CFReadStreamOpen(readStream);
            CFWriteStreamOpen(writeStream);

        }else{
            close(nativeSocketHandle);
        }
    }
}

/**
  读取数据
  */

void readStreamFunc(CFReadStreamRef stream,
                    CFStreamEventType type,
                    void *clientCallBackInfo){

    UInt8 buff[255];
    CFReadStreamRead(stream, buff,
                         255);

    printf("received %s",buff);
    NSString *str=[NSString
                       stringWithCString:(char *)buff
                       encoding:NSUTF8StringEncoding];

    [selfClass showReciveData:str];
}

void writeStreamFunc(CFWriteStreamRef stream,
                     CFStreamEventType type,
                     void *clientCallBackInfo){

}





-(void)sendStream{


//    int index=[self.clientTf.text
//                   intValue];

    NSString *ip = @"123";
    UInt8 buff[1024];
    NSString *sendText = @"我是服务端";

    memcmp(buff, [sendText UTF8String], sizeof(buff));



    //    给指定客户端发送消息
    outputStream=(__bridge CFWriteStreamRef)(ip);

    CFWriteStreamWrite(outputStream, (UInt8
                                          *)sendText.UTF8String,
                           strlen(sendText.UTF8String)+1
                           + 1);
}

-(void)showReciveData:(NSString *)str{
    NSLog(@"readStreamFunc ------------- %@",str);
}
- (IBAction)send:(id)sender {

    [self sendStream];

}

@end
