//
//  LZBCalendar.m
//  LZBCalendar
//
//  Created by zibin on 16/11/13.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LZBCalendar.h"
#import "LZBCalendarHeaderView.h"


@interface LZBCalendar()

@property (nonatomic, strong) LZBCalendarAppearStyle *style;
@property (nonatomic, strong) LZBCalendarHeaderView *headerView;
@end

@implementation LZBCalendar
- (instancetype)initWithStyle:(LZBCalendarAppearStyle *)style
{
  if(self = [super init])
  {
      self.style = style;
      [self setupUI];
  }
    return self;
}

- (void)setupUI
{
    [self addSubview:self.headerView];
    self.headerView.monthDate = self.style.today;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat width = self.bounds.size.width;
    self.headerView.frame = CGRectMake(0, 0, width, self.style.headerViewHeihgt);
}



#pragma mark - lazy
- (LZBCalendarHeaderView *)headerView
{
  if(_headerView == nil)
  {
      _headerView = [[LZBCalendarHeaderView alloc]initWithType:LZBCalendarHeaderViewType_CenterDate style:self.style];
  }
    return _headerView;
}

@end
