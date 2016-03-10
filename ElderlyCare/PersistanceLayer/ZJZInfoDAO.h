//
//  MinstatusDAO.h
//  CareElder
//
//  Created by Jzzhou on 16/2/29.
//
//

#import <Foundation/Foundation.h>

// 主机名
#define HOST_NAME @"172.20.52.175:11125/Service1.asmx"
#define WALK_PARAM 0.8
#define RUN_PARAM 1.5

@interface ZJZInfoDAO : NSObject

+ (ZJZInfoDAO *)sharedManager;

// 解析数据数组
@property (nonatomic, copy) NSArray *listData;

// 根据需求获取老人每天运动的数据数组（比例）
- (void)findUserInfo:(NSString *)username at:(NSString *)date withChartType:(NSInteger)type;

// 获得老人运动总统计量
- (void)findAllSportStatistic:(NSString *)username;

// 获得用户数据源
- (NSString *)findUserFilePath:(NSString *)username at:(NSString *)date withChartType:(NSInteger)type;

// 获取所有用户(what the fuck in server)
- (void)findAllUsers;

@end
