//
//  NSDate+Component.m
//  LZBCalendar
//
//  Created by zibin on 16/11/19.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "NSDate+Component.h"

@implementation NSDate (Component)

- (NSInteger)getDateWithDay:(NSDate *)date
{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    return [components day];
}
- (NSInteger)getDateWithMonth:(NSDate *)date
{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    return [components month];
}
- (NSInteger)getDateWithYear:(NSDate *)date
{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    return [components year];
}
@end
