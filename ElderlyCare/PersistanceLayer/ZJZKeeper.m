//
//  ZJZUserAccount.m
//  ElderlyCare
//
//  Created by Jzzhou on 16/3/10.
//
//


#import "ZJZKeeper.h"
#define kAccountKey @"account"
#define kPasswordKey @"password"
#define kDeviceIDKey @"deviceID"

@implementation ZJZKeeper

#pragma mark - coding
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_account forKey:kAccountKey];
    [aCoder encodeObject:_password forKey:kPasswordKey];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        _account = [aDecoder decodeObjectForKey:kAccountKey];
        _password = [aDecoder decodeObjectForKey:kPasswordKey];
    }
    
    return self;
}

#pragma mark - coping
- (id)copyWithZone:(nullable NSZone *)zone {
    ZJZKeeper *copy = [[[self class] allocWithZone:zone] init];
    copy.account = [self.account copyWithZone:zone];
    copy.password = [self.password copyWithZone:zone];
    
    return copy;
}

- (instancetype)initWithAccount:(NSString *)account password:(NSString *)password
{
    ZJZKeeper* user = [[ZJZKeeper alloc] init];
    user.account = account;
    user.password = password;
    
    return user;
}

@end
