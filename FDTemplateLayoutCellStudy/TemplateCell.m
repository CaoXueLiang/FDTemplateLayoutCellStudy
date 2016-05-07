//
//  TemplateCell.m
//  FDTemplateLayoutCellStudy
//
//  Created by 曹学亮 on 16/5/7.
//  Copyright © 2016年 xueliang cao. All rights reserved.
//

#import "TemplateCell.h"
#import <Masonry/Masonry.h>

@interface TemplateCell()

@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *contentLabel;
@property (nonatomic,strong) UIImageView *contentImageView;
@property (nonatomic,strong) UILabel *userNameLabel;
@property (nonatomic,strong) UILabel *timeLabel;
@end

@implementation TemplateCell

#pragma mark - init
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initViews];
    }
    return self;
}

#pragma mark - Private Menthod
- (void)initViews{
    // Fix the bug in iOS7 - initial constraints warning
    self.contentView.bounds = [UIScreen mainScreen].bounds;
    //标题
    _titleLabel = [UILabel new];
    _titleLabel.textColor = [UIColor blueColor];
    _titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [self.contentView addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(16);
        make.top.equalTo(self.contentView).offset(10);
        make.right.equalTo(self.contentView).offset(-10);
    }];
    
    //内容
    _contentLabel = [UILabel new];
    _contentLabel.textColor = [UIColor lightGrayColor];
    _contentLabel.font = [UIFont systemFontOfSize:14];
    _contentLabel.numberOfLines = 0;
    _contentLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _contentLabel.preferredMaxLayoutWidth = [UIScreen mainScreen].bounds.size.width - 26;
    [self.contentView addSubview:_contentLabel];
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleLabel.mas_left);
        make.right.equalTo(self.contentView).offset(-10);
        make.top.equalTo(_titleLabel.mas_bottom).offset(6);
    }];
    //[_contentLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [_contentLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
   
    //图片
    _contentImageView = [UIImageView new];
    _contentImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:_contentImageView];
    [_contentImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleLabel.mas_left);
        make.top.equalTo(_contentLabel.mas_bottom).offset(8);
        make.right.lessThanOrEqualTo(self.contentView).offset(-16);
    }];
    [_contentImageView setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [_contentImageView setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    
    //姓名
    _userNameLabel = [UILabel new];
    _userNameLabel.textColor = [UIColor lightGrayColor];
    _userNameLabel.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:_userNameLabel];
    [_userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_contentImageView.mas_bottom).offset(8);
        make.left.equalTo(_titleLabel.mas_left);
        make.bottom.equalTo(self.contentView).offset(-4);
    }];
    
    //时间
    _timeLabel = [UILabel new];
    _timeLabel.textColor = [UIColor greenColor];
    _timeLabel.font = [UIFont boldSystemFontOfSize:12];
    [self.contentView addSubview:_timeLabel];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-10);
        make.baseline.equalTo(_userNameLabel.mas_baseline);
    }];
   _titleLabel.mas_key = @"_titleLabel";
    _contentLabel.mas_key = @"_contentLabel";
    _contentImageView.mas_key = @"_contentImageView";
    _userNameLabel.mas_key = @"_userNameLabel";
    _timeLabel.mas_key = @"_timeLabel";
}

//如果不想用auto layout,覆盖这个方法，通过设置 "fd_enforceFrameLayout" to YES.
/*- (CGSize)sizeThatFits:(CGSize)size{
    CGFloat totalHeight = 0;
    totalHeight += [self.titleLabel sizeThatFits:size].height;
    totalHeight += [self.contentLabel sizeThatFits:size].height;
    totalHeight += [self.contentImageView sizeThatFits:size].height;
    totalHeight += [self.userNameLabel sizeThatFits:size].height;
    totalHeight += 40;//边缘距离 margins
    return CGSizeMake(size.width, totalHeight);
}*/

#pragma mark - setter menthod
- (void)setEntity:(TemplateEntity *)entity{
    _entity = entity;
    self.titleLabel.text = entity.title;
    self.contentLabel.text = entity.content;
    self.contentImageView.image = entity.imageName.length > 0 ? [UIImage imageNamed:entity.imageName] : nil;
    self.userNameLabel.text = entity.userName;
    self.timeLabel.text = entity.time;
}

@end
