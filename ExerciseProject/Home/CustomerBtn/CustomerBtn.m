//
//  CustomerBtn.m
//  ExerciseProject
//
//  Created by 天空吸引我 on 2018/9/5.
//  Copyright © 2018年 天空吸引我. All rights reserved.
//

#import "CustomerBtn.h"

@implementation CustomerBtn
/*
 对CGRectInset的解释
 CGRectInset(CGRect rect, CGFloat dx, CGFloat dy)作用是将rect坐标按照(dx,dy)进行平移，对size进行如下变换
 新宽度 = 原宽度 - 2*dx；新高度 = 原高度 - 2*dy
 即dx,dy为正，则为缩小点击范围；dx,dy为负的话，则为扩大范围
 */
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    //当前btn大小
    CGRect btnBounds = self.bounds;
    //扩大点击区域，想缩小就将-10设为正值
    btnBounds = CGRectInset(btnBounds, -100, -100);

    //若点击的点在新的bounds里，就返回YES
    return CGRectContainsPoint(btnBounds, point);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
