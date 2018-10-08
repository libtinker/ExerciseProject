//
//  CoreTextVC.m
//  ExerciseProject
//
//  Created by 天空吸引我 on 2018/9/14.
//  Copyright © 2018年 天空吸引我. All rights reserved.
//

#import "CoreTextVC.h"
#import "CTDisplayView.h"


@interface CoreTextVC ()
@property (nonatomic,strong)CTDisplayView *displayView;
@end

@implementation CoreTextVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.displayView];
    [self.displayView setNeedsDisplay];
}

- (CTDisplayView *)displayView {
    if (!_displayView) {
        _displayView = [[CTDisplayView alloc] initWithFrame:CGRectMake(0, 88, self.view.frame.size.width, self.view.frame.size.height-88)];
    }
    return _displayView;
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
