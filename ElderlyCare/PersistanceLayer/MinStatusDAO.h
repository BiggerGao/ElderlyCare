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

@interface MinStatusDAO : NSObject

+ (MinStatusDAO *)sharedManager;

// 解析数据
@property (strong, nonatomic) NSMutableArray *listData;

// 分析所得数据
@property (strong, nonatomic) NSMutableArray *dataOfOneHour;

// 获取每2分半运动状态
- (void) getAll2Point5MinsData:(NSString *)userName at:(NSString *)date withChartType:(NSInteger)type;

// 获取每小时数据的运动量（比例）
- (void) getOneHourData: (NSString *)username at:(NSString *)date withChartType:(NSInteger)type;

// 获得对应文件路径
- (NSString *)getUserWritableFilePath:(NSString *)username at:(NSString *)date withChartType:(NSInteger)type;

// 数据提取
- (void)AnalysisListData:(NSArray *)listData;
@end
