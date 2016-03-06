//
//  MinstatusDAO.m
//  CareElder
//
//  Created by Jzzhou on 16/2/29.
//
//

#import "ZJZInfoDAO.h"

#import "MKNetworkEngine.h"
#import "MKNetworkOperation.h"

#import "ZJZUserInfoXMLParser.h"

@implementation ZJZInfoDAO

static ZJZInfoDAO *sharedManager = nil;

+ (ZJZInfoDAO *)sharedManager
{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedManager = [[self alloc] init];
    });
    return sharedManager;
}

#pragma mark - 获得用户数据源
- (void)getUserInfo:(NSString *)username at:(NSString *)date withChartType:(NSInteger)type
{
    NSString *writableFilePath = [self getUserFilePath:username at:date withChartType:type];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    // 如果文件已经存在，读取文件
    if ([fileManager fileExistsAtPath:writableFilePath]) {
        ZJZUserInfoXMLParser *parser = [ZJZUserInfoXMLParser new];
        NSArray *resArray = [parser parseFromXMLFilePath:writableFilePath withChartType:type];
        _listData = [[NSMutableArray alloc] initWithArray:resArray];
        
        NSDictionary *dict = [[NSDictionary alloc] initWithObjects:@[date, _listData] forKeys:@[@"date", @"listData"]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [[NSNotificationCenter defaultCenter] postNotificationName:@"XMLFileParsedNoti" object:dict];
        });
        
        return ;
    }
    
    MKNetworkEngine *engine = [[MKNetworkEngine alloc] initWithHostName:HOST_NAME customHeaderFields:nil];
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithObjects:@[date, username] forKeys:@[@"date", @"user"]];
    
    MKNetworkOperation *op = [MKNetworkOperation new];
    if (type == 1) {
        op = [engine operationWithPath:@"selectAllhourData" params:params httpMethod:@"GET" ssl:NO];
    } else if (type == 2) {
        op = [engine operationWithPath:@"selectSportStatistic" params:params httpMethod:@"GET" ssl:NO];
    } else {
        NSAssert1(YES, @"MinStatusDAO.m - Type %ld is not right.", type);
    }
    
    // 异步下载
    [op onCompletion:^(MKNetworkOperation *completedOperation){
        // 保存XML文件
        NSString *content = [op responseString];
        NSDictionary *dict = [[NSDictionary alloc] init];
        // 如果数据为空则不保存退出
        if (content.length < 190) {
            dict = [[NSDictionary alloc] initWithObjects:@[date, @[]] forKeys:@[@"date", @"listData"]];
            dispatch_async(dispatch_get_main_queue(), ^{
                [[NSNotificationCenter defaultCenter] postNotificationName:@"XMLFileParsedNoti" object:dict];
            });
            return ;
        }
        
        [content writeToFile:writableFilePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
        // 按选择的图表type类型解析XML文件
        ZJZUserInfoXMLParser *parser = [ZJZUserInfoXMLParser new];
        NSArray *resArray = [parser parseFromXMLFilePath:writableFilePath withChartType:type];
        _listData = [[NSMutableArray alloc] initWithArray:resArray];
        
        dict = [[NSDictionary alloc] initWithObjects:@[date, _listData] forKeys:@[@"date", @"listData"]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [[NSNotificationCenter defaultCenter] postNotificationName:@"XMLFileParsedNoti" object:dict];
        });
    } onError:^(NSError *error) {
        NSLog(@"%@", error);
    }];
    
    [engine enqueueOperation:op];

}

#pragma mark - 获得用户文件路径
- (NSString *)getUserFilePath:(NSString *)username at:(NSString *)date withChartType:(NSInteger)type
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *userDocumentPath = [documentPath stringByAppendingPathComponent:username];
    // 如果没有文件夹，则为该用户创建文件夹
    [fileManager createDirectoryAtPath:userDocumentPath withIntermediateDirectories:YES attributes:nil error:nil];
    
    NSString *writableFilePath = nil;
    if (type == 1) {    // 柱形或者折现图
        writableFilePath = [userDocumentPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_barOrLine.xml", date]];
    } else if (type == 2) {     // 扇形图
        writableFilePath = [userDocumentPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_pie.xml", date]];
    } else {
        NSAssert1(YES, @"MinStatusDAO.m - Type %ld is not right.", type);
    }

    return writableFilePath;
}

@end
