//
//  CoreTextData.h
//  ExerciseProject
//
//  Created by 天空吸引我 on 2018/10/15.
//  Copyright © 2018年 天空吸引我. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>

NS_ASSUME_NONNULL_BEGIN

@interface CoreTextData : NSObject
@property (assign, nonatomic) CTFrameRef ctFrame;
@property (assign, nonatomic) CGFloat height;
@property (strong, nonatomic) NSAttributedString *content;
@end

NS_ASSUME_NONNULL_END
