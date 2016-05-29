//
//  JZZTableViewCell.m
//  ElderlyCare
//
//  Created by Jzzhou on 16/5/28.
//  Copyright © 2016 Jzzhou. All rights reserved.
//

#import "JZZTemplateTableViewCell.h"
#import "JZZTemplateTableViewDataEntity.h"

@interface JZZTemplateTableViewCell ()
@property (nonatomic, strong) UIImageView *avatarImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;

@property (nonatomic, weak) JZZTemplateTableViewDataEntity *dataEntity;
@end

@implementation JZZTemplateTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.userInteractionEnabled = NO;
        [self initView];
    }
    return self;
}

#pragma mark - public methods

- (void)setupData:(JZZTemplateTableViewDataEntity *)dataEntity {
    _dataEntity = dataEntity;
    
    _avatarImageView.image = dataEntity.avatar;
    _titleLabel.text = dataEntity.title;
    _contentLabel.text = dataEntity.content;
}

#pragma mark - private methods

- (void)initView {
    self.tag = 1000;
    
//    _avatarImageView = [[UIImageView alloc] init];
//    [self.contentView addSubview:_avatarImageView];
//    [_avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.width.and.height.equalTo(@44);
//        make.left.and.top.equalTo(self.contentView).width.offset(4);
//    }];
    
    // Title - 单行
    _titleLabel = [UILabel new];
    [self.contentView addSubview:_titleLabel];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@22);
        make.top.equalTo(self.contentView).with.offset(4);
        make.left.equalTo(self.contentView.mas_left).with.offset(4);
        make.right.equalTo(self.contentView).with.offset(-4);
    }];
    
    
    // 计算UILabel的preferredMaxLayoutWidth值，多行时必须设置这个值，否则系统无法决定Label的宽度
    CGFloat preferredMaxWidth = [UIScreen mainScreen].bounds.size.width - 4 * 2;
    
    // Content - 多行
    _contentLabel = [UILabel new];
    _contentLabel.numberOfLines = 0;
    _contentLabel.preferredMaxLayoutWidth = preferredMaxWidth;
    [self.contentView addSubview:_contentLabel];
    
    
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLabel.mas_bottom).with.offset(4);
        make.left.equalTo(self.contentView.mas_left).with.offset(4);
        make.right.equalTo(self.contentView.mas_right).with.offset(-4); // mark - modified
        make.bottom.equalTo(self.contentView.mas_bottom).with.offset(-4);
    }];
    
    [_contentLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
}

@end
