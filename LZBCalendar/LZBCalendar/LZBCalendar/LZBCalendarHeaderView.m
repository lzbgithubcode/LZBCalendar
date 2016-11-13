//
//  LZBCalendarHeaderView.m
//  LZBCalendar
//
//  Created by zibin on 16/11/13.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LZBCalendarHeaderView.h"

#define default_Button_Width  100

@interface LZBCalendarHeaderView()

@property (nonatomic, assign)  LZBCalendarHeaderViewType headType;
@property (nonatomic, strong)  LZBCalendarAppearStyle *style;
@property (nonatomic, strong)  UIView *topView;
@property (nonatomic, strong)  UIView *bottomView;
@property (nonatomic, strong)  UIView *lineView;
//topView控件
@property (nonatomic, strong)  UIButton *previousButton;
@property (nonatomic, strong)  UIButton *nextButton;
@property (nonatomic, strong)  UILabel *dateLable;

//bottomView控件
@property (nonatomic, strong) NSMutableArray <UILabel *> *weekdayLabels;
@end

@implementation LZBCalendarHeaderView

- (instancetype)initWithType:(LZBCalendarHeaderViewType)type style:(LZBCalendarAppearStyle *)style;
{
  if(self = [super init])
  {
      self.headType = type;
      self.style = style;
      [self setupUI];
  }
    return self;
}

- (void)setupUI
{
    [self addSubview:self.topView];
    [self addSubview:self.bottomView];
    [self addSubview:self.lineView];
    [self.topView addSubview:self.dateLable];
    switch (self.headType)
    {
        case LZBCalendarHeaderViewType_LeftDate:
            break;
        case LZBCalendarHeaderViewType_CenterDate:
            {
                [self.topView addSubview:self.previousButton];
                [self.topView addSubview:self.nextButton];
                self.previousButton.hidden = NO;
                self.nextButton.hidden = NO;
            }
            break;
            
        default:
            break;
    }
    
    //week
    for (NSInteger i = 0; i< self.style.weekDateDays.count; i++)
    {
        UILabel  *label = [[UILabel alloc] initWithFrame:CGRectZero];
        label.textAlignment = NSTextAlignmentCenter;
        [self.bottomView addSubview:label];
        [self.weekdayLabels addObject:label];
    }
    
    [self initValidSettingData];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat selfWidth = self.bounds.size.width;

    if(self.style.isNeedCustomHeihgt)
    {
        self.topView.frame = CGRectMake(0, 0, selfWidth, self.style.headerViewDateHeight);
        self.lineView.frame = CGRectMake(0, CGRectGetMaxY(self.topView.frame), selfWidth, self.style.headerViewLineHeight);
        self.bottomView.frame = CGRectMake(0, CGRectGetMaxY(self.lineView.frame), selfWidth, self.style.headerViewWeekHeight);
      
        switch (self.headType)
        {
            case LZBCalendarHeaderViewType_LeftDate:
            {
                self.dateLable.frame =CGRectMake(0, 0, selfWidth, self.topView.frame.size.height);
                self.dateLable.textAlignment = NSTextAlignmentLeft;
            }
                break;
            case LZBCalendarHeaderViewType_CenterDate:
            {

                self.previousButton.frame = CGRectMake(0, 0, default_Button_Width, self.topView.frame.size.height);
                self.nextButton.frame = CGRectMake(selfWidth-default_Button_Width, 0, default_Button_Width, self.topView.frame.size.height);
                self.dateLable.center = self.topView.center;
                self.dateLable.bounds = CGRectMake(0, 0, selfWidth - 2*default_Button_Width, self.topView.frame.size.height);
                self.dateLable.textAlignment = NSTextAlignmentCenter;
            }
                break;
                
            default:
                break;
        }
        
        CGFloat weekdayWidth = self.bottomView.bounds.size.width / self.style.weekDateDays.count;
        CGFloat weekdayHeight =self.bottomView.bounds.size.height;
        [self.weekdayLabels enumerateObjectsUsingBlock:^(UILabel * _Nonnull label, NSUInteger index, BOOL * _Nonnull stop) {
             label.frame = CGRectMake(index*weekdayWidth,0, weekdayWidth, weekdayHeight);
        }];
        
    }
    else
    {
       //计算高度
    }
    
   
}


