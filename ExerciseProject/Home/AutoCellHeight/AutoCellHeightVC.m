//
//  AutoCellHeightVC.m
//  ExerciseProject
//
//  Created by 天空吸引我 on 2018/10/10.
//  Copyright © 2018年 天空吸引我. All rights reserved.
//

#import "AutoCellHeightVC.h"
#import "AutoHeightCell.h"

@interface AutoCellHeightVC ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *_dataArray;
}
@property (nonatomic,strong) UITableView *tableView;
@end

static NSString *CellName = @"AutoHeightCell";

@implementation AutoCellHeightVC

- (void)viewDidLoad {

    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self.view addSubview:self.tableView];
    [self readData];
}

- (void)readData {

    NSString *path = [[NSBundle mainBundle] pathForResource:@"content" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    _dataArray = [NSJSONSerialization JSONObjectWithData:data
                                                     options:NSJSONReadingAllowFragments
                                                       error:nil];
    [_tableView reloadData];

}

- (UITableView *)tableView {
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height-88) style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        [_tableView registerClass:[AutoHeightCell class] forCellReuseIdentifier:CellName];
        _tableView.estimatedRowHeight = 40;//估算高度
        _tableView.rowHeight = UITableViewAutomaticDimension;
    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    AutoHeightCell *cell = [tableView dequeueReusableCellWithIdentifier:CellName forIndexPath:indexPath];
    NSDictionary *dict = _dataArray[indexPath.row];
    [cell setTitle:dict[@"color"] contentText:dict[@"content"]];
    return cell;
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
