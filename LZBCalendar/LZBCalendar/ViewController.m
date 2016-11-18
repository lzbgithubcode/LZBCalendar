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

@interface ViewController ()<LZBCalendarDataSource,LZBCalendarDataDelegate>

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


#pragma mark - delegate
- (void)calendar:(LZBCalendar *)calendar didSelectDate:(NSDate *)date
{
    NSLog(@"当前调用的方法:%s------行号:line-%d ",__func__, __LINE__);
}



#pragma mark - dataSoure
- (NSString *)calendar:(LZBCalendar *)calendar titleForDate:(NSDate *)date
{
    NSInteger result =[self day:[NSDate date]] - [self day:date];
    switch (result) {
        case 0:
            return @"今天";
            break;
        case 1:
            return @"昨天";
            break;
        case -1:
             return @"明天";
            break;
            
        default:
            return nil;
            break;
    }
}

- (NSString *)calendar:(LZBCalendar *)calendar subtitleForDate:(NSDate *)date
{
    NSInteger result = [self day:date];
    switch (result) {
        case 1:
            return @"10";
            break;
        case 2:
            return @"20";
            break;
        case 3:
            return @"免费";
            break;
            
        default:
            return nil;
            break;
    }
}

- (void)calendar:(LZBCalendar *)calendar layoutCallBackHeight:(CGFloat)height
{
    self.calendar.frame = CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, height);
}


- (NSInteger)day:(NSDate *)date{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    return [components day];
}

#pragma mark - lazy
- (LZBCalendar *)calendar
{
  if(_calendar == nil)
  {
      _calendar = [[LZBCalendar alloc]initWithStyle:self.style];
      _calendar.dataSource = self;
      _calendar.delegate = self;
  }
    return _calendar;
}

- (LZBCalendarAppearStyle *)style
{
  if(_style == nil)
  {
      _style = [[LZBCalendarAppearStyle alloc]init];
      _style.isNeedCustomHeihgt = YES;
  }
    return _style;
}


@end
