//
//  AutoHeightCell.m
//  ExerciseProject
//
//  Created by 天空吸引我 on 2018/10/10.
//  Copyright © 2018年 天空吸引我. All rights reserved.
//

#import "AutoHeightCell.h"
#import "AutoCellCoreTextView.h"
#import <Masonry.h>

@interface AutoHeightCell ()

@property (nonatomic,weak) UILabel *nicknameLable;
@property (nonatomic,weak) AutoCellCoreTextView *coreTextView;
@property (nonatomic,weak) UIImageView *headerImageView;
@property (nonatomic,weak) UIView *lineView;

@end

@implementation AutoHeightCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self createContentView];
    }
    return self;
}

- (void)createContentView {

    UIImageView *headerImageView = [UIImageView new];
    headerImageView.image = [UIImage imageNamed:@"zjj_photo"];
    [self.contentView addSubview:headerImageView];
    self.headerImageView = headerImageView;
    [headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15);
        make.top.equalTo(self.contentView).offset(10);
        make.size.mas_offset(CGSizeMake(45, 45));
    }];

    UILabel *nicknameLable = [UILabel new];
    nicknameLable.font = [UIFont boldSystemFontOfSize:14];
    nicknameLable.textColor = [UIColor colorWithRed:104/255.0 green:114/255.0 blue:148/255.0 alpha:1.0];
    [self.contentView addSubview:nicknameLable];
    [nicknameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headerImageView.mas_top);
        make.left.equalTo(self.headerImageView.mas_right).offset(5);
    }];
    self.nicknameLable = nicknameLable;

    UIView *lineView = [UIView new];
    lineView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.contentView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-0.5);
        make.left.right.equalTo(self.contentView);
        make.height.mas_offset(@.5);
    }];
    self.lineView = lineView;

    AutoCellCoreTextView *coreTextView = [AutoCellCoreTextView new];
    [self.contentView addSubview:coreTextView];
    [coreTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nicknameLable.mas_bottom).offset(10);
        make.left.equalTo(self.nicknameLable);
        make.right.equalTo(self.contentView).offset(-20);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
        
    }];
    self.coreTextView = coreTextView;
}

- (void)setTitle:(NSString *)title contentText:(NSString *)contentText headimg:(NSString *)headimg imageArray:(NSArray *)imageArray{
    _nicknameLable.text = title;
    _headerImageView.image = [UIImage imageNamed:headimg];
    [_coreTextView setDiscribText:contentText imageArray:imageArray];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}





@end
