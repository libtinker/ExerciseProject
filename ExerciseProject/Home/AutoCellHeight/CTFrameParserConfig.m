//
//  CTFrameParserConfig.m
//  ExerciseProject
//
//  Created by 天空吸引我 on 2018/10/15.
//  Copyright © 2018年 天空吸引我. All rights reserved.
//

#import "CTFrameParserConfig.h"

@implementation CTFrameParserConfig
- (id)init {
    self = [super init];
    if (self) {
        _width = 200.0f;
        _fontSize = 16.0f;
        _lineSpace = 8.0f;
        _textColor = [UIColor blackColor];
    }
    return self;
}
@end
