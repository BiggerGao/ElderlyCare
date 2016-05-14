//
//  ZJZOldManCell.h
//  ElderlyCare
//
//  Created by Jzzhou on 16/3/30.
//
//

#import <UIKit/UIKit.h>
#import "ZJZOldMan.h"

@interface ZJZOldManCell : UITableViewCell

@property (nonatomic, copy) ZJZOldMan *oldMan;
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end
