# LZBCalendar
自定义日历控件

#前言
日历控件在一些旅游、教育、约车、学习类APP中经常被使用到，但是往往系统的NSCalendar控件都是不能满足我们项目的需要的，所以我们就会想“会不会有什么第三方日历控件能满足我们的需求”，好不容易找到一个第三方了，但是接下来我们又头疼了，第三方可能会有以下几个问题：
1、第三方日历控件这么多，我们应该用哪个？
2、第三方控件一般都集成了很多功能，但是我只是用其中一个小小的功能，就要集成他这么多文件？
3、要是第三方控件遇到版本更新，我们还必须更新，如果有什么bug，那就更加得不偿失了，等等缺点？

因此，我建议大家对于自己项目所用的日历控件，最好自定义一个匹配自己的项目，那么，怎么自定义呢？

#怎样自定义一个日历控件
##一、整体结构分析
常规日历控件包括三个部分：
1.年月份的选择 （下图头部）
2.星期几 （中间头部）
3.日期 （底部日期）

##二、分析日历应该怎么做
1、头部比较简单，就是点击按钮切换月份，获取年月就可以（一般是获取当前年和当前月）

- (NSDateComponents *)getDateComponentsFromDate:(NSDate *)date
{
NSDateComponents *component = [[NSCalendar currentCalendar] components:
(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
return component;
}
2、星期的样式是固定的，这个可以自己设置一个数组，保存日期的风格可以是中文@[@"日",@"一",@"二",@"三",@"四",@"五",@"六"]，也可以是English

3、日期控件采用UICollectionView，但是必须要解决几个问题：
A、要采用多少个UICollectionViewCell，不同个数的UICollectionViewCell将决定UICollectionView的高度？

解决：如果知道一个月有多少天，就知道最少需要多少个UICollectionViewCell。

求出date的这个月有多少天
- (NSInteger)totalDaysThisMonth:(NSDate *)date
{
NSRange range = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
return range.length;
}
还要知道这个月的第1天是星期几，才能知道前面应该空几个UICollectionViewCell
求出这个月的第1天使星期几，前面空几个cell

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
求出前面空几个cell,可以用极限法知道，cell总共可能有多少个

#define limitation_Low  28
#define limitation_Medium  35
#define limitation_High  42
B、确定了cell的高度,可以计算出UICollectionView的高度,把高度回调用出去

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

详细解说请参考简书地址：

#自定义日历控件 (http://www.jianshu.com/p/308d30c784ad)
