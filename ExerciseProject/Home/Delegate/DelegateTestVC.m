//
//  DelegateTestVC.m
//  ExerciseProject
//
//  Created by 天空吸引我 on 2018/9/6.
//  Copyright © 2018年 天空吸引我. All rights reserved.
//

#import "DelegateTestVC.h"

@interface DelegateTestVC ()

@end

@implementation DelegateTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    if (self.delegate) {
        [self.delegate dismissDelegate:@"hahhahaha"];
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc {
    
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
