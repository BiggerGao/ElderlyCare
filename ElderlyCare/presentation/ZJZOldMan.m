//
//  ZJZOldMan.m
//  ElderlyCare
//
//  Created by Jzzhou on 16/3/16.
//
//

#import "ZJZOldMan.h"

@implementation ZJZOldMan

#pragma mark - coping
- (id)copyWithZone:(nullable NSZone *)zone {
    ZJZOldMan *copy = [[[self class] allocWithZone:zone] init];
    copy.oldManID = [self.oldManID copyWithZone:zone];
    copy.keeperID = [self.keeperID copyWithZone:zone];
    copy.relationship = [self.relationship copyWithZone:zone];
    copy.name = [self.name copyWithZone:zone];
    copy.sex = [self.sex copyWithZone:zone];
    copy.age = [self.age copyWithZone:zone];
    copy.height = [self.height copyWithZone:zone];
    copy.weight = [self.weight copyWithZone:zone];
    copy.illness = [self.illness copyWithZone:zone];
    copy.deviceID = [self.deviceID copyWithZone:zone];
    
    return copy;
}

@end
