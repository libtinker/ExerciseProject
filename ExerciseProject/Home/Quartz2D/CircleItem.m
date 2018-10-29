//
//  CircleItem.m
//  ExerciseProject
//
//  Created by 天空吸引我 on 2018/10/17.
//  Copyright © 2018年 天空吸引我. All rights reserved.
//

#import "CircleItem.h"

@implementation CircleItem

-(instancetype)init {

    if (self = [super init]) {
        _r = 0.8;
        _g = 0.8;
        _b = 0.8;
        _lineWidth = 20.0;
    }
    return self;
}

- (double)getPercentageWithConsumptionAmount:(NSString *)consumptionAmount {

    double percentage = consumptionAmount.doubleValue/_totalConsumption.doubleValue;
    return percentage;
}
@end
