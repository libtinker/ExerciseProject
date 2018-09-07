//
//  SetVC.m
//  ExerciseProject
//
//  Created by 天空吸引我 on 2018/8/31.
//  Copyright © 2018年 天空吸引我. All rights reserved.
//

#import "SetVC.h"

@interface SetVC ()

@end

@implementation SetVC

- (void)viewDidLoad {
    [super viewDidLoad];

    NSSet *set = [NSSet setWithObjects:@"1",@"2",@"3", nil];
    NSLog(@"%@",set);

   BOOL have = [set containsObject:@"9"];
    NSLog(@"%@某个元素",have?@"包含":@"不包含");


    NSSet *set1 = [NSSet setWithObjects:@"a", @"b", @"c", @"d", nil];
    NSSet *set2 = [[NSSet alloc] initWithObjects:@"1", @"2", @"3", nil];
    NSArray *array = [NSArray arrayWithObjects:@"a", @"b", @"c", nil];
    NSSet *set3 = [NSSet setWithArray:array];

    NSLog(@"set1 :%@", set1);
    NSLog(@"set2 :%@", set2);
    NSLog(@"set3 :%@", set3);

    //获取集合个数
    NSLog(@"set1 count :%lu", (unsigned long)set1.count);

    //以数组的形式获取集合中的所有对象
    NSArray *allObj = [set2 allObjects];
    NSLog(@"allObj :%@", allObj);

    //获取任意一对象
    NSLog(@"anyObj :%@", [set3 anyObject]);

    //是否包含某个对象
    NSLog(@"contains :%d", [set3 containsObject:@"obj2"]);


    //是否包含指定set中的对象
    NSLog(@"intersect obj :%d", [set1 intersectsSet:set3]);

    //是否完全匹配
    NSLog(@"isEqual :%d", [set2 isEqualToSet:set3]);

    //是否是子集合
    NSLog(@"isSubSet :%d", [set3 isSubsetOfSet:set1]);



    NSSet *set4 = [NSSet setWithObjects:@"a", @"b", nil];
    NSArray *ary = [NSArray arrayWithObjects:@"1", @"2", @"3", @"4", nil];
    NSSet *set5 = [set4 setByAddingObjectsFromArray:ary];
    NSLog(@"addFromArray :%@", set5);




    NSMutableSet *mutableSet1 = [NSMutableSet setWithObjects:@"1", @"2", @"3", nil];
    NSMutableSet *mutableSet2 = [NSMutableSet setWithObjects:@"a", @"2", @"b", nil];
    NSMutableSet *mutableSet3 = [NSMutableSet setWithObjects:@"1", @"c", @"b", nil];

    //集合元素相减
    [mutableSet1 minusSet:mutableSet2];
    NSLog(@"minus :%@", mutableSet1);

    //只留下相等元素
    [mutableSet1 intersectSet:mutableSet3];
    NSLog(@"intersect :%@", mutableSet1);

    //合并集合
    [mutableSet2 unionSet:mutableSet3];
    NSLog(@"union :%@", mutableSet2);

    //删除指定元素
    [mutableSet2 removeObject:@"a"];
    NSLog(@"removeObj :%@", mutableSet2);


    //删除所有数据
    [mutableSet2 removeAllObjects];
    NSLog(@"removeAll :%@", mutableSet2);

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
