//
//  DelegateVC.m
//  ExerciseProject
//
//  Created by 天空吸引我 on 2018/9/6.
//  Copyright © 2018年 天空吸引我. All rights reserved.
//

#import "DelegateVC.h"
#import "DelegateTestVC.h"

@interface DelegateVC ()<DelegateTest>

@property (nonatomic,strong) UIButton *testBtn;
@end

@implementation DelegateVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"代理的使用";
    [self.view addSubview:self.testBtn];
  


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIButton *)testBtn {
    if (!_testBtn) {
        _testBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_testBtn setTitle:@"测试" forState:UIControlStateNormal];
        [_testBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_testBtn addTarget:self action:@selector(buttopnClicked:) forControlEvents:UIControlEventTouchUpInside];
        _testBtn.frame = CGRectMake(100, 100, 100, 50);
    }
    return _testBtn;
}
- (void)buttopnClicked:(UIButton *)button {
    DelegateTestVC *ctrl = [[DelegateTestVC alloc] init];
    ctrl.delegate = self;
    [self.navigationController pushViewController:ctrl animated:YES];

}
- (void)dismissDelegate:(NSString *)string {
    [_testBtn setTitle:string forState:UIControlStateNormal];
}

- (void)viewDidAppear:(BOOL)animated {
}
@end
