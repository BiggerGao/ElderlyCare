//
//  ZJZLoginViewController.h
//  ElderlyCare
//
//  Created by Jzzhou on 16/3/9.
//
//

#import <UIKit/UIKit.h>
#import "ZJZCenterViewController.h"

#define kFileName @"KeeperAccountCache"
#define kKeeperKey @"KeeperAccount"

@protocol ZJZLoginDelegate <NSObject>
- (void)foundKeeper:(ZJZKeeper *)inputKeeper;
- (void)keeperIsNotExist;
@end

@interface ZJZLoginViewController : UIViewController

@property (nonatomic, weak) id<ZJZCenterLoginDelegate> delegate;

@end
