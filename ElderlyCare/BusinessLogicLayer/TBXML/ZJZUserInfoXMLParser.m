//
//  ZJZUserInfoXMLParser.m
//  CareElder
//
//  Created by Jzzhou on 16/3/1.
//
//

#import "ZJZUserInfoXMLParser.h"
#import "ZJZHourInfo.h"
#import "ZJZDailyInfo.h"

@implementation ZJZUserInfoXMLParser

#pragma mark - 解析XML文件
- (NSArray *)parseFromXMLFilePath:(NSString *)path withChartType:(NSInteger)type
{
    _listData = [NSMutableArray new];
    
    NSString *xmlString = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    TBXML *tbxml = [[TBXML alloc] initWithXMLString:xmlString error:nil];
    TBXMLElement * root = tbxml.rootXMLElement;
    if(type == 1)
    {
        if(root){
            TBXMLElement *nodeElement = [TBXML childElementNamed:@"HourInfo" parentElement:root];
            while (nodeElement != nil) {
                ZJZHourInfo *hourInfo = [[ZJZHourInfo alloc] init];
                
                hourInfo.date = [self parseKey:@"Date" parentElement:nodeElement];
                hourInfo.sport = [self parseKey:@"sport" parentElement:nodeElement];
                hourInfo.rest = [self parseKey:@"rest" parentElement:nodeElement];
                hourInfo.deviceID = [self parseKey:@"deviceID" parentElement:nodeElement];
                
                [_listData addObject:hourInfo];
                nodeElement = [TBXML nextSiblingNamed:@"HourInfo" searchFromElement:nodeElement];
            }
        }
    }
    else if(type == 2)
    {
        if (root) {
            TBXMLElement *nodeElement = [TBXML childElementNamed:@"Node" parentElement:root];
            while (nodeElement != nil) {
                ZJZDailyInfo *dailyInfo = [[ZJZDailyInfo alloc] init];

                dailyInfo.date = [self parseKey:@"Date" parentElement:nodeElement];
                dailyInfo.walk = [self parseKey:@"walk" parentElement:nodeElement];
                dailyInfo.run = [self parseKey:@"run" parentElement:nodeElement];
                dailyInfo.rest = [self parseKey:@"rest" parentElement:nodeElement];
                dailyInfo.sleep = [self parseKey:@"sleep" parentElement:nodeElement];
                dailyInfo.deviceID = [self parseKey:@"deviceID" parentElement:nodeElement];
                
                [_listData addObject:dailyInfo];
                nodeElement = [TBXML nextSiblingNamed:@"Node" searchFromElement:nodeElement];
            }
        }
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
