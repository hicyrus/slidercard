//
//  ViewController.m
//  slidercard
//
//  Created by cy on 16/12/9.
//  Copyright © 2016年 hicyrus. All rights reserved.
//

#import "ViewController.h"
#import "ScrollCardView.h"


#define UISCREENHEIGHT  self.view.bounds.size.height
#define UISCREENWIDTH  self.view.bounds.size.width

@interface ViewController ()<UIGestureRecognizerDelegate>
@property ScrollCardView *scrollView;
@property NSMutableArray *imageArr;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _imageArr = [[NSMutableArray alloc] initWithCapacity:0];
    [_imageArr addObject:@"a.jpg"];
    [_imageArr addObject:@"b.jpg"];
    [_imageArr addObject:@"c.jpg"];


    [self createScrollCardView:_imageArr];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)createScrollCardView:(NSMutableArray *)imgArr
{
    _scrollView = [[ScrollCardView alloc]initWithFrame:CGRectMake(0,64, UISCREENWIDTH, 150)];
    //如果滚动视图的父视图由导航控制器控制,必须要设置该属性(ps,猜测这是为了正常显示,导航控制器内部设置了UIEdgeInsetsMake(64, 0, 0, 0))
    _scrollView.contentInset=UIEdgeInsetsMake(-64, 0, 0, 0);
    _scrollView.imageNameArray = imgArr;
    _scrollView.PageControlShowStyle = UIPageControlShowStyleRight;
    _scrollView.pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    
    //_scrollView.pageControl.currentPageIndicatorTintColor = [UIColor purpleColor];
    _scrollView.pageControl.currentPageIndicatorTintColor = [UIColor grayColor];
    [self.view addSubview:_scrollView];
    
    UITapGestureRecognizer *sigleTapRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickBackView)];
    
    sigleTapRecognizer.delegate=self;
    sigleTapRecognizer.numberOfTapsRequired = 1;
    
    [_scrollView addGestureRecognizer:sigleTapRecognizer];
    
    
    
    
}


-(void)clickBackView {
    NSLog(@"点了一下背景");
    
    NSUInteger index = [ScrollCardView getCurImageIndex];
    NSLog(@"图片索引 %lu",(unsigned long)index);
    
    
}






@end
