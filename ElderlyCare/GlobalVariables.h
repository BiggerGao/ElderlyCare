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

@interface GlobalVariables : NSObject

+ (void)setCurrKeeper:(ZJZKeeper *)keeper;
+ (void)setCurrOldMan:(ZJZOldMan *)oldMan;
+ (ZJZKeeper *)currKeeper;
+ (ZJZOldMan *)currOldMan;

@end
