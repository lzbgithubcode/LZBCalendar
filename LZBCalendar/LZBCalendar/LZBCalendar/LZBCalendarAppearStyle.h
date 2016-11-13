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

@property (nonatomic, assign) CGFloat headerViewDateHeight;
@property (nonatomic, assign) CGFloat headerViewWeekHeight;
@property (nonatomic, assign) CGFloat headerViewLineHeight;
@property (nonatomic, assign, readonly) CGFloat headerViewHeihgt;
@property (nonatomic, strong) UIFont  *headerViewDateFont;
@property (nonatomic, strong) UIFont  *headerViewWeekFont;
@property (nonatomic, strong) UIColor *headerViewWeekColor;
@property (nonatomic, strong) UIColor *headerViewDateColor;

@property (nonatomic, strong) NSDate *today;



@property (nonatomic, strong) NSArray <NSString*>*weekDateDays;

@end
