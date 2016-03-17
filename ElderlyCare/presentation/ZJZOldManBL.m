//
//  ZJZOldManBL.m
//  ElderlyCare
//
//  Created by Jzzhou on 16/3/17.
//
//

#import "ZJZOldManBL.h"
#import "ZJZOldManDAO.h"

@implementation ZJZOldManBL

- (void)getOldManInfo:(NSString *)name at:(NSString *)date withChartType:(NSInteger)type
{
    ZJZOldManDAO *oldManDAO = [ZJZOldManDAO sharedManager];
    [oldManDAO findOldManInfo:name at:date withChartType:type];
}

- (void)findAllInfo:(NSString *)username {
    ZJZOldManDAO *oldManDAO = [ZJZOldManDAO sharedManager];
    [oldManDAO findAllSportStatistic:username];
}
@end
