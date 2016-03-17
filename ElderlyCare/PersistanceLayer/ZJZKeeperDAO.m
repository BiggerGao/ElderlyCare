//
//  MinstatusDAO.m
//  CareElder
//
//  Created by Jzzhou on 16/2/29.
//
//

#import "ZJZKeeperDAO.h"

#import "MKNetworkEngine.h"
#import "MKNetworkOperation.h"

#import "ZJZXMLParser.h"

@implementation ZJZKeeperDAO

static ZJZKeeperDAO *sharedManager = nil;

+ (ZJZKeeperDAO *)sharedManager
{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedManager = [[self alloc] init];
    });
    return sharedManager;
}

#pragma mark - 查找用户
- (void)findKeeper:(ZJZKeeper *)inputKeeper
{
    MKNetworkEngine *engine = [[MKNetworkEngine alloc] initWithHostName:HOST_NAME customHeaderFields:nil];
    MKNetworkOperation *operation = [[MKNetworkOperation alloc] init];
    operation = [engine operationWithPath:@"selectAllUser"
                                   params:@{@"uname":inputKeeper.account, @"pwd":inputKeeper.password}
                               httpMethod:@"GET"
                                      ssl:NO];
    
    [operation onCompletion:^(MKNetworkOperation *completedOperation) {
        
        ZJZXMLParser *parser = [[ZJZXMLParser alloc] init];
        NSArray *users = [parser parseKeeperInfo:[operation responseString]];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"FindkeeperInfoNoti" object:users];
    } onError:^(NSError *error) {
        NSLog(@"%@", error);
    }];
    [engine enqueueOperation:operation];
}

@end
