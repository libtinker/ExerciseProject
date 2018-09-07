//
//  HomeModel.m
//  ExerciseProject
//
//  Created by 天空吸引我 on 2018/8/25.
//  Copyright © 2018年 天空吸引我. All rights reserved.
//

#import "HomeModel.h"

@implementation HomeModel
- (id)initWithTitle:(NSString *)title vcName:(NSString *)vcName {
    if (self = [super init]) {
        _title = title;
        _vcName = vcName;
    }
    return self;
}

+ (NSArray *)getDataArray {

    HomeModel *model1 = [[HomeModel alloc] initWithTitle:@"KVO" vcName:@"KVOVC"];
    HomeModel *model2 = [[HomeModel alloc] initWithTitle:@"BlockVC" vcName:@"BlockVC"];
    HomeModel *model3 = [[HomeModel alloc] initWithTitle:@"NSSet" vcName:@"SetVC"];
    HomeModel *model4 = [[HomeModel alloc] initWithTitle:@"RunLoop" vcName:@"RunLoopVC"];
    HomeModel *model5 = [[HomeModel alloc] initWithTitle:@"自定义按钮" vcName:@"CustomerBtnVC"];
    HomeModel *model6 = [[HomeModel alloc] initWithTitle:@"copy使用" vcName:@"CopyVC"];
    HomeModel *model7 = [[HomeModel alloc] initWithTitle:@"Delegate使用" vcName:@"DelegateVC"];
    HomeModel *model8 = [[HomeModel alloc] initWithTitle:@"RuntimeVC" vcName:@"RuntimeVC"];
    return @[model1,model2,model3,model4,model5,model6,model7,model8];
}
@end