#pragma mark - API
- (void)previousButtonClick
{
    self.monthDate = [self lastMonthDate:self.monthDate];
    if(self.previousMonthClick)
        self.previousMonthClick(self.monthDate);
}

- (void)nextButtonClick
{
    self.monthDate = [self nextMonth:self.monthDate];
    if(self.nextMonthClick)
        self.nextMonthClick(self.monthDate);
}

- (void)setMonthDate:(NSDate *)monthDate
{
    _monthDate = monthDate;
    [self.dateLable setText:[NSString stringWithFormat:@"%ld-%.2ld",(long)[self year:monthDate],(long)[self month:monthDate]]];
}

- (void)initValidSettingData
{
    [self invalidateHeaderFont];
    [self invalidateWeekdayFont];
    [self invalidateWeekdayTextColor];
    [self invalidateHeaderTextColor];
    [self.weekdayLabels enumerateObjectsUsingBlock:^(UILabel * _Nonnull label, NSUInteger index, BOOL * _Nonnull stop) {
        if(index < self.style.weekDateDays.count)
            label.text = self.style.weekDateDays[index];
    }];
}

- (void)invalidateHeaderFont
{
    self.dateLable.font = self.style.headerViewDateFont;
}
- (void)invalidateHeaderTextColor
{
    self.dateLable.textColor = self.style.headerViewDateColor;
}
- (void)invalidateWeekdayFont
{
    [self.weekdayLabels makeObjectsPerformSelector:@selector(setFont:) withObject:self.style.headerViewWeekFont];
}
- (void)invalidateWeekdayTextColor
{
   [self.weekdayLabels makeObjectsPerformSelector:@selector(setTextColor:) withObject:self.style.headerViewWeekColor];
}

#pragma mark- private
- (NSInteger)month:(NSDate *)date
{
    return [self getDateComponentsFromDate:date].month;
}

- (NSInteger)year:(NSDate *)date
{
    return [self getDateComponentsFromDate:date].year;
}

- (NSDate *)lastMonthDate:(NSDate *)date
{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.month = -1;
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:date options:NSCalendarWrapComponents];
    return newDate;
}
- (NSDate*)nextMonth:(NSDate *)date
{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.month = +1;
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:date options:NSCalendarWrapComponents];
    return newDate;
}

- (NSDateComponents *)getDateComponentsFromDate:(NSDate *)date
{
  NSDateComponents *component = [[NSCalendar currentCalendar] components:
                                 (NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    return component;
}



#pragma mark - lazy
-(UIView *)topView
{
   if(_topView == nil)
   {
       _topView = [UIView new];
       _topView.backgroundColor = [UIColor greenColor];
   }
    return _topView;
}

- (UILabel *)dateLable
{
  if(_dateLable == nil)
  {
      _dateLable = [UILabel new];
  }
    return _dateLable;
}

- (UIButton *)previousButton
{
  if(_previousButton == nil)
  {
      _previousButton = [UIButton buttonWithType:UIButtonTypeCustom];
      [_previousButton setTitle:@"上一月" forState:UIControlStateNormal];
      [_previousButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
      [_previousButton addTarget:self action:@selector(previousButtonClick) forControlEvents:UIControlEventTouchUpInside];
  }
    return _previousButton;
}

- (UIButton *)nextButton
{
  if(_nextButton == nil)
  {
      _nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
      [_nextButton setTitle:@"下一月" forState:UIControlStateNormal];
      [_nextButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
      [_nextButton addTarget:self action:@selector(nextButtonClick) forControlEvents:UIControlEventTouchUpInside];
  }
    return _nextButton;
}

- (UIView *)bottomView
{
  if(_bottomView == nil)
  {
      _bottomView = [UIView new];
  }
    return _bottomView;
}
- (NSMutableArray<UILabel *> *)weekdayLabels
{
   if(_weekdayLabels == nil)
   {
       _weekdayLabels = [NSMutableArray array];
   }
    return _weekdayLabels;
}

- (UIView *)lineView
{
  if(_lineView == nil)
  {
      _lineView = [UIView new];
  }
    return _lineView;
}

@end
