//
//  LZBCalendarHeaderView.h
//  LZBCalendar
//
//  Created by zibin on 16/11/13.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LZBCalendar.h"

typedef void(^LZBCalendarHeaderViewBlock)(NSDate *date);

typedef NS_ENUM(NSInteger,LZBCalendarHeaderViewType)
{
    LZBCalendarHeaderViewType_LeftDate,   //左边日期
    LZBCalendarHeaderViewType_CenterDate, //中间日期
};

@interface LZBCalendarHeaderView : UIView

@property (nonatomic, strong) NSDate *monthDate;
@property (nonatomic, copy)  LZBCalendarHeaderViewBlock previousMonthClick;
@property (nonatomic, copy)  LZBCalendarHeaderViewBlock nextMonthClick;

- (void)setPreviousMonthClick:(LZBCalendarHeaderViewBlock)previousMonthClick;
- (void)setNextMonthClick:(LZBCalendarHeaderViewBlock)nextMonthClick;
- (instancetype)initWithType:(LZBCalendarHeaderViewType)type style:(LZBCalendarAppearStyle *)style;



@end
