//
//  CustomerBtnVC.m
//  ExerciseProject
//
//  Created by 天空吸引我 on 2018/9/5.
//  Copyright © 2018年 天空吸引我. All rights reserved.
//

#import "CustomerBtnVC.h"
#import "CustomerBtn.h"
#import "TestView.h"
#import "UIButton+Clicked.h"
@interface CustomerBtnVC ()
@property (nonatomic,strong) CustomerBtn *btn;
@property (nonatomic,strong) TestView *testView;

@end

@implementation CustomerBtnVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.btn];
    [self.view addSubview:self.testView];
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(aviewAction)];
//    [self.view addGestureRecognizer:tap];

}
- (void)aviewAction {
    NSLog(@"单击");
}
- (UIButton *)btn {
    if (!_btn) {
        _btn = [[CustomerBtn alloc] init];
        _btn.backgroundColor = [UIColor blueColor];
        _btn.frame = CGRectMake(0, 100, 100, 50);
        [_btn setTitle:@"自定义btn" forState:UIControlStateNormal];
        [_btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _btn.timeInterval = 2;
        [_btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn;
}
- (TestView *)testView {
    if (!_testView) {
        _testView = [[TestView alloc] initWithFrame:CGRectMake(0, 300, 300, 300)];
        _testView.backgroundColor = [UIColor redColor];
    }
    return _testView;
}

- (void)btnClicked:(UIButton *)button {
    NSLog(@"扩大点击区域");
    NSLog(@"%@",NSStringFromCGRect(button.frame));

}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    NSLog(@"%@ touch begin", self.class);
//    UIResponder *next = [self nextResponder];
//    while (next) {
//        NSLog(@"%@",next.class);
//        next = [next nextResponder];
//    }
//}
//- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//
//    NSLog(@"%@ touch end", self.class);
//}


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
