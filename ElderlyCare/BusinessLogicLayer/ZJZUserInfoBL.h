//
//  ZJZUserInfoBL.h
//  CareElder
//
//  Created by Jzzhou on 16/2/29.
//
//

#import <Foundation/Foundation.h>

@interface ZJZUserInfoBL : NSObject

- (void)getUserInfo:(NSString *)userName at:(NSString *)date withChartType:(NSInteger)type;

@end
