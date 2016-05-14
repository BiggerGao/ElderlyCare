//
//  GlobalVariables.h
//  ElderlyCare
//
//  Created by Jzzhou on 16/3/15.
//
//

#import <Foundation/Foundation.h>
#import "ZJZKeeper.h"
#import "ZJZOldMan.h"

#ifndef SCREEN_WIDTH
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#endif

#ifndef SCREEN_HEIGHT
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#endif

@interface GlobalVariablesManager : NSObject

+ (GlobalVariablesManager *)sharedManager;

@property (nonatomic, copy) ZJZKeeper *currKeeper;
@property (nonatomic, strong) ZJZKeeper *registerKeeper;
@property (nonatomic, copy) ZJZOldMan *currOldMan;

@end
