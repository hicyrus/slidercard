//
//  ScrollCardView.h
//  slidercard
//
//  Created by cy on 16/12/9.
//  Copyright © 2016年 hicyrus. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger,UIPageControlShowStyle)
{
    UIPageControlShowStyleNone,
    UIPageControlShowStyleLeft,
    UIPageControlShowStyleCenter,
    UIPageControlShowStyleRight,
};

typedef NS_ENUM(NSUInteger,TitleShowStyle)
{
    TitleShowStyleNone,
    TitleShowStyleLeft,
    TitleShowStyleCenter,
    TitleShowStyleRight,
};

@interface ScrollCardView : UIScrollView<UIScrollViewDelegate>
@property (retain,nonatomic,readonly) UIPageControl *pageControl;
@property (retain,nonatomic,readwrite) NSMutableArray *imageNameArray;
@property (retain,nonatomic,readonly)  NSArray * TitleArray;
@property (assign,nonatomic,readwrite) UIPageControlShowStyle  PageControlShowStyle;
@property (assign,nonatomic,readonly) TitleShowStyle  TitleStyle;
+(NSUInteger)getCurImageIndex;
@end
