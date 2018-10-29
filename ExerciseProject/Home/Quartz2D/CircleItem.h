//
//  CircleItem.h
//  ExerciseProject
//
//  Created by 天空吸引我 on 2018/10/17.
//  Copyright © 2018年 天空吸引我. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@interface CircleItem : NSObject

@property (nonatomic,assign) float r;
@property (nonatomic,assign) float g;
@property (nonatomic,assign) float b;
@property (nonatomic,assign) float lineWidth;//线宽
@property (nonatomic,assign) double percentage;//百分比
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *consumptionAmount;//消费金额
@property (nonatomic,copy) NSString *totalConsumption;//消费总额

- (double)getPercentageWithConsumptionAmount:(NSString *)consumptionAmount;
@end

NS_ASSUME_NONNULL_END
