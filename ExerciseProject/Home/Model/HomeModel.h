//
//  HomeModel.h
//  ExerciseProject
//
//  Created by 天空吸引我 on 2018/8/25.
//  Copyright © 2018年 天空吸引我. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeModel : NSObject

@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *vcName;//要跳转的vc名字

+ (NSArray *)getDataArray;
@end
