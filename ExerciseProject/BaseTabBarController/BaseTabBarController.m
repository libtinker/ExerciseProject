//
//  BaseTabBarController.m
//  ExerciseProject
//
//  Created by 天空吸引我 on 2018/8/25.
//  Copyright © 2018年 天空吸引我. All rights reserved.
//


#import "BaseTabBarController.h"
#import "BaseNavigationController.h"
#import "HomeVC.h"
#import "MineVC.h"
#import "FJFNavigationControllerManager.h"


@interface BaseTabBarController ()

@end

@implementation BaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    HomeVC *home = [[HomeVC alloc] init];
    [self addChildVc:home title:@"首页" image:@"home-page" selectedImage:@"home-page" withTag:0];

    MineVC *mine = [[MineVC alloc] init];
    [self addChildVc:mine title:@"我的" image:@"home-page" selectedImage:@"home-page" withTag:1];
}
- (void)addChildVc:(UIViewController *)childVc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage withTag:(NSInteger)tag
{
    childVc.title = title;
    childVc.tabBarItem.title = title;
    childVc.navigationItem.title = title;
    childVc.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:10];
    [childVc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    NSMutableDictionary *textSelectAttrs = [NSMutableDictionary dictionary];
    textSelectAttrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:10];
    [childVc.tabBarItem setTitleTextAttributes:textSelectAttrs forState:UIControlStateSelected];

    UINavigationController *nav = [FJFNavigationControllerManager navigationControllerWithRootViewController:childVc];
//    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:childVc];
    [self addChildViewController:nav];
    childVc.tabBarItem.tag = tag;
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
