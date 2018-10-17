//
//  ContentModel.h
//  ExerciseProject
//
//  Created by 天空吸引我 on 2018/10/16.
//  Copyright © 2018年 天空吸引我. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CTFrameParserConfig;
@class CoreTextData;
NS_ASSUME_NONNULL_BEGIN

@interface ContentModel : NSObject
@property (nonatomic,copy) NSString *headimg;
@property (nonatomic,copy) NSString *nickname;
@property (nonatomic,copy) NSString *describe;
@property (nonatomic,copy) NSString *img;
@property (nonatomic,strong) CTFrameParserConfig *config;
@property (nonatomic,strong) CoreTextData *data;

@end

NS_ASSUME_NONNULL_END
