//
//  AutoCellCoreTextView.m
//  ExerciseProject
//
//  Created by 天空吸引我 on 2018/10/12.
//  Copyright © 2018年 天空吸引我. All rights reserved.
//

#import "AutoCellCoreTextView.h"
#import <CoreText/CoreText.h>

@interface AutoCellCoreTextView()


@end

@implementation AutoCellCoreTextView

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {

    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    if (self.data) {
        CTFrameDraw(self.data.ctFrame, context);
    }

}


@end
