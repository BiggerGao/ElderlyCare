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

#import "ZJZXMLParser.h"

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

#pragma mark - 获得老人运动总统计量
- (void)findAllSportStatistic:(NSString *)username
{
    MKNetworkEngine *engine = [[MKNetworkEngine alloc] initWithHostName:HOST_NAME customHeaderFields:nil];
    MKNetworkOperation *operation = [MKNetworkOperation new];
    operation = [engine operationWithPath:@"selectAllSportStatistic" params:nil httpMethod:@"GET" ssl:NO];
    [operation onCompletion:^(MKNetworkOperation *completedOperation) {
        ZJZXMLParser *parser = [ZJZXMLParser new];
        NSArray *resArr = [parser parseChartType2String:[operation responseString]];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"AllSportStatisticNoti" object:resArr];
    } onError:^(NSError *error) {
        NSLog(@"%@", error);
    }];
    [engine enqueueOperation:operation];
}

#pragma mark - 获得所有用户账户信息
- (void)findAllUsers
{
    MKNetworkEngine *engine = [[MKNetworkEngine alloc] initWithHostName:HOST_NAME customHeaderFields:nil];
    MKNetworkOperation *operation = [MKNetworkOperation new];
    operation = [engine operationWithPath:@"selectAllUser" params:nil httpMethod:@"GET" ssl:NO];
    [operation onCompletion:^(MKNetworkOperation *completedOperation) {
        ZJZXMLParser *parser = [ZJZXMLParser new];
        NSArray *users = [parser parseUserInfo:[operation responseString]];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"AllUsersInfoNoti" object:users];
    } onError:^(NSError *error) {
        NSLog(@"%@", error);
    }];
    [engine enqueueOperation:operation];
}

#pragma mark - 获得用户数据源
- (void)findUserInfo:(NSString *)username at:(NSString *)date withChartType:(NSInteger)type
{
    NSString *writableFilePath = [self findUserFilePath:username at:date withChartType:type];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    // 如果文件已经存在，读取文件
    if ([fileManager fileExistsAtPath:writableFilePath]) {
        ZJZXMLParser *parser = [ZJZXMLParser new];
        NSArray *resArray = [parser parseFromXMLFilePath:writableFilePath withChartType:type];
        _listData = [[NSMutableArray alloc] initWithArray:resArray];
        
        NSDictionary *dict = [[NSDictionary alloc] initWithObjects:@[date, _listData] forKeys:@[@"date", @"listData"]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [[NSNotificationCenter defaultCenter] postNotificationName:@"XMLFileParsedNoti" object:dict];
        });
        
        return ;
    }
    
    MKNetworkEngine *engine = [[MKNetworkEngine alloc] initWithHostName:HOST_NAME customHeaderFields:nil];
    
    NSDictionary *params = @{@"date": date, @"user": username};
    
    MKNetworkOperation *op = [MKNetworkOperation new];
    if (type == 1) {
        op = [engine operationWithPath:@"selectAllhourData" params:[params copy] httpMethod:@"GET" ssl:NO];
    } else if (type == 2) {
        op = [engine operationWithPath:@"selectSportStatistic" params:[params copy] httpMethod:@"GET" ssl:NO];
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
        ZJZXMLParser *parser = [ZJZXMLParser new];
        NSArray *resArray = [parser parseFromXMLFilePath:writableFilePath withChartType:type];
        _listData = [[NSMutableArray alloc] initWithArray:resArray];
        
        dict = [[NSDictionary alloc] initWithObjects:@[date, _listData] forKeys:@[@"date", @"listData"]];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"XMLFileParsedNoti" object:dict];
    } onError:^(NSError *error) {
        NSLog(@"%@", error);
    }];
    
    [engine enqueueOperation:op];

}

#pragma mark - 获得用户文件路径
- (NSString *)findUserFilePath:(NSString *)username at:(NSString *)date withChartType:(NSInteger)type
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
