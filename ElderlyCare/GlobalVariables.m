//
//  GlobalVariables.m
//  ElderlyCare
//
//  Created by Jzzhou on 16/3/15.
//
//

#import "GlobalVariables.h"

@implementation GlobalVariables

static ZJZKeeper *currKeeper = nil;
static ZJZOldMan *currOldMan = nil;

+ (void)setCurrKeeper:(ZJZKeeper *)keeper {
    currKeeper = [keeper copy];
}

+ (void)setCurrOldMan:(ZJZOldMan *)oldMan {
    currOldMan = [oldMan copy];
}

+ (ZJZKeeper *)currKeeper {
    return currKeeper;
}

+ (ZJZOldMan *)currOldMan {
    return currOldMan;
}
@end
