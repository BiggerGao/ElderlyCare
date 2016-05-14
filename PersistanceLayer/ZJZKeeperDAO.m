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
    operation = [engine operationWithPath:@"selectKeeper"
                                   params:@{@"tel":inputKeeper.tel, @"pwd":inputKeeper.password}
                               httpMethod:@"GET"
                                      ssl:NO];
    
    [operation onCompletion:^(MKNetworkOperation *completedOperation) {
        ZJZXMLParser *parser = [[ZJZXMLParser alloc] init];
        NSArray *users = [parser parseKeeperInfo:[completedOperation responseString]];
        ZJZKeeper *keeper = [users firstObject];
        if (!keeper) {
            [self.loginDelegate keeperIsNotExist];
        } else {
            [self.loginDelegate foundKeeper:keeper];
        }
    } onError:^(NSError *error) {
        NSLog(@"%@", error);
        [self.loginDelegate keeperIsNotExist];
    }];
    [engine enqueueOperation:operation];
}

#pragma mark - 添加用户
- (void)addKeeper:(ZJZKeeper *)inputKeeper
{
    NSDictionary *par = @{@"tel": inputKeeper.tel, @"pwd": inputKeeper.password, @"nickName": inputKeeper.nickname};
    MKNetworkEngine *engine = [[MKNetworkEngine alloc] initWithHostName:HOST_NAME customHeaderFields:nil];
    MKNetworkOperation *op = [[MKNetworkOperation alloc] init];
    op = [engine operationWithPath:@"insertKeeperInfo" params:par httpMethod:@"POST" ssl:NO];
    
    [op onCompletion:^(MKNetworkOperation *completedOperation) {
        NSString *resultStr = [self parseResponse:completedOperation.responseString];

        if ([resultStr isEqualToString:@"true"]) {
            [self.registerDelegate completeRegister];
        } else {
            [self.registerDelegate keeperAlreadyExist];
        }
    } onError:^(NSError *error) {
        NSLog(@"error---> %@", error);
    }];
    
    [engine enqueueOperation:op];
}

- (NSString *)parseResponse:(NSString *)response {
    NSMutableArray *resArray = [NSMutableArray array];
    TBXML *tbxml = [[TBXML alloc] initWithXMLString:response error:nil];
    TBXMLElement *root = tbxml.rootXMLElement;
    if (root) {
        NSString *resultStr = [TBXML textForElement:root];
        return resultStr;
    } else {
        return nil;
    }
    
}

@end
