//
//  Quartz2DVC.m
//  ExerciseProject
//
//  Created by 天空吸引我 on 2018/10/17.
//  Copyright © 2018年 天空吸引我. All rights reserved.
//

#import "Quartz2DVC.h"
#import "LeoDemoView.h"

@interface Quartz2DVC ()

@end

@implementation Quartz2DVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Quartz2DVC";
    LeoDemoView * demoView = [[LeoDemoView alloc] initWithFrame:CGRectMake(10, 100, 200, 200)];
    [self.view addSubview:demoView];
    demoView.backgroundColor = [UIColor whiteColor];


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
