//
//  MinstatusBL.m
//  CareElder
//
//  Created by Jzzhou on 16/2/29.
//
//

#import "ZJZKeeperBL.h"
#import "ZJZKeeperDAO.h"

@implementation ZJZKeeperBL

- (void)findKeeper:(ZJZKeeper *)inputKeeper{
    ZJZKeeperDAO *keeperDao = [ZJZKeeperDAO sharedManager];
    [keeperDao findKeeper:inputKeeper];
}


@end
