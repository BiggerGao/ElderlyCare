//
//  JZZConditionCellTableViewCell.m
//  ZJZWeather
//
//  Created by Jzzhou on 16/5/12.
//  Copyright © 2016年 Jzzhou. All rights reserved.
//

#import "JZZLifeCellTableViewCell.h"

@implementation JZZLifeCellTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
    
    self.describeTextView.textColor = [UIColor whiteColor];
    _catagoryImgeView.image = nil;
    _catagoryTitle.text = @"无建议";
    _roughDescription.text = @"";
    _describeTextView.text = @"";
}
//
//- (void)layoutSubviews {
//    
//}
//
//- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
//{
//    
//}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
