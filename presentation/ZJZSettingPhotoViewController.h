//
//  ZJZSettingPhotoViewController.h
//  ElderlyCare
//
//  Created by Jzzhou on 16/3/23.
//
//

#import <UIKit/UIKit.h>
#import "ZJZKeeper.h"
@protocol ZJZCompleteRegisterDelegate <NSObject>
- (void)keeperAlreadyExist;
- (void)completeRegister;
@end

@interface ZJZSettingPhotoViewController : UIViewController

@property (nonatomic, strong) ZJZKeeper *registerKeeper;

@end