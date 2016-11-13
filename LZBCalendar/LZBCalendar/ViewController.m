//
//  ViewController.m
//  LZBCalendar
//
//  Created by zibin on 16/11/13.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ViewController.h"
#import "LZBCalendar.h"
#import "LZBCalendarAppearStyle.h"

@interface ViewController ()

@property (nonatomic, strong) LZBCalendar *calendar;
@property (nonatomic, strong)  LZBCalendarAppearStyle *style;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.calendar];
  
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.calendar.frame = CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 300);
}




#pragma mark - lazy
- (LZBCalendar *)calendar
{
  if(_calendar == nil)
  {
      _calendar = [[LZBCalendar alloc]initWithStyle:self.style];
  }
    return _calendar;
}

- (LZBCalendarAppearStyle *)style
{
  if(_style == nil)
  {
      _style = [[LZBCalendarAppearStyle alloc]init];
  }
    return _style;
}


@end
