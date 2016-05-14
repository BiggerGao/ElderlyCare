//
//  JZZForecastDetailController.h
//  ZJZWeather
//
//  Created by Jzzhou on 16/5/12.
//  Copyright © 2016年 Jzzhou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JZZForecastDetailController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSDictionary *infoDict;

@end
