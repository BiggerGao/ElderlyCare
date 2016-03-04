//
//  MinstatusDAO.m
//  CareElder
//
//  Created by Jzzhou on 16/2/29.
//
//

#import "MinStatusDAO.h"

#import "MKNetworkEngine.h"
#import "MKNetworkOperation.h"
#import "MinstatusTBXMLParser.h"

@implementation MinStatusDAO

static MinStatusDAO *sharedManager = nil;

+ (MinStatusDAO *)sharedManager
{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedManager = [[self alloc] init];
    });
    return sharedManager;
}

- (void) getOneHourData: (NSString *)username at:(NSString *)date withChartType:(NSInteger)type
{
    
    NSString *writableFilePath = [self getUserWritableFilePath:username at:date withChartType:type];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    // 如果文件已经存在
    if ([fileManager fileExistsAtPath:writableFilePath]) {
        MinStatusTBXMLParser *parser = [MinStatusTBXMLParser new];
        NSArray *resArray = [parser parseFromXMLFile2Path:writableFilePath withChartType:type];
        _listData = [[NSMutableArray alloc] initWithArray:resArray];
        
        NSDictionary *dict = [[NSDictionary alloc] initWithObjects:@[date, _listData] forKeys:@[@"date", @"1HourData"]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [[NSNotificationCenter defaultCenter] postNotificationName:@"1HourXMLFileParseEndNoti" object:dict];
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
            [[NSNotificationCenter defaultCenter] postNotificationName:@"1HourXMLFileParseEndNoti" object:dict];
            return ;
        }
        
        [content writeToFile:writableFilePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
        // 按选择的图表type类型解析XML文件
        MinStatusTBXMLParser *parser = [MinStatusTBXMLParser new];
        NSArray *resArray = [parser parseFromXMLFile2Path:writableFilePath withChartType:type];
        _listData = [[NSMutableArray alloc] initWithArray:resArray];
        
        dict = [[NSDictionary alloc] initWithObjects:@[date, _listData] forKeys:@[@"date", @"1HourData"]];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"1HourXMLFileParseEndNoti" object:dict];
    } onError:^(NSError *error) {
        NSLog(@"%@", error);
    }];
    
    [engine enqueueOperation:op];

}

- (NSString *)getUserWritableFilePath:(NSString *)username at:(NSString *)date withChartType:(NSInteger)type
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *userDocumentPath = [documentPath stringByAppendingPathComponent:username];
    [fileManager createDirectoryAtPath:userDocumentPath withIntermediateDirectories:YES attributes:nil error:nil];
    
    NSString *writableFilePath = nil;
    if (type == 1) {
        writableFilePath = [userDocumentPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_barOrLine.xml", date]];
    } else if (type == 2) {
        writableFilePath = [userDocumentPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_pie.xml", date]];
    } else {
        NSAssert1(YES, @"MinStatusDAO.m - Type %ld is not right.", type);
    }

    return writableFilePath;
}

- (void) getAll2Point5MinsData:(NSString *)userName at:(NSString *)date withChartType:(NSInteger)type
{
    MKNetworkEngine *engine = [[MKNetworkEngine alloc] initWithHostName:HOST_NAME customHeaderFields:nil];
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithObjects:@[date, userName] forKeys:@[@"date", @"user"]];
    
    MKNetworkOperation *op = [engine operationWithPath:@"selectAllminuteData" params:params httpMethod:@"GET" ssl:NO];
    
    // 异步下载
    [op onCompletion:^(MKNetworkOperation *completedOperation){
        // 保存XML文件
        NSString *writableFilePath = [self getUserWritableFilePath:userName at:date withChartType:type];
        
        // 解析XML文件
        MinStatusTBXMLParser *parser = [MinStatusTBXMLParser new];
        NSArray *resArray = [parser parseFromXMLFile1Path:writableFilePath];
        _listData = [[NSMutableArray alloc] initWithArray:resArray];
        
        // 数据提取
        [self AnalysisListData:_listData];
        
        NSDictionary *dict = [[NSDictionary alloc] initWithObjects:@[date, _listData] forKeys:@[@"date", @"2.5minData"]];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"2.5MinXMLFileParseEndNoti" object:dict];
    } onError:^(NSError *error) {
        NSLog(@"%@", error);
    }];
    
    [engine enqueueOperation:op];
}

- (void)AnalysisListData:(NSArray *)listData
{
    NSMutableArray *resArray = [[NSMutableArray alloc] init];
    NSString *prevRange = @"0";
    int stepCnt = 0;
    for (NSDictionary *dict in listData) {
        NSString *time = [dict objectForKey:@"end"];

        // 如果第10位为":"则小时位只有1位
        NSString *checkChar = [time substringWithRange:NSMakeRange(10, 1)];
        // 小时位只有1位
        
        NSString *newRange;
        if ([checkChar isEqualToString:@":"]) {
            newRange = [time substringWithRange:NSMakeRange(9, 1)];
        } else {
            newRange = [time substringWithRange:NSMakeRange(9, 2)];
        }
        
        stepCnt += [self calculate1Time:newRange];
        if (![prevRange isEqualToString:newRange]) {
            NSString *date = [time substringToIndex:9];
            date = [date stringByReplacingOccurrencesOfString:@"/" withString:@"-"];

            NSString *step = [NSString stringWithFormat:@"%d", stepCnt];
            
            NSDictionary *dict = [[NSDictionary alloc] initWithObjects:@[date, prevRange, step] forKeys:@[@"date", @"range", @"stepCount"]];
            
            [resArray addObject:dict];
            
            stepCnt = 0;
            prevRange = newRange;
            NSLog(@"%@", prevRange);
        }
        
    }
}

- (int)calculate1Time:(NSString *)type
{
    float param = 0.0;
    if ([type isEqualToString:@"2"]) {
        param = WALK_PARAM;
    }
    if([type isEqualToString:@"3"])
    {
        param = RUN_PARAM;
    }
    
    return 150 * param;
}
@end
