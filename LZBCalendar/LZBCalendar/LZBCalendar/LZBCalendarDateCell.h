//
//  LZBCalendarDateCell.h
//  LZBCalendar
//
//  Created by zibin on 16/11/13.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LZBCalendarAppearStyle.h"

@interface LZBCalendarDateCell : UICollectionViewCell

@property (nonatomic, strong) LZBCalendarAppearStyle *style;

- (void)reloadCellDataWithTitle:(NSString *)title;
- (void)reloadCellDataWithSubtitle:(NSString *)subtitle;
- (void)reloadCellDataWithTitle :(NSString *)title  subTitle:(NSString *)subtitle;

//选中颜色
- (void)updateCellSelectBackgroundColor;
- (void)updateCellSelectTitleColor;
- (void)updateCellSelectSubtitleColor;
- (void)updateCellSelectCellColor;
- (void)updateCellSelectCellColorWithAnimation:(BOOL)animation;
@end
