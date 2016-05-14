//
//  ZJZDaysInfoTableViewController.h
//  ElderlyCare
//
//  Created by Jzzhou on 16/3/10.
//
//

#import <UIKit/UIKit.h>
#import "ZJZOldMan.h"
@protocol ZJZDaysDelegate <NSObject>
- (void)transferAllDays:(NSArray*)daysList;
@end

@interface ZJZDaysInfoTableViewController : UITableViewController

@property (nonatomic, copy) ZJZOldMan *oldMan;
@property (nonatomic, strong) NSArray *dailyList;
@property (nonatomic, copy) NSArray *dateList;

@end
