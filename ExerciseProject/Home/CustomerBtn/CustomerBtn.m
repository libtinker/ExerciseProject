//
//  CustomerBtn.m
//  ExerciseProject
//
//  Created by 天空吸引我 on 2018/9/5.
//  Copyright © 2018年 天空吸引我. All rights reserved.
//

#import "CustomerBtn.h"

@implementation CustomerBtn
- (instancetype)init {
    if (self = [super init]) {
        a = 3;
    }
    return self;
}
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
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    if (!self.isUserInteractionEnabled || self.isHidden || self.alpha <= 0.01) return nil;
    //判断点在不在这个视图里
    if ([self pointInside:point withEvent:event]) {
        //在这个视图 遍历该视图的子视图
        for (UIView *subview in [self.subviews reverseObjectEnumerator]) {
            //转换坐标到子视图
            CGPoint convertedPoint = [subview convertPoint:point fromView:self];
            //递归调用hitTest:withEvent继续判断
            UIView *hitTestView = [subview hitTest:convertedPoint withEvent:event];
            if (hitTestView) {
                //在这里打印self.class可以看到递归返回的顺序。
                return hitTestView;
            }
        }
        //这里就是该视图没有子视图了 点在该视图中，所以直接返回本身，上面的hitTestView就是这个。
        NSLog(@"命中的view:%@",self.class);
        return self;
    }
    //不在这个视图直接返回nil
    return nil;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
