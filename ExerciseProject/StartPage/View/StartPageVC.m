//
//  StartPageVC.m
//  ExerciseProject
//
//  Created by 天空吸引我 on 2018/8/25.
//  Copyright © 2018年 天空吸引我. All rights reserved.
//

#import "StartPageVC.h"
#import "BaseTabBarController.h"
#define WS(weakSelf) __weak __typeof(&*self)weakSelf = self;


@interface StartPageVC ()

@property (nonatomic,strong) UIImageView *startImageView;
@property (nonatomic,strong) BaseTabBarController *tabBar;

@end

@implementation StartPageVC

- (instancetype)init {
    self = [super init];
    if (self) {
        self.tabBar = [[BaseTabBarController alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.startImageView];

    WS(weakSelf)
    dispatch_time_t  time = dispatch_time(DISPATCH_TIME_NOW, 1ull * NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{
        [weakSelf pushTabBarController];
    });
}

- (UIImageView *)startImageView {
    if (!_startImageView) {
        _startImageView = [[UIImageView alloc] initWithFrame:self.view.frame];
        _startImageView.image = [UIImage imageNamed:@"startImg"];
    }
    return _startImageView;
}

- (void)pushTabBarController {
    CATransition *animation = [CATransition animation];
    animation.duration = 1.0f;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.type = @"fade";//@"cube";
    [animation setSubtype:kCATransitionFromRight]; //从右向左
    [self.navigationController.view.layer addAnimation:animation forKey:@"animation"];
    [self presentViewController:self.tabBar animated:NO completion:nil];
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
