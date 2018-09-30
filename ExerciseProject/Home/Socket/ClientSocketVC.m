//
//  ClientSocketVC.m
//  ExerciseProject
//
//  Created by 天空吸引我 on 2018/9/30.
//  Copyright © 2018年 天空吸引我. All rights reserved.
//

#import "ClientSocketVC.h"

@interface ClientSocketVC ()<NSStreamDelegate>
{
    NSInputStream *_inputStream;//输入流
    NSOutputStream *_outSttream;//输出流
}
@end

@implementation ClientSocketVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self connectToHost];
}

- (void)connectToHost {

    NSString *host = @"127.0.0.1";
    int port = 2345;

    //定义C语言输入输出流
    CFReadStreamRef readStream;
    CFWriteStreamRef writeStream;
    CFStreamCreatePairWithSocketToHost(NULL, (__bridge CFStringRef)host, port, &readStream, &writeStream);

    //把C语言的输入输出流转化成OC对象
    _inputStream = (__bridge NSInputStream *)(readStream);
    _outSttream = (__bridge NSOutputStream *)(writeStream);

    _inputStream.delegate = self;
    _outSttream.delegate = self;

      //把输入输入流添加到主运行循环
    [_inputStream scheduleInRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    [_outSttream scheduleInRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];

    [_inputStream open];
    [_outSttream open];

}

//Stream的代理方法
- (void)stream:(NSStream *)aStream handleEvent:(NSStreamEvent)eventCode {

    NSLog(@"%@",[NSThread currentThread]);

    //NSStreamEventOpenCompleted = 1UL << 0,//输入输出流打开完成//NSStreamEventHasBytesAvailable = 1UL << 1,//有字节可读//NSStreamEventHasSpaceAvailable = 1UL << 2,//可以发放字节//NSStreamEventErrorOccurred = 1UL << 3,//连接出现错误//NSStreamEventEndEncountered = 1UL << 4//连接结束

   switch(eventCode) {
                 case NSStreamEventOpenCompleted:
                 NSLog(@"输入输出流打开完成");
                break;

                case NSStreamEventHasBytesAvailable:
                 NSLog(@"有字节可读");
                 [self readData];
                break;

                 case  NSStreamEventHasSpaceAvailable:
                 NSLog(@"可以发送字节");
                 break;

                 case NSStreamEventErrorOccurred:
                 NSLog(@"连接出现错误");
                 break;

                 case NSStreamEventEndEncountered:
                 NSLog(@"连接结束");
                 //关闭输入输出流
                 [_inputStream close];
                 [_outSttream close];

                 //从主运行循环移除
                 [_inputStream removeFromRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
                 [_outSttream removeFromRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
                 break;

                 default:

                 break;
         }
}

- (void)readData {

     //建立一个缓冲区 可以放1024个字节
    uint8_t buf[1024];

    //返回实际装的字节数
    NSInteger len = [_inputStream read:buf maxLength:sizeof(buf)];

    //把字节数组转化成字符串
    NSData *data = [NSData dataWithBytes:buf length:len];
    NSString *recStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
     NSLog(@"%@",recStr);
}

//发送数据
- (void)sendData {

    NSString *text = @"我要发送数据";
    NSData *data = [text dataUsingEncoding:NSUTF8StringEncoding];
    [_outSttream write:data.bytes maxLength:data.length];
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
