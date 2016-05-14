//
//  ZJZCenterItem.h
//  ElderlyCare
//
//  Created by Jzzhou on 16/3/10.
//
//

#import <Foundation/Foundation.h>
@class ZJZOldMan;

@interface ZJZCenterItem : NSObject

/** 标题 */
@property (nonatomic, copy) NSString *title;
/** 左图标 */
@property (nonatomic, copy) NSString *imageName;
/** 行高度 */
@property (nonatomic, assign) CGFloat height;
/** 右图标样式 */
@property (nonatomic, assign) UITableViewCellAccessoryType type;

// 设置标题值
+ (instancetype)initWithTitle:(NSString *)title;
+ (instancetype)initWithOldman:(ZJZOldMan *)oldman;

@end
