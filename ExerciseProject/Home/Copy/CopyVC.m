//
//  CopyVC.m
//  ExerciseProject
//
//  Created by 天空吸引我 on 2018/9/5.
//  Copyright © 2018年 天空吸引我. All rights reserved.
//

#import "CopyVC.h"
#import "CopyModel.h"
@interface CopyVC ()
@end

@implementation CopyVC

- (void)viewDidLoad {
    [super viewDidLoad];

    CopyModel *model = [[CopyModel alloc] init];
    model.name = [NSMutableString stringWithFormat:@"aaaaa"];
    NSLog(@"类型：%@",model.name.class);

    model.array = [NSMutableArray array];
     NSLog(@"类型：%@",model.array.class);

    NSMutableString *str = [NSMutableString stringWithString:@"123"];
    model.strongString = str;
    model.stringCopy = str;
    [str appendString:@"456"];
    NSLog(@"strongString:%@  ---- stringCopy:%@",model.strongString,model.stringCopy);
    NSLog(@"str:%p",str);
    NSLog(@"strongString:%p  ---- stringCopy:%p",model.strongString,model.stringCopy);


    NSString *str2 = [NSString string];
    str2 = @"xiaoming";
    

    model.strongString = str;
    NSLog(@"str:%p,name:%p",str2,model.strongString);

    str2 = @"xiaogang";
    NSLog(@"str:%p,name:%p",str2,model.strongString);

    NSLog(@"%@",model.strongString);



    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
