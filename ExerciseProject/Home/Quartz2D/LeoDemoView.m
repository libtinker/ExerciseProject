//
//  LeoDemoView.m
//  ExerciseProject
//
//  Created by 天空吸引我 on 2018/10/17.
//  Copyright © 2018年 天空吸引我. All rights reserved.
//

#import "LeoDemoView.h"
#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)



@implementation LeoDemoView

- (void)drawRect:(CGRect)rect {
    [self test3:rect];

}
//文字
- (void)test1:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor lightGrayColor].CGColor);
    CGContextFillRect(context, rect);//先填充整个区域
    CGRect testRect = CGRectMake(10, 10, 20, 20);
    CGContextAddRect(context, testRect);
    CGContextSetFillColorWithColor(context, [UIColor blueColor].CGColor);//修改画笔颜色
    CGContextFillRect(context, testRect);//填充部分区域

    NSString * toDraw = @"Leo";
    [toDraw drawAtPoint:CGPointMake(CGRectGetWidth(rect)/2, CGRectGetHeight(rect)/2) withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:[UIColor greenColor]}];

    CGContextSaveGState(context);
    //这行代码把坐标系移动到右下角
    CGContextTranslateCTM(context,rect.size.width,rect.size.height);
    //接着把坐标系逆时针旋转180度
    CGContextRotateCTM(context, M_PI);
    NSString * redHeart = @"呵呵";
    [redHeart drawAtPoint:CGPointMake(0, 0) withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}];

    CGContextRestoreGState(context);
}
//划线
- (void)test2:(CGRect)rect{
    CGContextRef context = UIGraphicsGetCurrentContext(); //获得当前context
    //设置颜色
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextSetStrokeColorWithColor(context, [UIColor lightGrayColor].CGColor);
    //为了颜色更好区分，对矩形描边
    CGContextFillRect(context, rect);
    CGContextStrokeRect(context, rect);
    //实际line和point的代码
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);// 设置描边颜色
    CGContextSetLineWidth(context, 1.0);//线的宽度
    CGContextSetLineCap(context, kCGLineCapRound);//线的顶端
    CGContextSetLineJoin(context, kCGLineJoinRound);//线相交的模式

    //虚线
    CGFloat lengths[] = {2};
    CGContextSetLineDash(context, 1, lengths, 1);
    CGContextMoveToPoint(context,10,10);
    CGContextAddLineToPoint(context, 40, 40);
    CGContextAddLineToPoint(context, 10, 80);
    CGContextStrokePath(context);


    //画圆
    CGContextAddArc(context,50,50, 25,M_PI_2,M_PI,1);
    CGContextStrokePath(context);
    /*CGContextAddArc: 参数
     c context
     x1,y1和当前点(x0,y0)决定了第一条切线（x0,y0）->(x1,y1)
     x2,y2和(x1,y1)决定了第二条切线
     radius,想切的半径。
     */
}


- (void)test3:(CGRect)rect
{



    //使用CGContextRef创建路径
    CGContextRef ctx = UIGraphicsGetCurrentContext();

//    CGContextSetTextMatrix(ctx, CGAffineTransformIdentity);
//    CGContextTranslateCTM(ctx, 0, self.bounds.size.height);
//    CGContextScaleCTM(ctx, 1.0, -1.0);



    CGContextAddArc(ctx, 100, 100, 50,DEGREES_TO_RADIANS(0), DEGREES_TO_RADIANS(180), 0);
    //修改图形状态参数
    CGContextSetRGBStrokeColor(ctx, 0.8, 0.8, 0.1, 2.0);//笔颜色
    CGContextSetLineWidth(ctx, 10);//线条宽度
    //渲染上下文
    CGContextStrokePath(ctx);


    //绘制路径: 圆形(中心坐标200、200、半径100、起点弧度0、终点弧度2PI、画的方向0逆1正) 第五个参数 是startAngle开始的角度
    CGContextAddArc(ctx, 100, 100, 50, DEGREES_TO_RADIANS(180), DEGREES_TO_RADIANS(300), 0);
    //修改图形状态参数
    CGContextSetRGBStrokeColor(ctx, 0.5, 0.5, 0.9, 2.0);//笔颜色
    CGContextSetLineWidth(ctx, 10);//线条宽度
    //渲染上下文
    CGContextStrokePath(ctx);

    //绘制路径: 圆形(中心坐标200、200、半径100、起点弧度0、终点弧度2PI、画的方向0逆1正) 第五个参数 是startAngle开始的角度
    CGContextAddArc(ctx, 100, 100, 50, DEGREES_TO_RADIANS(300), DEGREES_TO_RADIANS(60), 0);
    //修改图形状态参数
    CGContextSetRGBStrokeColor(ctx, 0.3, 0.3, 0.3, 2.0);//笔颜色
    CGContextSetLineWidth(ctx, 10);//线条宽度
    //渲染上下文
    CGContextStrokePath(ctx);

}






@end
