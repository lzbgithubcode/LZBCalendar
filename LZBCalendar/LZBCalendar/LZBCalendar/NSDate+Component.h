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
 @return day
 */
- (NSInteger)getDateWithDay;

/**
 Get the  date of month
 @return month
 */
- (NSInteger)getDateWithMonth;

/**
 Get the  date of year
 @return year
 */
- (NSInteger)getDateWithYear;
@end
