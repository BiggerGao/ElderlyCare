//
//  ZJZKeeperViewController.h
//  ElderlyCare
//
//  Created by Jzzhou on 16/3/20.
//
//

#import <UIKit/UIKit.h>
#import "ZJZCenterViewController.h"

@interface ZJZKeeperViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSString *titleStr;

@property (nonatomic, weak) id<ZJZCenterLoginDelegate> delegate;
@end
