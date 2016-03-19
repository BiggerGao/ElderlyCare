//
//  CenterViewController.h
//  CareElder
//
//  Created by Jzzhou on 16/3/3.
//
//

#import <UIKit/UIKit.h>
@class ZJZKeeper;

@protocol ZJZCenterDelegate <NSObject>
- (void)transferKeeperInfo:(ZJZKeeper *)keeper;
@end

@interface ZJZCenterViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end
