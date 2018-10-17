//
//  CTFrameParserConfig.h
//  ExerciseProject
//
//  Created by 天空吸引我 on 2018/10/15.
//  Copyright © 2018年 天空吸引我. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CoreTextData.h"

NS_ASSUME_NONNULL_BEGIN

@interface CTFrameParserConfig : NSObject


@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat fontSize;
@property (nonatomic, assign) CGFloat lineSpace;
@property (nonatomic, strong) UIColor *textColor;


@end

NS_ASSUME_NONNULL_END
