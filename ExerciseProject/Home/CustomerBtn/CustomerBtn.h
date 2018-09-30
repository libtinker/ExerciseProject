//
//  CustomerBtn.h
//  ExerciseProject
//
//  Created by 天空吸引我 on 2018/9/5.
//  Copyright © 2018年 天空吸引我. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomerBtn : UIButton
{
    @public ;
    int a;
}
@property (copy) NSMutableArray *array;
@property (nonatomic,assign) NSTimeInterval timeInterval;
@property (nonatomic,assign) BOOL clickedFinish;
@end
