//
//  ZJZCenterItem.h
//  ElderlyCare
//
//  Created by Jzzhou on 16/3/10.
//
//

#import <Foundation/Foundation.h>

@interface ZJZCenterItem : NSObject
/** 标题 */
@property (nonatomic, strong) NSString *title;
/** 左图标 */
@property (nonatomic, strong) UIImage *image;
/** 行高度 */
@property (nonatomic, assign) CGFloat height;
/** 右图标样式 */
@property (nonatomic, assign) UITableViewCellAccessoryType type;

// 设置标题值
+ (instancetype)initWithTitle:(NSString *)title;

@end
