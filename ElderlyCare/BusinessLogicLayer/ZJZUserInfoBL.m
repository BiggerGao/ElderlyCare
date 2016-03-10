//
//  MinstatusBL.m
//  CareElder
//
//  Created by Jzzhou on 16/2/29.
//
//

#import "ZJZUserInfoBL.h"
#import "ZJZInfoDAO.h"

@implementation ZJZUserInfoBL

- (void)findAllUsers {
    ZJZInfoDAO *infoDao = [ZJZInfoDAO sharedManager];
    [infoDao findAllUsers];
}

- (void)getUserInfo:(NSString *)userName at:(NSString *)date withChartType:(NSInteger)type
{
    ZJZInfoDAO *infoDAO = [ZJZInfoDAO sharedManager];
    [infoDAO findUserInfo:userName at:date withChartType:type];
}

- (void)findAllInfo:(NSString *)username {
    ZJZInfoDAO *infoDAO = [ZJZInfoDAO sharedManager];
    [infoDAO findAllSportStatistic:username];
}
@end
