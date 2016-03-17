//
//  ZJZOldManBL.h
//  ElderlyCare
//
//  Created by Jzzhou on 16/3/17.
//
//

#import <Foundation/Foundation.h>

@interface ZJZOldManBL : NSObject
// 获取老人运动信息
- (void)getOldManInfo:(NSString *)name at:(NSString *)date withChartType:(NSInteger)type;

// 获得老人运动总统计量
- (void)findAllInfo:(NSString *)username;

@end
