//
//  BlockVC.m
//  ExerciseProject
//
//  Created by 天空吸引我 on 2018/8/30.
//  Copyright © 2018年 天空吸引我. All rights reserved.
//

#import "BlockVC.h"

@interface BlockVC ()

@end

@implementation BlockVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self test1];
    [self test2];
    [self test3];
}
- (void)test1 {

   __block NSArray *arr = nil;

    void (^testBlock)(NSArray *) = ^(NSArray *array){
        arr = array;
        NSLog(@"NSArray需要__block修饰否则会报错%@",arr);
    };
    testBlock(@[@"1"]);
}

- (void)test2 {

    NSMutableArray *mArr = [NSMutableArray array];

    void (^testBlock)(NSArray *) = ^(NSArray *array){
        [mArr addObjectsFromArray:array];
//        mArr = array;
        NSLog(@"NSMutableArray不需要__block修饰%@",mArr);
    };
    testBlock(@[@"1"]);
}
- (void)test3 {
    { };
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
