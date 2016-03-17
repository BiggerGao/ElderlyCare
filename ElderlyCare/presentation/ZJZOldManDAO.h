//
//  ZJZOldManDAO.h
//  ElderlyCare
//
//  Created by Jzzhou on 16/3/17.
//
//

#import <Foundation/Foundation.h>

// 主机名
#define HOST_NAME @"172.20.52.175:11125/Service1.asmx"
#define WALK_PARAM 0.8
#define RUN_PARAM 1.5

@interface ZJZOldManDAO : NSObject

+ (ZJZOldManDAO *)sharedManager;
// 解析数据数组
@property (nonatomic, copy) NSArray *listData;

// 根据需求获取老人每天运动的数据数组（比例）
- (void)findOldManInfo:(NSString *)username at:(NSString *)date withChartType:(NSInteger)type;

// 获得老人运动总统计量
- (void)findAllSportStatistic:(NSString *)username;

// 获得老人数据源
- (NSString *)findOldManFilePath:(NSString *)username at:(NSString *)date withChartType:(NSInteger)type;

@end
