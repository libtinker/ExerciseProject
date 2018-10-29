//
//  Quartz2DVC.m
//  ExerciseProject
//
//  Created by 天空吸引我 on 2018/10/17.
//  Copyright © 2018年 天空吸引我. All rights reserved.
//

#import "Quartz2DVC.h"
#import "LeoDemoView.h"
#import "CircleView.h"
#import "CircleItem.h"

@interface Quartz2DVC ()

@end

@implementation Quartz2DVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Quartz2DVC";
//    LeoDemoView * demoView = [[LeoDemoView alloc] initWithFrame:CGRectMake(10, 100, 200, 200)];
//    [self.view addSubview:demoView];
//    demoView.backgroundColor = [UIColor whiteColor];



    CircleItem *item1 = [[CircleItem alloc] init];
    item1.r = 0.9;
    item1.g = 0.6;
    item1.b = 0.8;
    item1.consumptionAmount = @"5000";
    item1.name = @"消费购物";
    item1.totalConsumption = @"9100";
    item1.percentage = [item1 getPercentageWithConsumptionAmount:item1.consumptionAmount];

    CircleItem *item2 = [[CircleItem alloc] init];
    item2.r = 0.6;
    item2.g = 0.6;
    item2.b = 0.9;
    item2.consumptionAmount = @"800";
    item2.name = @"生活缴费";
    item2.totalConsumption = @"9100";
    item2.percentage = [item2 getPercentageWithConsumptionAmount:item2.consumptionAmount];

    CircleItem *item3 = [[CircleItem alloc] init];
    item3.r = 0.8;
    item3.g = 0.5;
    item3.b = 0.9;
    item3.name = @"金融理财";
    item3.consumptionAmount = @"1500";
    item3.totalConsumption = @"9100";
    item3.percentage = [item3 getPercentageWithConsumptionAmount:item3.consumptionAmount];

    CircleItem *item4 = [[CircleItem alloc] init];
    item4.r = 0.4;
    item4.g = 0.8;
    item4.b = 1.0;
    item4.name = @"其他";
    item4.consumptionAmount = @"1800";
    item4.totalConsumption = @"9100";
    item4.percentage = [item4 getPercentageWithConsumptionAmount:item4.consumptionAmount];

    CircleView * circleView = [[CircleView alloc] initWithFrame:CGRectMake(10, 100, [UIScreen mainScreen].bounds.size.width-20, 200)];
    circleView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:circleView];
    circleView.circleItemArray = @[item1,item2,item3,item4];
    [circleView setNeedsLayout];


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
