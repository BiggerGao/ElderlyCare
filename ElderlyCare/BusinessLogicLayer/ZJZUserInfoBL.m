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


- (void)getUserInfo:(NSString *)userName at:(NSString *)date withChartType:(NSInteger)type
{
    ZJZInfoDAO *infoDAO = [ZJZInfoDAO sharedManager];
    [infoDAO getUserInfo:userName at:date withChartType:type];
}
@end
