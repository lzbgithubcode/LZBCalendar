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

@property (nonatomic, assign) BOOL isNeedCustomHeihgt;
@property (nonatomic, strong) NSDate *today;

//头部style设置
@property (nonatomic, assign) CGFloat headerViewDateHeight;
@property (nonatomic, assign) CGFloat headerViewWeekHeight;
@property (nonatomic, assign) CGFloat headerViewLineHeight;
@property (nonatomic, assign, readonly) CGFloat headerViewHeihgt;
@property (nonatomic, strong) UIFont  *headerViewDateFont;
@property (nonatomic, strong) UIFont  *headerViewWeekFont;
@property (nonatomic, strong) UIColor *headerViewWeekColor;
@property (nonatomic, strong) UIColor *headerViewDateColor;


//日期sytle设置
@property (nonatomic, assign) CGFloat itemHeight;
@property (nonatomic, strong) UIFont *dateTittleFont;
@property (nonatomic, strong) UIFont *dateDescFont;
@property (nonatomic, strong) UIColor *dateTittleSelectColor;
@property (nonatomic, strong) UIColor *dateTittleUnselectColor;
@property (nonatomic, strong) UIColor *dateDescSelectColor;
@property (nonatomic, strong) UIColor *dateDescUnselectColor;
@property (nonatomic, assign) UIOffset dateTitleDescOffset;





@property (nonatomic, strong) NSArray <NSString*>*weekDateDays;

@end
