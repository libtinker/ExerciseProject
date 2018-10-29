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
#import "CTFrameParser.h"
#import "CTFrameParserConfig.h"

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

+ (UIImage *) image: (UIImage *) image fitInSize: (CGSize) viewsize
{
    // calculate the fitted size
    CGSize size = [self fitSize:image.size inSize:viewsize];

    UIGraphicsBeginImageContext(viewsize);

    float dwidth = (viewsize.width - size.width) / 2.0f;
    float dheight = (viewsize.height - size.height) / 2.0f;

    CGRect rect = CGRectMake(dwidth, dheight, size.width, size.height);
    [image drawInRect:rect];

    UIImage *newimg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return newimg;
}
+ (CGSize) fitSize: (CGSize)thisSize inSize: (CGSize) aSize
{
    CGFloat scale;
    CGSize newsize = thisSize;

    if (newsize.height && (newsize.height > aSize.height))
    {
        scale = aSize.height / newsize.height;
        newsize.width *= scale;
        newsize.height *= scale;
    }

    if (newsize.width && (newsize.width >= aSize.width))
    {
        scale = aSize.width / newsize.width;
        newsize.width *= scale;
        newsize.height *= scale;
    }

    return newsize;
}


- (void)setTitle:(NSString *)title contentText:(NSString *)contentText headimg:(NSString *)headimg imageArray:(NSArray *)imageArray{
    _nicknameLable.text = title;
    _headerImageView.image = [AutoHeightCell image:[UIImage imageNamed:headimg] fitInSize:CGSizeMake(45, 45)] ;



    CTFrameParserConfig *config = [[CTFrameParserConfig alloc] init];
    config.width = 300;
    config.textColor = [UIColor blackColor];

    NSDictionary *attr = [CTFrameParser attributesWithConfig:config];
    NSMutableAttributedString *attributedString =
    [[NSMutableAttributedString alloc] initWithString:contentText
                                           attributes:attr];

    // 设置行距等样式
    CoreTextData *data = [CTFrameParser parseAttributedContent:attributedString
                                                        config:config];
    _coreTextView.data = data;
    [_coreTextView setNeedsLayout];
    
}
/*
 - (void)setModel:(ContentModel *)model {
 _model = model;
 _nicknameLable.text = model.nickname;
 _headerImageView.image = [UIImage imageNamed:model.headimg];


 CTFrameParserConfig *config = [[CTFrameParserConfig alloc] init];
 NSDictionary *attr = [CTFrameParser attributesWithConfig:config];
 NSMutableAttributedString *attributedString =
 [[NSMutableAttributedString alloc] initWithString:model.describe
 attributes:attr];
 [attributedString addAttribute:(id)NSForegroundColorAttributeName
 value:(id)[UIColor redColor].CGColor
 range:NSMakeRange(0, 7)];



 CoreTextData *data = [CTFrameParser parseAttributedContent:attributedString config:config];


 _coreTextView.data = data;
 }
 */
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}





@end
