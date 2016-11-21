//
//  NSDate+Component.h
//  LZBCalendar
//
//  Created by zibin on 16/11/19.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Component)

/**
  Get the  date of day
 @param date date
 @return day
 */
- (NSInteger)getDateWithDay:(NSDate *)date;

/**
 Get the  date of month
 @param date date
 @return month
 */
- (NSInteger)getDateWithMonth:(NSDate *)date;

/**
 Get the  date of year
 @param date date
 @return year
 */
- (NSInteger)getDateWithYear:(NSDate *)date;
@end
