//
//  MinstatusBL.m
//  CareElder
//
//  Created by Jzzhou on 16/2/29.
//
//

#import "MinStatusBL.h"
#import "MinStatusDAO.h"

@implementation MinStatusBL


- (void) getDataOfOneHour:(NSString *)userName at:(NSString *)date withChartType:(NSInteger)type
{
    MinStatusDAO *minDAO = [MinStatusDAO sharedManager];
    [minDAO getOneHourData:userName at:date withChartType:type];
}
@end
