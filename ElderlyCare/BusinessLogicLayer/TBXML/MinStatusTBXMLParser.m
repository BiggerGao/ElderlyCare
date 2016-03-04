//
//  MinStatusTBXMLParser.m
//  CareElder
//
//  Created by Jzzhou on 16/3/1.
//
//

#import "MinStatusTBXMLParser.h"

@implementation MinStatusTBXMLParser

- (NSArray *)parseFromXMLFile1Path:(NSString *)path
{
    _listData = [NSMutableArray new];

    NSString *xmlString = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    TBXML *tbxml = [[TBXML alloc] initWithXMLString:xmlString error:nil];
    
    TBXMLElement * root = tbxml.rootXMLElement;
    if(root){
        TBXMLElement *nodeElement = [TBXML childElementNamed:@"Minstatus" parentElement:root];
        
        while (nodeElement != nil) {
            NSMutableDictionary *dict = [NSMutableDictionary new];
            
            [self parseKeyInDict:dict key:@"type" parentElement:nodeElement];
            [self parseKeyInDict:dict key:@"start" parentElement:nodeElement];
            [self parseKeyInDict:dict key:@"end" parentElement:nodeElement];
            [self parseKeyInDict:dict key:@"deviceID" parentElement:nodeElement];
            
            [_listData addObject:dict];
            nodeElement = [TBXML nextSiblingNamed:@"Minstatus" searchFromElement:nodeElement];
        }
    }
    return _listData;
}

#pragma mark - 解析1个小时的XML文件
- (NSArray *)parseFromXMLFile2Path:(NSString *)path withChartType:(NSInteger)type
{
    _listData = [NSMutableArray new];
    
    NSString *xmlString = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    TBXML *tbxml = [[TBXML alloc] initWithXMLString:xmlString error:nil];
    
    if(type == 1)
    {
        TBXMLElement * root = tbxml.rootXMLElement;
        if(root){
            TBXMLElement *nodeElement = [TBXML childElementNamed:@"HourInfo" parentElement:root];
            
            while (nodeElement != nil) {
                NSMutableDictionary *dict = [NSMutableDictionary new];
                
                [self parseKeyInDict:dict key:@"Date" parentElement:nodeElement];
                [self parseKeyInDict:dict key:@"sport" parentElement:nodeElement];
                [self parseKeyInDict:dict key:@"rest" parentElement:nodeElement];
                [self parseKeyInDict:dict key:@"deviceID" parentElement:nodeElement];
                
                [_listData addObject:dict];
                nodeElement = [TBXML nextSiblingNamed:@"HourInfo" searchFromElement:nodeElement];
            }
        }
    }
    else if(type == 2)
    {
        TBXMLElement *root = tbxml.rootXMLElement;
        if (root) {
            TBXMLElement *nodeElement = [TBXML childElementNamed:@"Node" parentElement:root];
            while (nodeElement != nil) {
                NSMutableDictionary *dict = [NSMutableDictionary new];
                
                [self parseKeyInDict:dict key:@"Date" parentElement:nodeElement];
                [self parseKeyInDict:dict key:@"walk" parentElement:nodeElement];
                [self parseKeyInDict:dict key:@"run" parentElement:nodeElement];
                [self parseKeyInDict:dict key:@"rest" parentElement:nodeElement];
                [self parseKeyInDict:dict key:@"sleep" parentElement:nodeElement];
                [self parseKeyInDict:dict key:@"deviceID" parentElement:nodeElement];
                
                [_listData addObject:dict];
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

- (NSMutableDictionary *)parseKeyInDict:(NSMutableDictionary *)dict key:(NSString *)key parentElement:(TBXMLElement *)parentElement
{
    TBXMLElement *element = [TBXML childElementNamed:key parentElement:parentElement];
    if (element != nil) {
        NSString *value = [TBXML textForElement:element];
        [dict setValue:value forKey:key];
    }
    return dict;
}
@end
