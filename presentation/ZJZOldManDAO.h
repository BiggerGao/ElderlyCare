//
//  ZJZOldManDAO.h
//  ElderlyCare
//
//  Created by Jzzhou on 16/3/17.
//
//

#import <Foundation/Foundation.h>
#import "ZJZKeeper.h"
#import "ZJZCenterViewController.h"
#import "ZJZDaysInfoTableViewController.h"

// 主机名
#define HOST_NAME @"139.129.38.72/Service1.asmx"
#define WALK_PARAM 0.8
#define RUN_PARAM 1.5

@interface ZJZOldManDAO : NSObject

+ (ZJZOldManDAO *)sharedManager;
// 解析数据数组
@property (nonatomic, copy) NSArray *listData;
@property (nonatomic, weak) id<ZJZCenterOldManDelegate> oldManCenterDelegate;
@property (nonatomic, weak) id<ZJZDaysDelegate> oldManDaysDelegate;

// 获得老人列表
- (void)findOldManList:(ZJZKeeper *)keeper;

// 根据需求获取老人每天运动的数据数组（比例）
- (void)findOldManInfo:(NSString *)username at:(NSString *)date withChartType:(NSInteger)type;

// 获得老人运动总统计量
- (void)findAllSportStatistic:(NSString *)deviceID;

// 获得老人数据源
- (NSString *)findOldManFilePath:(NSString *)username at:(NSString *)date withChartType:(NSInteger)type;

@end
