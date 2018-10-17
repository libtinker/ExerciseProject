//
//  CTFrameParser.h
//  ExerciseProject
//
//  Created by 天空吸引我 on 2018/10/15.
//  Copyright © 2018年 天空吸引我. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CTFrameParserConfig.h"
#import "CoreTextData.h"

NS_ASSUME_NONNULL_BEGIN

@interface CTFrameParser : NSObject

/**
 *  根据属性文字对象和配置信息对象生成CoreTextData对象
 *
 *  @param content 属性文字对象
 *  @param config  配置信息对象
 *
 *  @return CoreTextData对象
 */
+ (CoreTextData *)parseAttributedContent:(NSAttributedString *)content
                                  config:(CTFrameParserConfig *)config;

/**
 *  根据传入配置信息配置文字属性字典
 *
 *  @param config 配置信息对象
 *
 *  @return 配置文字属性字典
 */
+ (NSMutableDictionary *)attributesWithConfig:(CTFrameParserConfig *)config;


+ (CoreTextData *)parseTemplateFile:(NSString *)path config:(CTFrameParserConfig*)config;


@end

NS_ASSUME_NONNULL_END
