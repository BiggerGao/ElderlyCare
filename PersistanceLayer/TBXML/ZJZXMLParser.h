//
//  ZJZUserInfoXMLParser.h
//  CareElder
//
//  Created by Jzzhou on 16/3/1.
//
//

#import "TBXML.h"

@interface ZJZXMLParser : NSObject

@property (nonatomic, strong)NSArray *listData;


// 从文件获得一个小时运动数据并解析
- (NSArray *)parseFromXMLFilePath:(NSString *)path withChartType:(NSInteger)type;
// 解析账号数据
- (NSArray *)parseKeeperInfo:(NSString*)XMLstring;
- (NSArray *)parseOldManInfo:(NSString*)XMLstring;

- (NSArray *)parseChartType1String:(NSString*)XMLstring;
- (NSArray *)parseChartType2String:(NSString*)XMLstring;
@end
