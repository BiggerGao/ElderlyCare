//
//  ZJZLoginViewController.h
//  ElderlyCare
//
//  Created by Jzzhou on 16/3/9.
//
//

#import <UIKit/UIKit.h>
#import "ZJZCenterViewController.h"

#define kFileName @"Keeper"
#define kKeeperKey @"KeeperAccount"

@protocol ZJZLoginDelegate <NSObject>


@end

@interface ZJZLoginViewController : UIViewController

@property (nonatomic, weak) id<ZJZCenterDelegate> delegate;

@end
