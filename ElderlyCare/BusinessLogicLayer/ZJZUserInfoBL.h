//
//  ZJZUserInfoBL.h
//  CareElder
//
//  Created by Jzzhou on 16/2/29.
//
//

#import <Foundation/Foundation.h>

@interface ZJZUserInfoBL : NSObject

// 获取用户运动信息
- (void)getUserInfo:(NSString *)userName at:(NSString *)date withChartType:(NSInteger)type;

// 获取所有用户(what the fuck in server)
- (void)findAllUsers;

// 获得老人运动总统计量
- (void)findAllInfo:(NSString *)username;

@end
