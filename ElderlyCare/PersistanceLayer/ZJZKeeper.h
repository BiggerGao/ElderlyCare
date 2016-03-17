//
//  ZJZUserAccount.h
//  ElderlyCare
//
//  Created by Jzzhou on 16/3/10.
//
//

#import <Foundation/Foundation.h>

@interface ZJZKeeper : NSObject <NSCoding, NSCopying>

/** 看护人ID */
//@property (nonatomic, copy) NSString *keeperID;
/** 账号 */
@property (nonatomic, copy) NSString *account;
/** 密码 */
@property (nonatomic, copy) NSString *password;
/** 昵称 */
//@property (nonatomic, copy) NSString *nickName;
/** 电话号码 */
//@property (nonatomic, copy) NSString *telphone;

- (instancetype)initWithAccount:(NSString *)account password:(NSString *)password;

@end
