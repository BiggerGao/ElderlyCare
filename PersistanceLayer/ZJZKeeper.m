//
//  ZJZUserAccount.m
//  ElderlyCare
//
//  Created by Jzzhou on 16/3/10.
//
//


#import "ZJZKeeper.h"
#define kTelKey @"tel"
#define kPasswordKey @"password"
#define kNicknameKey @"nickname"
#define kKeeperIDKey @"keeperID"
#define kPhotoPathKey @"photoPath"

@implementation ZJZKeeper

#pragma mark - coding
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_tel forKey:kTelKey];
    [aCoder encodeObject:_password forKey:kPasswordKey];
    [aCoder encodeObject:_nickname forKey:kNicknameKey];
    [aCoder encodeObject:_keeperID forKey:kKeeperIDKey];
    [aCoder encodeObject:_photoPath forKey:kPhotoPathKey];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        _tel = [aDecoder decodeObjectForKey:kTelKey];
        _password = [aDecoder decodeObjectForKey:kPasswordKey];
        _nickname = [aDecoder decodeObjectForKey:kNicknameKey];
        _keeperID = [aDecoder decodeObjectForKey:kKeeperIDKey];
        _photoPath = [aDecoder decodeObjectForKey:kPhotoPathKey];
    }
    
    return self;
}

#pragma mark - coping
- (id)copyWithZone:(nullable NSZone *)zone {
    ZJZKeeper *copy = [[[self class] allocWithZone:zone] init];
    copy.tel = [self.tel copyWithZone:zone];
    copy.password = [self.password copyWithZone:zone];
    copy.nickname = [self.nickname copyWithZone:zone];
    copy.keeperID = [self.keeperID copyWithZone:zone];copy.tel = [self.tel copyWithZone:zone];
    copy.photoPath = [self.photoPath copyWithZone:zone];

    return copy;
}

- (instancetype)initWithTel:(NSString *)tel password:(NSString *)password
{
    ZJZKeeper* keeper = [[ZJZKeeper alloc] init];
    keeper.tel = tel;
    keeper.password = password;
    return keeper;
}

- (NSString *)getKeeperPhoto
{
    return [NSString stringWithFormat:@"Keeper/%@/photo.png", _tel];
}

@end
