//
//  ZJZUserAccount.h
//  ElderlyCare
//
//  Created by Jzzhou on 16/3/10.
//
//

#import <Foundation/Foundation.h>

@interface ZJZKeeper : NSObject <NSCoding, NSCopying>

// 请求参数

/** 电话号码 */
@property (nonatomic, copy) NSString *tel;
/** 密码 */
@property (nonatomic, copy) NSString *password;
/** 昵称 */
@property (nonatomic, copy) NSString *nickname;
/** 头像 */
@property (nonatomic, copy) NSString *photoPath;

// 返回值
/** 看护人ID */
@property (nonatomic, copy) NSString *keeperID;

- (instancetype)initWithTel:(NSString *)tel password:(NSString *)password;
- (NSString *)getKeeperPhoto;
@end
