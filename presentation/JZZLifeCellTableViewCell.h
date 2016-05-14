//
//  JZZConditionCellTableViewCell.h
//  ZJZWeather
//
//  Created by Jzzhou on 16/5/12.
//  Copyright © 2016年 Jzzhou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JZZLifeCellTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *catagoryImgeView;
@property (weak, nonatomic) IBOutlet UILabel *catagoryTitle;
@property (weak, nonatomic) IBOutlet UILabel *roughDescription;
@property (weak, nonatomic) IBOutlet UITextView *describeTextView;


@end
