//
//  LZBCalendarAppearStyle.m
//  LZBCalendar
//
//  Created by zibin on 16/11/13.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LZBCalendarAppearStyle.h"

@implementation LZBCalendarAppearStyle
- (instancetype)init
{
  if(self = [super init])
  {
      self.isNeedCustomHeihgt = YES;
      self.headerViewDateHeight = 40;
      self.headerViewLineHeight = 1.0;
      self.headerViewWeekHeight = 40;
      self.weekDateDays = @[@"日",@"一",@"二",@"三",@"四",@"五",@"六"];
      self.headerViewDateFont = [UIFont systemFontOfSize:16.0];
      self.headerViewWeekFont = [UIFont systemFontOfSize:16.0];
      self.headerViewWeekColor = [UIColor greenColor];
      self.headerViewDateColor = [UIColor whiteColor];
      self.today = [NSDate date];
  }
    return self;
}

- (CGFloat)headerViewHeihgt
{
    return self.headerViewDateHeight + self.headerViewLineHeight + self.headerViewWeekHeight;
}



@end
