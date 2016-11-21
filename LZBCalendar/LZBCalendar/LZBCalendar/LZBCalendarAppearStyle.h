//
//  LZBCalendarAppearStyle.h
//  LZBCalendar
//
//  Created by zibin on 16/11/13.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface LZBCalendarAppearStyle : NSObject

#pragma mark- head-data

/**
 *  设置item的高度，isNeedCustomHeihgt是YES，可以设置itemHeight
 */
@property (nonatomic, assign) BOOL isNeedCustomHeihgt;

/**
 *  设置当前日期
 */
@property (nonatomic, strong) NSDate *today;

/**
 *  设置是否支持同时选中多个日期，默认isSupportMoreSelect = NO
 */
@property (nonatomic, assign) BOOL isSupportMoreSelect;


/**
 *  设置星期日期的样式，默认是中文  @"日",@"一",@"二",@"三",@"四",@"五",@"六"
 */
@property (nonatomic, strong) NSArray <NSString*>*weekDateDays;

#pragma mark- 头部style设置

/**
 *  设置头部View的选择月份View的高度
 */
@property (nonatomic, assign) CGFloat headerViewDateHeight;

/**
 *  设置头部View的星期几View的高度
 */
@property (nonatomic, assign) CGFloat headerViewWeekHeight;

/**
 *  设置头部View的星期几View与选择月份View中间分割线的高度
 */
@property (nonatomic, assign) CGFloat headerViewLineHeight;

/**
 *  获得整个头部View的高度
 */
@property (nonatomic, assign, readonly) CGFloat headerViewHeihgt;

/**
 *  设置头部View的选择月份View的字体
 */
@property (nonatomic, strong) UIFont  *headerViewDateFont;

/**
 *  设置头部View的选择月份View的字体颜色
 */
@property (nonatomic, strong) UIColor *headerViewDateColor;

/**
 *  设置头部View的星期几View的字体
 */
@property (nonatomic, strong) UIFont  *headerViewWeekFont;

/**
 *  设置头部View的星期几View的字体颜色
 */
@property (nonatomic, strong) UIColor *headerViewWeekColor;




#pragma mark-日期sytle设置
/**
 *  设置日期item的的高度，宽度根据屏幕宽度自动适应  isNeedCustomHeihgt = YES 有效
 */
@property (nonatomic, assign) CGFloat itemHeight;

/**
 *  设置日期item的标题字体大小
 */
@property (nonatomic, strong) UIFont *dateTittleFont;

/**
 *  设置日期item的描述字体大小
 */
@property (nonatomic, strong) UIFont *dateDescFont;

/**
 *  设置日期item的标题字体选中颜色
 */
@property (nonatomic, strong) UIColor *dateTittleSelectColor;

/**
 *  设置日期item的标题字体未选中颜色
 */
@property (nonatomic, strong) UIColor *dateTittleUnselectColor;

/**
 *  设置日期item的选中背景颜色
 */
@property (nonatomic, strong) UIColor *dateBackSelectColor;

/**
 *  设置日期item的未选中背景颜色
 */
@property (nonatomic, strong) UIColor *dateBackUnselectColor;

/**
 *  设置日期item的描述选中背景颜色
 */
@property (nonatomic, strong) UIColor *dateDescSelectColor;

/**
 *  设置日期item的描述未选中背景颜色
 */
@property (nonatomic, strong) UIColor *dateDescUnselectColor;

/**
 *  设置日期item的title与描述间距 UIOffset
 */
@property (nonatomic, assign) UIOffset dateTitleDescOffset;


@end
