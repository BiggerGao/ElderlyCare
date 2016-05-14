//
//  GlobalVariables.m
//  ElderlyCare
//
//  Created by Jzzhou on 16/3/15.
//
//

#import "GlobalVariablesManager.h"

@implementation GlobalVariablesManager

static GlobalVariablesManager* sharedManager = nil;

+ (GlobalVariablesManager *)sharedManager {
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedManager = [[self alloc] init];
    });
    return sharedManager;
}

@end
