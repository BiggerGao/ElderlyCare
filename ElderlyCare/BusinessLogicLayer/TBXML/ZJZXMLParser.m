//
//  ZJZUserInfoXMLParser.m
//  CareElder
//
//  Created by Jzzhou on 16/3/1.
//
//

#import "ZJZXMLParser.h"
#import "ZJZHourInfo.h"
#import "ZJZDailyInfo.h"
#import "ZJZUserInfo.h"

@implementation ZJZXMLParser

#pragma mark - 根据字符串类型解析
// 用户信息
- (NSArray *)parseUserInfo:(NSString*)XMLstring
{
    NSMutableArray *resArray = [NSMutableArray array];
    TBXML *tbxml = [[TBXML alloc] initWithXMLString:XMLstring error:nil];
    TBXMLElement *root = tbxml.rootXMLElement;
    if (root) {
        TBXMLElement *nodeElement = [TBXML childElementNamed:@"user" parentElement:root];
        while (nodeElement) {
            ZJZUserInfo *userInfo = [ZJZUserInfo new];
            
            userInfo.account = [self parseKey:@"name" parentElement:nodeElement];
            userInfo.password = [self parseKey:@"pwd" parentElement:nodeElement];
            userInfo.deviceID = [self parseKey:@"deviceID" parentElement:nodeElement];
            
            [resArray addObject:userInfo];
            nodeElement = [TBXML nextSiblingNamed:@"user" searchFromElement:nodeElement];
        }
    }
    return resArray;
}
// 柱形图折线图数据
- (NSArray *)parseChartType1String:(NSString*)XMLstring
{
    NSMutableArray *resArray = [NSMutableArray array];
    TBXML *tbxml = [[TBXML alloc] initWithXMLString:XMLstring error:nil];
    TBXMLElement *root = tbxml.rootXMLElement;
    if(root){
        TBXMLElement *nodeElement = [TBXML childElementNamed:@"HourInfo" parentElement:root];
        while (nodeElement) {
            ZJZHourInfo *hourInfo = [[ZJZHourInfo alloc] init];
            
            hourInfo.date = [self parseKey:@"Date" parentElement:nodeElement];
            hourInfo.sport = [self parseKey:@"sport" parentElement:nodeElement];
            hourInfo.rest = [self parseKey:@"rest" parentElement:nodeElement];
            hourInfo.deviceID = [self parseKey:@"deviceID" parentElement:nodeElement];
            
            [resArray addObject:hourInfo];
            nodeElement = [TBXML nextSiblingNamed:@"HourInfo" searchFromElement:nodeElement];
        }
    }
    return resArray;
}
// 扇形图数据
- (NSArray *)parseChartType2String:(NSString*)XMLstring
{
    NSMutableArray *resArray = [NSMutableArray array];
    TBXML *tbxml = [[TBXML alloc] initWithXMLString:XMLstring error:nil];
    TBXMLElement *root = tbxml.rootXMLElement;
    if (root) {
        TBXMLElement *nodeElement = [TBXML childElementNamed:@"Node" parentElement:root];
        while (nodeElement) {
            ZJZDailyInfo *dailyInfo = [[ZJZDailyInfo alloc] init];
            
            dailyInfo.date = [self parseKey:@"Date" parentElement:nodeElement];
            dailyInfo.walk = [self parseKey:@"walk" parentElement:nodeElement];
            dailyInfo.run = [self parseKey:@"run" parentElement:nodeElement];
            dailyInfo.rest = [self parseKey:@"rest" parentElement:nodeElement];
            dailyInfo.sleep = [self parseKey:@"sleep" parentElement:nodeElement];
            dailyInfo.deviceID = [self parseKey:@"deviceID" parentElement:nodeElement];
            
            [resArray addObject:dailyInfo];
            nodeElement = [TBXML nextSiblingNamed:@"Node" searchFromElement:nodeElement];
        }
    }
    return resArray;
}
#pragma mark - 解析XML文件
- (NSArray *)parseFromXMLFilePath:(NSString *)path withChartType:(NSInteger)type
{
    NSString *xmlString = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    if(type == 1)
    {
        _listData = [self parseChartType1String:xmlString];
    }
    else if(type == 2)
    {
        _listData = [self parseChartType2String:xmlString];
    }
    else
    {
        NSAssert(YES, @"MinStatusTBXMLParser.m parseFromXMLFile2Path: wrong type!");
    }
    return _listData;
}

#pragma mark - 解析XML中单个Key
- (NSString *)parseKey:(NSString *)key parentElement:(TBXMLElement *)parentElement
{
    TBXMLElement *element = [TBXML childElementNamed:key parentElement:parentElement];
    if (element != nil) {
        NSString *value = [TBXML textForElement:element];
        return value;
    }
    return nil;
}
@end
