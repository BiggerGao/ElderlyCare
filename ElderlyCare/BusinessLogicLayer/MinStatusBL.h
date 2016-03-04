//
//  MinstatusBL.h
//  CareElder
//
//  Created by Jzzhou on 16/2/29.
//
//

#import <Foundation/Foundation.h>

@interface MinStatusBL : NSObject


- (void) getDataOfOneHour:(NSString *)userName at:(NSString *)date withChartType:(NSInteger)type;

@end
