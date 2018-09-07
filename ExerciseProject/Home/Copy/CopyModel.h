//
//  CopyModel.h
//  ExerciseProject
//
//  Created by 天空吸引我 on 2018/9/5.
//  Copyright © 2018年 天空吸引我. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CopyModel : NSObject

@property (nonatomic,copy) NSMutableString *name;
@property (nonatomic,copy) NSMutableArray *array;

/*    为什么字符串使用copy修饰?
 这里先不使用copy修饰,NSString是OC对象,并且是ARC模式,所以先使用strong来修饰演示
 */
@property (nonatomic,strong) NSString *strongString;
@property (nonatomic,copy) NSString *stringCopy;
@end
