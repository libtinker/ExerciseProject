//
//  DelegateTestVC.h
//  ExerciseProject
//
//  Created by 天空吸引我 on 2018/9/6.
//  Copyright © 2018年 天空吸引我. All rights reserved.
//

#import "BaseViewController.h"
@protocol DelegateTest
- (void)dismissDelegate:(NSString *)string;
@end
@interface DelegateTestVC : BaseViewController

@property (nonatomic, weak) id <DelegateTest> delegate;

@end
