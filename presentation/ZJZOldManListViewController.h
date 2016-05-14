//
//  ZJZOldManInfoViewController.h
//  ElderlyCare
//
//  Created by Jzzhou on 16/4/1.
//
//

#import <UIKit/UIKit.h>
#import "ZJZOldMan.h"
#import "ZJZCenterViewController.h"

@interface ZJZOldManListViewController : UITableViewController

@property (nonatomic, copy) ZJZOldMan *oldMan;
@property (nonatomic, weak) id<ZJZCenterOldManDelegate> delegate;

@end
