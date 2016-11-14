//
//  LZBCalendar.m
//  LZBCalendar
//
//  Created by zibin on 16/11/13.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LZBCalendar.h"
#import "LZBCalendarHeaderView.h"
#import "LZBCalendarDateCell.h"

#define limitation_Low  28
#define limitation_Medium  35
#define limitation_High  42

static NSString *LZBCalendarDateCellID = @"LZBCalendarDateCellID";

@interface LZBCalendar()<UICollectionViewDataSource>

@property (nonatomic, assign) CGFloat itemHeight;
@property (nonatomic, strong) LZBCalendarAppearStyle *style;
@property (nonatomic, strong) LZBCalendarHeaderView *headerView;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *collectFlowLayout;
@end

@implementation LZBCalendar
- (instancetype)initWithStyle:(LZBCalendarAppearStyle *)style
{
  if(self = [super init])
  {
      self.style = style;
      [self setupUI];
  }
    return self;
}

- (void)setupUI
{
    __weak typeof(self) weakSelf = self;
    [self addSubview:self.headerView];
    self.headerView.monthDate = self.style.today;
    [self addSubview:self.contentView];
    [self.contentView addSubview:self.collectionView];
    [self.collectionView registerClass:[LZBCalendarDateCell class] forCellWithReuseIdentifier:LZBCalendarDateCellID];
    
    //处理
    [self.headerView setPreviousMonthClick:^(NSDate *date) {
        weakSelf.style.today = date;
        [weakSelf setNeedsLayout];
        [weakSelf.collectionView reloadData];
    }];
    
    [self.headerView setNextMonthClick:^(NSDate *date) {
        weakSelf.style.today = date;
         [weakSelf setNeedsLayout];
        [weakSelf.collectionView reloadData];
    }];
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat width = self.bounds.size.width;
    self.headerView.frame = CGRectMake(0, 0, width, self.style.headerViewHeihgt);
    [self layoutCollectionView];
    
}

- (void)layoutCollectionView
{
    CGFloat itemWidth = self.bounds.size.width/self.style.weekDateDays.count;
    CGFloat itemHeight = itemWidth;
    if(self.style.isNeedCustomHeihgt && self.style.itemHeight > 0)
    {
        itemHeight = self.style.itemHeight;
    }
    else
    {
        itemHeight = itemWidth;
    }
    self.itemHeight = itemHeight;
    self.collectFlowLayout.itemSize = CGSizeMake(itemWidth, itemHeight);
    
    //collectinView高度
    NSInteger marginDays = [self firstDayInFirstWeekThisMonth:self.style.today];
    NSInteger itemCount = marginDays + [self totalDaysThisMonth:self.style.today];
    CGFloat collectionViewHeight = 0;
    if(itemCount <= limitation_Low)
        collectionViewHeight = limitation_Low/self.style.weekDateDays.count *self.itemHeight;
    else if(itemCount > limitation_Low && itemCount <=limitation_Medium)
        collectionViewHeight = limitation_Medium/self.style.weekDateDays.count *self.itemHeight;
    else
        collectionViewHeight = limitation_High/self.style.weekDateDays.count *self.itemHeight;
    self.collectionView.frame = CGRectMake(0, 0, self.bounds.size.width, collectionViewHeight);
    self.contentView.frame = CGRectMake(0, CGRectGetMaxY(self.headerView.frame), self.bounds.size.width, collectionViewHeight);
    [self.collectionView setCollectionViewLayout:self.collectFlowLayout];
}


