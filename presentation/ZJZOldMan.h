//
//  ZJZOldMan.h
//  ElderlyCare
//
//  Created by Jzzhou on 16/3/16.
//
//

#import <Foundation/Foundation.h>

@interface ZJZOldMan : NSObject <NSCopying>

/** 看护人ID */
@property (nonatomic, copy) NSString *keeperID;
/** 头像 */
@property (nonatomic, copy) NSString *avatarName;
/** 与看护人关系 */
@property (nonatomic, copy) NSString *relationship;
/** 姓名 */
@property (nonatomic, copy) NSString *name;
/** 性别 */
@property (nonatomic, copy) NSString *sex;
/** 年龄 */
@property (nonatomic, copy) NSString *age;
/** 身高 */
@property (nonatomic, copy) NSString *height;
/** 体重 */
@property (nonatomic, copy) NSString *weight;
/** 患病 */
@property (nonatomic, copy) NSString *illness;
/** 设备ID */
@property (nonatomic, copy) NSString *deviceID;
/** 亲属电话*/
@property (nonatomic, copy) NSString *emergencyTel;
/**
 *  city
 */
@property (nonatomic, copy) NSString *city;
/**
 *  备注
 */
@property (nonatomic, copy) NSString *remark;

@end
