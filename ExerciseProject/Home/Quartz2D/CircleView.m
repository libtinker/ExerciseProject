//
//  CircleView.m
//  ExerciseProject
//
//  Created by 天空吸引我 on 2018/10/17.
//  Copyright © 2018年 天空吸引我. All rights reserved.
//

#import "CircleView.h"
#import "CircleItem.h"
#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)
@interface CircleView ()
{
    double _startAngle;
    double _endAngle;

}
@end

@implementation CircleView

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        _startAngle = 0;
        _endAngle = 0;
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {

    [super drawRect:rect];

    if (_circleItemArray == nil) {
        return;
    }

    for (int i=0; i<_circleItemArray.count; i++) {
        CircleItem *item = _circleItemArray[i];
        [self drawCircleLineRect:CGRectMake(0, 0, 200, 200) circleItem:item];

        [self drawCircleRect:CGRectMake(200, 50+25*i, 20, 20) circleItem:item];
        [self drawText:item.name rect:CGRectMake(220, 50+25*i, 60, 20)];

        NSString *fraction = item.consumptionAmount;
        [self drawText:fraction rect:CGRectMake(280, 50+25*i, 50, 20)];
    }
}

//画环形图
- (void)drawCircleLineRect:(CGRect)rect circleItem:(CircleItem *)circleItem  {

    _endAngle = _startAngle + circleItem.percentage*360.0;

    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //绘制路径: 圆形(中心坐标200、200、半径100、起点弧度0、终点弧度2PI、画的方向0逆1正) 第五个参数 是startAngle开始的角度
    CGContextAddArc(ctx,  rect.size.width/2, rect.size.height/2, 50, DEGREES_TO_RADIANS(_startAngle), DEGREES_TO_RADIANS(_endAngle), 0);
    CGContextSetRGBStrokeColor(ctx, circleItem.r, circleItem.g, circleItem.b, 1.0);
    CGContextSetLineWidth(ctx, circleItem.lineWidth);//线条宽度
    CGContextStrokePath(ctx);

    _startAngle =_endAngle;

}

//把文字渲染到屏幕上
- (void)drawText:(NSString *)text rect:(CGRect)rect {

     NSDictionary *attributeDict = @{NSFontAttributeName:[UIFont systemFontOfSize:13],NSForegroundColorAttributeName:[UIColor blackColor]};
    [text drawInRect:rect withAttributes:attributeDict];
}

//画圆
- (void)drawCircleRect:(CGRect)rect circleItem:(CircleItem *)circleItem {

    CGContextRef ctx = UIGraphicsGetCurrentContext();//1.0获取上下文
    CGContextAddArc(ctx,  rect.size.width/2+rect.origin.x, rect.size.height/2+rect.origin.y, 2.5, DEGREES_TO_RADIANS(0), DEGREES_TO_RADIANS(360), 0);
    CGContextSetRGBStrokeColor(ctx, circleItem.r, circleItem.g, circleItem.b, 1.0);
    CGContextSetLineWidth(ctx, 5);//线条宽度
    CGContextStrokePath(ctx);
}

@end
