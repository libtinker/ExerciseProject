//
//  TestView.m
//  ExerciseProject
//
//  Created by 天空吸引我 on 2018/9/10.
//  Copyright © 2018年 天空吸引我. All rights reserved.
//

#import "TestView.h"

@implementation TestView

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

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    BOOL success = CGRectContainsPoint(self.bounds, point);
//    if (success) {
//        NSLog(@"点在%@里",self.class);
//    }else {
//        NSLog(@"点不在%@里",self.class);
//    }
    return success;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
