//
//  ZJZUserInfoXMLParser.h
//  CareElder
//
//  Created by Jzzhou on 16/3/1.
//
//

#import "TBXML.h"

@interface ZJZUserInfoXMLParser : NSObject

@property (nonatomic, strong)NSMutableArray *listData;

// 解析一个小时数据
- (NSArray *)parseFromXMLFilePath:(NSString *)path withChartType:(NSInteger)type;

@end
