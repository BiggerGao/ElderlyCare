//
//  ViewController.h
//  ZJZWeather
//
//  Created by Jzzhou on 16/5/10.
//  Copyright © 2016年 Jzzhou. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, JZZWeatherType) {
    JZZWeatherTypeOldMan = 1 << 0,
    JZZWeatherTypeMyself = 1 << 1
};

@interface JZZWeatherController : UIViewController <UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>


- (instancetype)initWithType:(JZZWeatherType)type;

@end

