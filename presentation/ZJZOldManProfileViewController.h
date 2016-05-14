//
//  ZJZOldManProfileViewController.h
//  ElderlyCare
//
//  Created by Jzzhou on 16/5/1.
//  Copyright © 2016年 Jzzhou. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZJZOldMan;

@interface ZJZOldManProfileViewController : UIViewController <UIActionSheetDelegate, UITextViewDelegate>

- (instancetype)initWithTitle:(NSString*)title oldMan:(ZJZOldMan*)oldMan;

@end
