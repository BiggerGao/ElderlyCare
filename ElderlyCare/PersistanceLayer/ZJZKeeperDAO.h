//
//  MinstatusDAO.h
//  CareElder
//
//  Created by Jzzhou on 16/2/29.
//
//

#import <Foundation/Foundation.h>
#import "ZJZKeeper.h"
// 主机名
#define HOST_NAME @"172.20.52.175:11125/Service1.asmx"

@interface ZJZKeeperDAO : NSObject

+ (ZJZKeeperDAO *)sharedManager;

// 解析数据数组
@property (nonatomic, copy) NSArray *listData;

// 查找看护人
- (void)findKeeper:(ZJZKeeper *)inputKeeper;

@end
