//
//  RunLoopVC.m
//  ExerciseProject
//
//  Created by 天空吸引我 on 2018/9/3.
//  Copyright © 2018年 天空吸引我. All rights reserved.
//

#import "RunLoopVC.h"
#import <UIImageView+WebCache.h>
#import <Masonry.h>


@interface RunLoopCell : UITableViewCell
@property (nonatomic,strong) UIImageView *contentImageView;
@end
@implementation RunLoopCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createContentView];
    }
    return self;
}
- (void)createContentView {
    _contentImageView = [UIImageView new];
    [self addSubview:_contentImageView];
    [_contentImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.centerX.equalTo(self);
    }];
}
- (void)clear{
    _contentImageView.image = nil;
}

@end

@interface RunLoopVC ()<UITableViewDataSource,UITableViewDelegate>
{
    NSArray *dataArray;
    NSMutableArray *needLoadArr;
}
@property (nonatomic,strong) UITableView *tableView;
@end
static NSString *CellName = @"RunLoopCell";

@implementation RunLoopVC

- (void)viewDidLoad {
    [super viewDidLoad];
    needLoadArr = [[NSMutableArray alloc] init];
    dataArray = @[@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1535975490089&di=0c6b8a30fcd6fc79128f1f8e250f289e&imgtype=0&src=http%3A%2F%2Fimg1.hao76.com%2Fupload%2Fimages%2F2015%2F11%2F05%2F1446714593115905.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1535975490089&di=8855756de0e4b5c31e57b13807cd2ede&imgtype=0&src=http%3A%2F%2Fc2.hoopchina.com.cn%2Fuploads%2Fstar%2Fevent%2Fimages%2F141024%2F862e3aedd3f6db92af7dfc07221f4e7dafa80eeb.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1535975490089&di=3fd7ee49a273b7d6e9f7a86d405214a4&imgtype=0&src=http%3A%2F%2Fpic1.win4000.com%2Fpic%2Fd%2F0b%2F0b9b1134526.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1535975490089&di=bbf1a3616c2f7a53b919ee1378eaffab&imgtype=0&src=http%3A%2F%2Flife.southmoney.com%2Ftitan%2FUploadFiles_8524%2F201708%2F20170804160659307.jpeg%3FimageView%26thumbnail%3D550x0",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1535975490088&di=7541b6e3a4b8ec4b53080ec62f582362&imgtype=0&src=http%3A%2F%2Fwww.310win.com%2Ffiles%2F2014%2F6%2F20140618081223370.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1535975583066&di=9c5d3fe77126b6a1a5f478df65310fed&imgtype=jpg&src=http%3A%2F%2Fimg4.imgtn.bdimg.com%2Fit%2Fu%3D2695636894%2C1585344577%26fm%3D214%26gp%3D0.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1535975490087&di=9b4f9cda18f399b63955382f8e80ae3c&imgtype=0&src=http%3A%2F%2Fimg5.duitang.com%2Fuploads%2Fitem%2F201407%2F18%2F20140718162424_xLnKH.thumb.700_0.jpeg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1535975490087&di=e809c53b8870df848fc280c1bc78a77e&imgtype=0&src=http%3A%2F%2Fa4.att.hudong.com%2F25%2F95%2F01300540556556139438958077166.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1535975490087&di=cad19d9eecd9383c26fda4b5f52731fb&imgtype=0&src=http%3A%2F%2F06.imgmini.eastday.com%2Fmobile%2F20180416%2F20180416163846_6e23b0540958eb039b1c170eb57d932f_3.jpeg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1535975490087&di=c95e3af1a3b093285738f8ca40e139b4&imgtype=0&src=http%3A%2F%2Fimg5q.duitang.com%2Fuploads%2Fitem%2F201406%2F14%2F20140614152019_QsdUZ.thumb.700_0.jpeg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1535975490087&di=b6d881f0d4ab53815acf6c298e876d21&imgtype=0&src=http%3A%2F%2Fsportspic.oss-cn-shanghai.aliyuncs.com%2F152506104449081-2.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1535975490089&di=0c6b8a30fcd6fc79128f1f8e250f289e&imgtype=0&src=http%3A%2F%2Fimg1.hao76.com%2Fupload%2Fimages%2F2015%2F11%2F05%2F1446714593115905.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1535975490089&di=8855756de0e4b5c31e57b13807cd2ede&imgtype=0&src=http%3A%2F%2Fc2.hoopchina.com.cn%2Fuploads%2Fstar%2Fevent%2Fimages%2F141024%2F862e3aedd3f6db92af7dfc07221f4e7dafa80eeb.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1535975490089&di=3fd7ee49a273b7d6e9f7a86d405214a4&imgtype=0&src=http%3A%2F%2Fpic1.win4000.com%2Fpic%2Fd%2F0b%2F0b9b1134526.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1535975490089&di=bbf1a3616c2f7a53b919ee1378eaffab&imgtype=0&src=http%3A%2F%2Flife.southmoney.com%2Ftitan%2FUploadFiles_8524%2F201708%2F20170804160659307.jpeg%3FimageView%26thumbnail%3D550x0",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1535975490088&di=7541b6e3a4b8ec4b53080ec62f582362&imgtype=0&src=http%3A%2F%2Fwww.310win.com%2Ffiles%2F2014%2F6%2F20140618081223370.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1535975583066&di=9c5d3fe77126b6a1a5f478df65310fed&imgtype=jpg&src=http%3A%2F%2Fimg4.imgtn.bdimg.com%2Fit%2Fu%3D2695636894%2C1585344577%26fm%3D214%26gp%3D0.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1535975490087&di=9b4f9cda18f399b63955382f8e80ae3c&imgtype=0&src=http%3A%2F%2Fimg5.duitang.com%2Fuploads%2Fitem%2F201407%2F18%2F20140718162424_xLnKH.thumb.700_0.jpeg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1535975490087&di=e809c53b8870df848fc280c1bc78a77e&imgtype=0&src=http%3A%2F%2Fa4.att.hudong.com%2F25%2F95%2F01300540556556139438958077166.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1535975490087&di=cad19d9eecd9383c26fda4b5f52731fb&imgtype=0&src=http%3A%2F%2F06.imgmini.eastday.com%2Fmobile%2F20180416%2F20180416163846_6e23b0540958eb039b1c170eb57d932f_3.jpeg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1535975490087&di=c95e3af1a3b093285738f8ca40e139b4&imgtype=0&src=http%3A%2F%2Fimg5q.duitang.com%2Fuploads%2Fitem%2F201406%2F14%2F20140614152019_QsdUZ.thumb.700_0.jpeg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1535975490087&di=b6d881f0d4ab53815acf6c298e876d21&imgtype=0&src=http%3A%2F%2Fsportspic.oss-cn-shanghai.aliyuncs.com%2F152506104449081-2.jpg"];
    [self.view addSubview:self.tableView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RunLoopCell *cell = [tableView dequeueReusableCellWithIdentifier:CellName forIndexPath:indexPath];
    if (needLoadArr.count>0&&[needLoadArr indexOfObject:indexPath]==NSNotFound) {
        [cell clear];
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    RunLoopCell *Zcell = (RunLoopCell *)cell;
    [Zcell.contentImageView sd_setImageWithURL:[NSURL URLWithString:dataArray[indexPath.row]]];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 200;
}
//按需加载 - 如果目标行与当前行相差超过指定行数，只在目标滚动范围的前后指定3行加载。
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    NSIndexPath *ip = [_tableView indexPathForRowAtPoint:CGPointMake(0, targetContentOffset->y)];
    NSIndexPath *cip = [[_tableView indexPathsForVisibleRows] firstObject];
    NSInteger skipCount = 2;
    if (labs(cip.row-ip.row)>skipCount) {
        NSArray *temp = [_tableView indexPathsForRowsInRect:CGRectMake(0, targetContentOffset->y, _tableView.bounds.size.width, _tableView.bounds.size.height)];
        NSMutableArray *arr = [NSMutableArray arrayWithArray:temp];
        if (velocity.y<0) {
            NSIndexPath *indexPath = [temp lastObject];
            if (indexPath.row+33) {
                [arr addObject:[NSIndexPath indexPathForRow:indexPath.row-3 inSection:0]];
                [arr addObject:[NSIndexPath indexPathForRow:indexPath.row-2 inSection:0]];
                [arr addObject:[NSIndexPath indexPathForRow:indexPath.row-1 inSection:0]];
            }
        }
        [needLoadArr addObjectsFromArray:arr];
    }
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [needLoadArr removeAllObjects];
}

- (UITableView *)tableView {
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        [_tableView registerClass:[RunLoopCell class] forCellReuseIdentifier:CellName];
        _tableView.frame = self.view.frame;
    }
    return _tableView;
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



