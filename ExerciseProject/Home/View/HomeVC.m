//
//  HomeVC.m
//  ExerciseProject
//
//  Created by 天空吸引我 on 2018/8/25.
//  Copyright © 2018年 天空吸引我. All rights reserved.
//

#import "HomeVC.h"
#import "HomeViewModel.h"
#import "HomeModel.h"

@interface HomeVC ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *_dataArray;
}
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) HomeViewModel *homeViewModel;
@end
static NSString *CellName = @"HomeCell";

@implementation HomeVC


+ (void)initialize {
    NSLog(@"子类的initialize");
}

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArray = [self.homeViewModel getDataArray];
    [self.view addSubview:self.tableView];
}
- (void)viewWillAppear:(BOOL)animated {
    NSLog(@"homeVC_viewWillAppear");
}
- (void)viewDidAppear:(BOOL)animated {
    NSLog(@"homeVC_viewDidAppear");

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - getter
- (UITableView *)tableView {
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellName];
        if(@available(iOS 11.0,*)){
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _tableView;
}
- (HomeViewModel *)homeViewModel {
    if (!_homeViewModel) {
        _homeViewModel = [[HomeViewModel alloc] init];
    }
    return _homeViewModel;
}

#pragma mark - TableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellName forIndexPath:indexPath];
    HomeModel *model = _dataArray[indexPath.row];
    cell.textLabel.text = model.title;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeModel *model = _dataArray[indexPath.row];
    NSString *vcName = model.vcName;
    Class vcClass = NSClassFromString(vcName);
    [self.navigationController pushViewController:[[vcClass alloc] init] animated:YES];
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
