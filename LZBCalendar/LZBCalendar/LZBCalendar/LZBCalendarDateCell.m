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
@property (nonatomic, assign) CGFloat dateLableHeight;
@property (nonatomic, assign) CGFloat descLabelHeiht;
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

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    if(self.dateLableHeight > 0)
    {
        self.dateLabel.center = CGPointMake(width*0.5, height*0.5 - self.dateLableHeight*0.5-self.style.dateTitleDescOffset.vertical * 0.5);
        self.dateLabel.bounds = CGRectMake(0, 0, width, self.dateLableHeight);
    }
    if(self.descLabelHeiht > 0)
    {
       self.descLabel.center = CGPointMake(width*0.5, height*0.5 + self.descLabelHeiht*0.5+self.style.dateTitleDescOffset.vertical * 0.5);
       self.descLabel.bounds = CGRectMake(0, 0, width, self.descLabelHeiht);
    }
    
}

#pragma mark- API
- (void)setStyle:(LZBCalendarAppearStyle *)style
{
    _style = style;
    self.dateLableHeight = [@"1" sizeWithAttributes:@{NSFontAttributeName : style.dateTittleFont}].height;
    self.descLabelHeiht = [@"1" sizeWithAttributes:@{NSFontAttributeName : style.dateDescFont}].height;
    self.dateLabel.font = style.dateTittleFont;
    self.dateLabel.textColor = self.isSelected?style.dateTittleSelectColor:style.dateTittleUnselectColor;
    self.descLabel.font = style.dateDescFont;
    self.descLabel.textColor = self.isSelected?style.dateDescSelectColor:style.dateDescUnselectColor;
    
}

- (void)reloadCellDataWithTitle:(NSString *)title
{
    self.dateLabel.text = title.length > 0 ? title : @"";
}

- (void)reloadCellDataWithSubtitle:(NSString *)subtitle
{
    self.descLabel.text = subtitle.length > 0 ? subtitle : @"";
}

- (void)reloadCellDataWithTitle :(NSString *)title  subTitle:(NSString *)subtitle
{
    [self reloadCellDataWithTitle:title];
    [self reloadCellDataWithSubtitle:subtitle];
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
