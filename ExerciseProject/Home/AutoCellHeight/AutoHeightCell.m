//
//  AutoHeightCell.m
//  ExerciseProject
//
//  Created by 天空吸引我 on 2018/10/10.
//  Copyright © 2018年 天空吸引我. All rights reserved.
//

#import "AutoHeightCell.h"
#import <Masonry.h>
@interface AutoHeightCell ()

@property (nonatomic,weak) UILabel *titleLabel;
@property (nonatomic,weak) UILabel *contentLabel;

@end

@implementation AutoHeightCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createContentView];
    }
    return self;
}

- (void)createContentView {

    UILabel *titleLabel = [UILabel new];
    titleLabel.font = [UIFont systemFontOfSize:18];
    [self.contentView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(10);
        make.left.equalTo(self.contentView).offset(20);
    }];
    self.titleLabel = titleLabel;

    UILabel *contentLabel = [UILabel new];
    contentLabel.font = [UIFont systemFontOfSize:15];
    contentLabel.numberOfLines = 0;
    [self.contentView addSubview:contentLabel];
    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
        make.left.equalTo(self.contentView).offset(20);
        make.right.equalTo(self.contentView).offset(-20);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
    }];
    self.contentLabel = contentLabel;
}

- (void)setTitle:(NSString *)title contentText:(NSString *)contentText {
    _titleLabel.text = title;
    _contentLabel.text = contentText;
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
