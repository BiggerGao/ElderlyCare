//
//  CenterViewController.h
//  CareElder
//
//  Created by Jzzhou on 16/3/3.
//
//

#import <UIKit/UIKit.h>
@class ZJZKeeper;
@class ZJZOldMan;

@protocol ZJZCenterLoginDelegate <NSObject>
- (void)transferKeeperInfo:(ZJZKeeper *)keeper;
- (void)logoutKeeper;
@end

@protocol ZJZCenterOldManDelegate <NSObject>
- (void)transOldManInfo:(NSArray *)oldManArray;
- (void)passPrimaryOldMan:(ZJZOldMan *)oldMan;
@end


@interface ZJZCenterViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) ZJZOldMan *primaryOldMan;
@property (nonatomic, strong) NSMutableArray *groups;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *withoutLogInButton;

@end
