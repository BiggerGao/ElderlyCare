//
//  ZFChartViewController.h
//  CareElder
//
//  Created by Jzzhou on 16/3/1.
//
//

#import <UIKit/UIKit.h>

typedef enum{
    KChartTypeBarChart = 0,
    KChartTypeLineChart = 1,
    KChartTypePieChart = 2
}kChartType;

@interface ZFChartViewController : UIViewController

#define SPROT_PARAM_PER_MIN 95

#define GREAT_COLOR  ZFColor(16, 140, 39, 1)
#define GOOD_COLOR  ZFColor(78, 250, 188, 1)
#define WARNING_COLOR ZFColor(240, 215, 0, 1)
#define UNHEALTHY_COLOR ZFColor(220, 20, 34, 1)

#define WARNING_COLOR_1 ZFColor(240, 215, 0, 1)
// 绘图类型
@property (nonatomic, assign) kChartType chartType;

// 传递获得的数据
@property (nonatomic, strong) NSDictionary *dict;
// 解析数组
@property (nonatomic, strong) NSArray *theData;
// 日期
@property (nonatomic, strong) NSString *date;

- (void)loadData:(NSNotification *)noti;

@end

