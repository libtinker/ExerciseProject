//
//  HomeViewModel.m
//  ExerciseProject
//
//  Created by 天空吸引我 on 2018/8/25.
//  Copyright © 2018年 天空吸引我. All rights reserved.
//

#import "HomeViewModel.h"
#import "HomeModel.h"
@interface HomeViewModel()
@end
@implementation HomeViewModel



- (NSArray *)getDataArray {
    return  [HomeModel getDataArray];
}


@end
