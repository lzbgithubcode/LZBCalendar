//
//  LZBCalendarDateCell.m
//  LZBCalendar
//
//  Created by zibin on 16/11/13.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LZBCalendarDateCell.h"

@interface LZBCalendarDateCell()

@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UILabel *descLabel;
@end

@implementation LZBCalendarDateCell
- (instancetype)initWithFrame:(CGRect)frame
{
  if(self = [super initWithFrame:frame])
  {
      [self.contentView addSubview:self.dateLabel];
      [self.contentView addSubview:self.descLabel];
  }
    return self;
}




#pragma mark - lazy
- (UILabel *)dateLabel
{
  if(_dateLabel == nil)
  {
      _dateLabel = [UILabel new];
      _dateLabel.textAlignment = NSTextAlignmentCenter;
  }
    return _dateLabel;
}

- (UILabel *)descLabel
{
  if(_descLabel == nil)
  {
      _descLabel = [UILabel new];
      _descLabel.textAlignment = NSTextAlignmentCenter;
  }
    return _descLabel;
}
@end
