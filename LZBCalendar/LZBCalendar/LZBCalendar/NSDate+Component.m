//
//  NSDate+Component.m
//  LZBCalendar
//
//  Created by zibin on 16/11/19.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "NSDate+Component.h"

@implementation NSDate (Component)

- (NSInteger)getDateWithDay
{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:self];
    return [components day];
}
- (NSInteger)getDateWithMonth
{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:self];
    return [components month];
}
- (NSInteger)getDateWithYear
{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:self];
    return [components year];
}
@end
