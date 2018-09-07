//
//  CustomerBtnVC.m
//  ExerciseProject
//
//  Created by 天空吸引我 on 2018/9/5.
//  Copyright © 2018年 天空吸引我. All rights reserved.
//

#import "CustomerBtnVC.h"
#import "CustomerBtn.h"

@interface CustomerBtnVC ()
@property (nonatomic,strong) CustomerBtn *btn;

@end

@implementation CustomerBtnVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.btn];
}
- (UIButton *)btn {
    if (!_btn) {
        _btn = [CustomerBtn buttonWithType:UIButtonTypeCustom];
        _btn.backgroundColor = [UIColor blueColor];
        _btn.frame = CGRectMake(0, 100, 100, 50);
        [_btn setTitle:@"自定义btn" forState:UIControlStateNormal];
        [_btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn;
}

- (void)btnClicked:(UIButton *)button {
    NSLog(@"扩大点击区域");
    NSLog(@"%@",NSStringFromCGRect(button.frame));
    button.userInteractionEnabled = NO;
    dispatch_time_t  time = dispatch_time(DISPATCH_TIME_NOW, 1ull * NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{
        // NSLog(@"time时间后执行的代码");
         button.userInteractionEnabled = YES;
    });

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
