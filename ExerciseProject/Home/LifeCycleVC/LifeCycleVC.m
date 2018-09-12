//
//  LifeCycleVC.m
//  ExerciseProject
//
//  Created by 天空吸引我 on 2018/9/11.
//  Copyright © 2018年 天空吸引我. All rights reserved.
//

#import "LifeCycleVC.h"

@interface LifeCycleVC ()
@property (nonatomic, weak) NSTimer *timer;
@end

@implementation LifeCycleVC

+ (void)load {
     NSLog(@"我是class的load方法");
}

+ (void)initialize {
    NSLog(@"initialize");
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        NSLog(@"initWithNibName");
    }
    return self;
}
- (id)init {
    if (self = [super init]) {
        
        _timer = [NSTimer scheduledTimerWithTimeInterval:1
                                                  target:self
                                                selector:@selector(updateTime)
                                                userInfo:nil
                                                 repeats:YES];


        NSLog(@"init");
    }
    return self;
}
- (void)updateTime {

}
//- (void)loadView {
//      NSLog(@"loadView");
//}
- (void)viewDidLoad {
    NSLog(@"viewDidLoad");
}

- (void)viewWillAppear:(BOOL)animated {

    NSLog(@"viewWillAppear");
}

- (void)viewDidAppear:(BOOL)animated {

    NSLog(@"viewDidAppear");
}

- (void)viewWillDisappear:(BOOL)animated {

    NSLog(@"viewWillDisappear");
}
- (void)viewDidDisappear:(BOOL)animated {

    NSLog(@"viewDidDisappear");

    //写在这里也会有问题，以为push到下个页面的话，时间也将会被销毁，（应该写在返回的点击时间上）
    [_timer invalidate];
    _timer = nil;

}
- (void)dealloc
{
    NSLog(@"dealloc");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
