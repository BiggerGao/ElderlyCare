//
//  MinStatusTBXMLParser.h
//  CareElder
//
//  Created by Jzzhou on 16/3/1.
//
//

#import "TBXML.h"

@interface MinStatusTBXMLParser : NSObject

@property (strong, nonatomic)NSMutableArray *listData;

// 解析2.5Min数据
- (NSArray *)parseFromXMLFile1Path:(NSString *)path;
// 解析一个小时数据
- (NSArray *)parseFromXMLFile2Path:(NSString *)path withChartType:(NSInteger)type;
@end