#pragma mark - collectCell-dataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSInteger marginDays = [self firstDayInFirstWeekThisMonth:self.style.today];
    NSInteger itemCount = marginDays + [self totalDaysThisMonth:self.style.today];
    if(itemCount>=limitation_High) return 0;
    if(itemCount >limitation_Medium && itemCount<=limitation_High)
        return limitation_High;
    else if(itemCount >limitation_Low && itemCount <=limitation_Medium)
        return limitation_Medium;
    else
        return limitation_Low;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LZBCalendarDateCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:LZBCalendarDateCellID forIndexPath:indexPath];
    cell.style = self.style;
    NSInteger marginDays = [self firstDayInFirstWeekThisMonth:self.style.today];
    NSInteger daysThisMonth = [self totalDaysThisMonth:self.style.today];
    //空白cell
    if(indexPath.row < marginDays)
        [cell reloadCellDataWithTitle:@"" subTitle:@""];
    else if(indexPath.row > marginDays + daysThisMonth - 1)
        [cell reloadCellDataWithTitle:@"" subTitle:@""];
    else
    {
        NSInteger day = 0;
        day = indexPath.row - marginDays +1;
        NSDate *date = [self dateByday:day toDate:self.style.today];
        if([self titleForDate:date].length > 0)
             [cell reloadCellDataWithTitle:[self titleForDate:self.style.today]];
        else
            [cell reloadCellDataWithTitle:[NSString stringWithFormat:@"%ld",day]];
        
        if([self subtitleForDate:date].length > 0)
            [cell reloadCellDataWithSubtitle:[self titleForDate:self.style.today]];
        else
            [cell reloadCellDataWithSubtitle:@""];
        
    }

    
    return cell;
}



#pragma mark- private
- (NSInteger)totalDaysThisMonth:(NSDate *)date
{
    NSRange range = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    return range.length;
}

- (NSInteger)firstDayInFirstWeekThisMonth:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    [calendar setFirstWeekday:1];
    NSDateComponents *comp = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    comp.day = 1;
    NSDate *firstDayOfMonthDate = [calendar dateFromComponents:comp];
    NSUInteger firstWeekday = [calendar ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitWeekOfMonth forDate:firstDayOfMonthDate];
    return firstWeekday-1;
}

- (NSDate *)dateByday:(NSInteger)day toDate:(NSDate *)date
{
    if (!date) return nil;
     NSDateComponents *oldCompoents = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    NSDateComponents *newComponents = [[NSDateComponents alloc]init];
    newComponents.day = day;
    newComponents.year = oldCompoents.year;
    newComponents.month = oldCompoents.month;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd"];
    NSDate *d = [dateFormatter dateFromString:[NSString stringWithFormat:@"%ld-%ld-%ld",newComponents.year,newComponents.month,newComponents.day]];
    return d;
}

#pragma mark - DataSource

- (NSString *)titleForDate:(NSDate *)date
{
    if (_dataSource && [_dataSource respondsToSelector:@selector(calendar:titleForDate:)]) {
        return [_dataSource calendar:self titleForDate:date];
    }
    return nil;
}

- (NSString *)subtitleForDate:(NSDate *)date
{
    if (_dataSource && [_dataSource respondsToSelector:@selector(calendar:subtitleForDate:)]) {
        return [_dataSource calendar:self subtitleForDate:date];
    }
    return nil;
}



#pragma mark - lazy
- (LZBCalendarHeaderView *)headerView
{
  if(_headerView == nil)
  {
      _headerView = [[LZBCalendarHeaderView alloc]initWithType:LZBCalendarHeaderViewType_CenterDate style:self.style];
  }
    return _headerView;
}

- (UIView *)contentView
{
  if(_contentView == nil)
  {
      _contentView = [UIView new];
      _contentView.backgroundColor = [UIColor whiteColor];
  }
    return _contentView;
}
- (UICollectionView *)collectionView
{
  if(_collectionView == nil)
  {
      _collectionView = [[UICollectionView alloc]initWithFrame:self.contentView.bounds collectionViewLayout:self.collectFlowLayout];
      _collectionView.dataSource = self;
      _collectionView.backgroundColor = [UIColor whiteColor];
  }
    return _collectionView;
}

- (UICollectionViewFlowLayout *)collectFlowLayout
{
   if(_collectFlowLayout == nil)
   {
       _collectFlowLayout = [[UICollectionViewFlowLayout alloc]init];
       _collectFlowLayout.minimumLineSpacing = 0.0;
       _collectFlowLayout.minimumInteritemSpacing = 0.0;
       _collectFlowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
   }
    return _collectFlowLayout;
}

@end
