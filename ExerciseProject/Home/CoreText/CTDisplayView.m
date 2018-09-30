//
//  CTDisplayView.m
//  ExerciseProject
//
//  Created by 天空吸引我 on 2018/9/14.
//  Copyright © 2018年 天空吸引我. All rights reserved.
//

#import "CTDisplayView.h"
#import <CoreText/CoreText.h>

@implementation CTDisplayView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    //得到当前的画布
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //坐标系上下翻转 底层的绘制引擎 屏幕的左下角是（0，0）坐标
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    //创建绘制区域
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, self.bounds);
//    CGPathAddEllipseInRect(path, NULL, self.bounds);
    
    NSAttributedString *attString = [[NSAttributedString alloc] initWithString:@"Hello Worldnit初始化不会触发layoutSubviews。2、addSubview会触发layoutSubviews。 3、设置view的Frame会触发layoutSubviews，当然前提是frame的值设置前后发生了变化。4、滚动一个UIScroll"];
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attString);
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, attString.length), path, NULL);
    
    CTFrameDraw(frame, context);
    CFRelease(frame);
    CFRelease(path);
    CFRelease(framesetter);
}

@end
