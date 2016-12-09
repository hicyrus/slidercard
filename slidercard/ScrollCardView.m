//
//  ScrollCardView.m
//  slidercard
//
//  Created by cy on 16/12/9.
//  Copyright © 2016年 hicyrus. All rights reserved.
//

#import "ScrollCardView.h"

#define UISCREENWIDTH self.bounds.size.width//slidercard的宽度
#define UISCREENHEIGHT  self.bounds.size.height//slidercard的高度
#define HIGHT self.bounds.origin.y

static CGFloat const timeInterval=3.0;//轮播间隔
static NSUInteger currentImage = 0;//记录中间图片的下标,开始总是为0

@interface  ScrollCardView()
{
    //循环滚动的三个视图
    UIImageView * _leftImageView;
    UIImageView * _centerImageView;
    UIImageView * _rightImageView;
    //循环滚动的周期时间
    NSTimer * _moveTime;
    BOOL _isTimeUp;
}
@property (retain,nonatomic,readonly) UIImageView * leftImageView;
@property (retain,nonatomic,readonly) UIImageView * centerImageView;
@property (retain,nonatomic,readonly) UIImageView * rightImageView;
@end



@implementation ScrollCardView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        self.bounces = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.pagingEnabled = YES;
        self.contentOffset = CGPointMake(UISCREENWIDTH, 0);
        self.contentSize = CGSizeMake(UISCREENWIDTH * 3, UISCREENHEIGHT);
        self.delegate = self;
        
        _leftImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, UISCREENWIDTH, UISCREENHEIGHT)];
        [self addSubview:_leftImageView];
        _centerImageView = [[UIImageView alloc]initWithFrame:CGRectMake(UISCREENWIDTH, 0, UISCREENWIDTH, UISCREENHEIGHT)];
        [self addSubview:_centerImageView];
        _rightImageView = [[UIImageView alloc]initWithFrame:CGRectMake(UISCREENWIDTH*2, 0, UISCREENWIDTH, UISCREENHEIGHT)];
        [self addSubview:_rightImageView];
        
        _moveTime = [NSTimer scheduledTimerWithTimeInterval:timeInterval target:self selector:@selector(animalMoveImage) userInfo:nil repeats:YES];
        _isTimeUp = NO;
        
        
        
        
    }
    return self;
}

//设置图片
- (void)setImageNameArray:(NSMutableArray *)imageNameArray
{
    _imageNameArray = imageNameArray;
    _leftImageView.image = [UIImage imageNamed:_imageNameArray[0]];
    _centerImageView.image = [UIImage imageNamed:_imageNameArray[1]];
    _rightImageView.image = [UIImage imageNamed:_imageNameArray[2]];
    
}

#pragma mark - 创建pageControl,指定其显示样式
- (void)setPageControlShowStyle:(UIPageControlShowStyle)PageControlShowStyle
{
    if (PageControlShowStyle == UIPageControlShowStyleNone) {
        return;
    }
    _pageControl = [[UIPageControl alloc]init];
    _pageControl.numberOfPages = _imageNameArray.count;
    
    if (PageControlShowStyle == UIPageControlShowStyleLeft)
    {
        _pageControl.frame = CGRectMake(10, HIGHT+UISCREENHEIGHT - 20, 20*_pageControl.numberOfPages, 20);
    }
    else if (PageControlShowStyle == UIPageControlShowStyleCenter)
    {
        _pageControl.frame = CGRectMake(0, 0, 20*_pageControl.numberOfPages, 20);
        _pageControl.center = CGPointMake(UISCREENWIDTH/2.0, HIGHT+UISCREENHEIGHT - 10);
    }
    else
    {
        _pageControl.frame = CGRectMake( UISCREENWIDTH - 20*_pageControl.numberOfPages, HIGHT+UISCREENHEIGHT - 20, 20*_pageControl.numberOfPages, 20);
    }
    _pageControl.currentPage = 0;
    
    _pageControl.enabled = NO;
    
    [self performSelector:@selector(addPageControl) withObject:nil afterDelay:0.1f];
}


//
- (void)addPageControl
{
    [[self superview] addSubview:_pageControl];
}

#pragma mark - 计时器到时,系统滚动图片
- (void)animalMoveImage
{
    
    [self setContentOffset:CGPointMake(UISCREENWIDTH * 2, 0) animated:YES];
    _isTimeUp = YES;
    [NSTimer scheduledTimerWithTimeInterval:0.4f target:self selector:@selector(scrollViewDidEndDecelerating:) userInfo:nil repeats:NO];
}

#pragma mark - 图片停止时,调用该函数使得滚动视图复用
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (self.contentOffset.x == 0)
    {
        currentImage = (currentImage-1)%_imageNameArray.count;
        _pageControl.currentPage = (_pageControl.currentPage - 1)%_imageNameArray.count;
    }
    else if(self.contentOffset.x == UISCREENWIDTH * 2)
    {
        
        currentImage = (currentImage+1)%_imageNameArray.count;
        _pageControl.currentPage = (_pageControl.currentPage + 1)%_imageNameArray.count;
    }
    else
    {
        return;
    }
    
    _leftImageView.image = [UIImage imageNamed:_imageNameArray[(currentImage-1)%_imageNameArray.count]];
    
     _centerImageView.image = [UIImage imageNamed:_imageNameArray[currentImage%_imageNameArray.count]];
    
     _rightImageView.image = [UIImage imageNamed:_imageNameArray[(currentImage+1)%_imageNameArray.count]];
     

    self.contentOffset = CGPointMake(UISCREENWIDTH, 0);
    
    //手动控制图片滚动应该取消那个三秒的计时器
    if (!_isTimeUp) {
        [_moveTime setFireDate:[NSDate dateWithTimeIntervalSinceNow:timeInterval]];
    }
    _isTimeUp = NO;
}







//获取当前图片id
+(NSUInteger)getCurImageIndex {
    return currentImage;
}


@end
