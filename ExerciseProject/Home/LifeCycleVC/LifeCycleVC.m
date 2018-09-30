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

- (void)viewDidLoad {

    [super viewDidLoad];
    switchTest();
     NSLog(@"viewDidLoad");
    NSMutableArray *mArr = [NSMutableArray arrayWithCapacity:10];
    for (int i = 0; i < 100; i++) {
        int x = arc4random() % 10;
        [mArr addObject:@(x)];
    }

    NSArray *arr = mArr.copy;
    NSMutableArray *mArr_2 = mArr.mutableCopy;
    NSSet *set = [[NSSet alloc] initWithArray:arr];

    NSMutableDictionary *mDict = [NSMutableDictionary dictionary];

    NSTimeInterval before = [[NSDate date] timeIntervalSince1970];
    [self cicleSelect:arr withSet:set withArr:mArr_2];
    NSTimeInterval time1 = [[NSDate date] timeIntervalSince1970];
    [self mapSelect:arr withDict:mDict];
    NSTimeInterval time2 = [[NSDate date] timeIntervalSince1970];

    NSLog(@"___\n%f\n%f\n___", time1 - before, time2 - time1);
    NSLog(@"");
}

- (void)cicleSelect:(NSArray *)arr withSet:(NSSet *)set withArr:(NSMutableArray *)mArr {

    NSUInteger maxCount = 0;
    NSNumber *maxCountNum = @(0);


    for(id x in arr){
        NSUInteger totalCount = mArr.count;
        [mArr removeObject:x];
       NSUInteger cCount = totalCount - mArr.count;
        if (cCount>maxCount) {
            maxCountNum = x;
            maxCount = cCount;

        }
    }

//    for (id x in set) {
//
//        NSUInteger coundBefore = mArr.count;
//        [mArr removeObject:x];
//        NSUInteger perCount = coundBefore - mArr.count;
//
//        if (perCount > maxCount) {
//            maxCount = perCount;
//            maxCountNum = x;
//        }
//    }
    NSLog(@"-----------%@",maxCountNum);
}

- (void)mapSelect:(NSArray *)arr withDict:(NSMutableDictionary *)mDict {

    for (id x in arr) {
        if (mDict[x]) {
            int count = [mDict[x] intValue];
            count++;
            mDict[x] = @(count);
        } else {
            mDict[x] = @(1);
        }
    }
    int maxCount = -1;
    int maxCountNum = 0;

    for (NSNumber *count in [mDict allKeys]) {
        if (maxCount < [mDict[count] intValue]) {
            maxCount = [mDict[count] intValue];
            maxCountNum = [count intValue];
        }
    }
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
void switchTest(){
    int a=23;
    int b=1;
    int c=0;
    char oper='+';
    switch(oper){
        case '+':
            c=a+b;
            break;
        case '-':
            c=a-b;
            break;
        case '*':
            c=a*b;
            break;
    }
    printf("c = %d %c %d = %d\n", a, oper, b, c);
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
