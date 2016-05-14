//
//  MinstatusDAO.h
//  CareElder
//
//  Created by Jzzhou on 16/2/29.
//
//

#import <Foundation/Foundation.h>
#import "ZJZKeeper.h"
#import "ZJZSettingPhotoViewController.h"
#import "ZJZLoginViewController.h"

// 主机名
#define HOST_NAME @"139.129.38.72/Service1.asmx"

@interface ZJZKeeperDAO : NSObject

+ (ZJZKeeperDAO *)sharedManager;

// 解析数据数组
@property (nonatomic, copy) NSArray *listData;
@property (nonatomic, weak) id<ZJZCompleteRegisterDelegate> registerDelegate;
@property (nonatomic, weak) id<ZJZLoginDelegate> loginDelegate;
/** 查找keeper*/
- (void)findKeeper:(ZJZKeeper *)inputKeeper;
/** 添加keeper*/
- (void)addKeeper:(ZJZKeeper *)inputKeeper;

@end
