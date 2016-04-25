//
//  NewsView.m
//  WhenTheNews
//
//  Created by lanou3g on 16/4/15.
//  Copyright © 2016年 HCC. All rights reserved.
//

#import "AutoView.h"
#import "UIImageView+WebCache.h"
#import "NSString+height.h"
#define kAutoViewWidth _imageScrollView.bounds.size.width
#define kAutoViewHeight _imageScrollView.bounds.size.height
@interface AutoView ()
{
//循环滚动的三个视图
    UIImageView *_leftImageView;
    UIImageView *_centerImageView;
    UIImageView *_rightImageView;
    /**
     *  循环滚动的周期时间
     用于确认 滚动是由于 认为操作 还是由 计时器时间到了系统滚动的。 YES则为系统滚动，NO则为人为滚动（ps:在app中人为滚动一个view后，这个计时器要归0并且重新计时）
     */
    BOOL _isTimeUp;
    //为每一个图片添加一个广告语（可选）
    UILabel *_leftImageLabel;
    UILabel *_rightImageLabel;
}

@property (nonatomic ,retain) UILabel *imageLabel; // 图片页数
@property (nonatomic ,retain) UILabel *titleLabel; //标题

@property (nonatomic, retain, readonly) UIImageView *leftImageView;
@property (nonatomic, retain, readonly) UIImageView *centerImageView;
@property (nonatomic, retain, readonly) UIImageView *rightImageView;

@end

@implementation AutoView
@synthesize centerImageIndex;
@synthesize rightImageIndex;
@synthesize leftImageIndex;
@synthesize moveTimer;

#pragma mark --- 自由指定image所占的frame
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        //默认滚动2.0s
        _imageMoveTime = 2.0;
        _imageScrollView = [[UIScrollView alloc]initWithFrame:self.bounds];
        _imageScrollView.bounces = NO;
        _imageScrollView.showsHorizontalScrollIndicator = NO;
        _imageScrollView.showsVerticalScrollIndicator = NO;
        _imageScrollView.pagingEnabled = YES;
        _imageScrollView.contentOffset = CGPointMake(kAutoViewWidth, 0);
        _imageScrollView.contentSize = CGSizeMake(kAutoViewWidth * 3, kAutoViewHeight);
        _imageScrollView.delegate = self;
        
        //该句是否执行会影响pageControl 的位置如果该应用上面有导航栏，就是用该局，否则注释掉即可
        _imageScrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        
        _leftImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kAutoViewWidth, kAutoViewHeight)];
        [_imageScrollView addSubview:_leftImageView];
        _leftImageView.contentMode = UIViewContentModeScaleAspectFit;
        
        _centerImageView = [[UIImageView alloc]initWithFrame:CGRectMake(kAutoViewWidth, 0, kAutoViewWidth, kAutoViewHeight)];
        _centerImageView.userInteractionEnabled = YES;
        [_centerImageView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)]];
        [_imageScrollView addSubview:_centerImageView];
        _centerImageView.contentMode = UIViewContentModeScaleAspectFit;
        
        _rightImageView = [[UIImageView alloc]initWithFrame:CGRectMake(kAutoViewWidth * 2, 0, kAutoViewWidth, kAutoViewHeight)];
        [_imageScrollView addSubview:_rightImageView];
        _rightImageView.contentMode = UIViewContentModeScaleAspectFit;
        
        //_imageScrollView.backgroundColor = [UIColor whiteColor];
        _isNeedCycleRoll = YES;
        [self addSubview:_imageScrollView];
        
        self.imageLabel = [self labelForFrame:CGRectMake(kAutoViewWidth - 50 , kAutoViewHeight - 130, 50, 21) font:12];
        self.titleLabel = [self labelForFrame:CGRectMake(8, kAutoViewHeight - 130, kAutoViewWidth - 60, 21) font:12];
       
    }
    return self;
}

//这个方法会在子视图添加到父视图或者离开父视图时调用
- (void)willMoveToSuperview:(UIView *)newSuperview{
    //解决当父视图释放时，当前视图因为被Timer强引用而不能释放的问题
    if (!newSuperview){
        [self.moveTimer invalidate];
        self.moveTimer = nil;
    } else {
        [self setUpTime];
    }
}

- (void)setUpTime{
    if (_isNeedCycleRoll){
        moveTimer = [NSTimer scheduledTimerWithTimeInterval:_imageMoveTime target:self selector:@selector(animateMoveImage:) userInfo:nil repeats:YES];
        _isTimeUp = NO;
    }
}

- (void)setIsNeedCycleRoll:(BOOL)isNeedCycleRoll{
    _isNeedCycleRoll = isNeedCycleRoll;
    if (!_isNeedCycleRoll) {
        [moveTimer invalidate];
        moveTimer = nil;
    }
}

+ (id)imageScrollViewWithFrame:(CGRect)frame imageLinkURL:(NSArray *)imageLinkURL pageControlShowStyle:(UIPageControlShowStyle)PageControlShowStyle{
    AutoView *autoView = [AutoView imageScrollViewWithFrame:frame imageLinkURL:imageLinkURL titleArr:nil placeHolderImageName:nil pageControlShowStyle:PageControlShowStyle];
    return autoView;
}

+ (id)imageScrollViewWithFrame:(CGRect)frame imageLinkURL:(NSArray *)imageLinkURL titleArr:(NSMutableArray *)titleArr placeHolderImageName:(NSString *)imageName pageControlShowStyle:(UIPageControlShowStyle)PageControlShowStyle{
    AutoView *autoView = [[AutoView alloc]initWithFrame:frame];
    autoView.placeHoldImage = [UIImage imageNamed:imageName];
    autoView.titleArr = [NSArray arrayWithArray:titleArr];
    [autoView setImageLinkURL:imageLinkURL];
    [autoView scrollViewDidScroll:autoView.imageScrollView];
    [autoView setPageControlShowStyle:PageControlShowStyle];
    return autoView;
}

#pragma mark --- 设置图片视图所使用的图片（名字）
- (void)setImageLinkURL:(NSArray *)imageLinkURL{
    _imageLinkURL = imageLinkURL;
    
    leftImageIndex = imageLinkURL.count - 1;
    centerImageIndex = 0;
    rightImageIndex = 1;
    
    [_leftImageView sd_setImageWithURL:[NSURL URLWithString:imageLinkURL[leftImageIndex]] placeholderImage:self.placeHoldImage];
    [_centerImageView sd_setImageWithURL:[NSURL URLWithString:imageLinkURL[centerImageIndex]] placeholderImage:self.placeHoldImage];
    [_rightImageView sd_setImageWithURL:[NSURL URLWithString:imageLinkURL[rightImageIndex]] placeholderImage:self.placeHoldImage];
}
     
#pragma mark --- 设置每个对应image对应的title
- (void)setImageTitleArray:(NSArray *)imageTitleArray withShowStyle:(ImageTitleShowStyle)imageTitleStyle{
    _imageTitleArray = imageTitleArray;
    if (imageTitleStyle == ImageTitleShowStyleNone) {
        return;
    }
    
    //文字背景图层
    UIView *titleBackground = [[UIView alloc] initWithFrame:CGRectMake(0, kAutoViewHeight - 30, kAutoViewWidth, 30)];
    titleBackground.backgroundColor = [UIColor blackColor];
    titleBackground.alpha = 0.3;
    [self addSubview:titleBackground];
    [self bringSubviewToFront:_pageControl];
    
    //图层上的标题label
    _centerImageLabel = [[UILabel alloc]init];
    _centerImageLabel.backgroundColor = [UIColor clearColor];
    _centerImageLabel.frame = CGRectMake(0, kAutoViewHeight - 30, kAutoViewWidth - 20, 30);
    _centerImageLabel.textColor = [UIColor lightGrayColor];
    _centerImageLabel.font = [UIFont boldSystemFontOfSize:15];
    [self addSubview:_centerImageLabel];
    
    if (imageTitleStyle == ImageTitleShowStyleLeft) {
        _centerImageLabel.textAlignment = NSTextAlignmentLeft;
    } else if (imageTitleStyle == ImageTitleShowStyleCenter){
        _centerImageLabel.textAlignment = NSTextAlignmentCenter;
    } else {
        _centerImageLabel.textAlignment = NSTextAlignmentRight;
    }
    _centerImageLabel.text = _imageTitleArray[centerImageIndex];
}

#pragma mark --- 创建pageControl, 指定其显示样式
- (void)setPageControlShowStyle:(UIPageControlShowStyle)PageControlShowStyle{
    if (PageControlShowStyle == UIPageControlShowStyleNone) {
        return;
    }
    _pageControl = [[UIPageControl alloc]init];
    _pageControl.numberOfPages = _imageLinkURL.count;
    
    if (PageControlShowStyle == UIPageControlShowStyleLeft) {
        _pageControl.frame = CGRectMake(0, kAutoViewHeight - 20, 20 * _pageControl.numberOfPages, 20);
        
    } else if (PageControlShowStyle == UIPageControlShowStyleCenter){
        _pageControl.frame = CGRectMake(0, 0, 20 * _pageControl.numberOfPages, 20);
        _pageControl.center = CGPointMake(kAutoViewWidth / 2.0, kAutoViewHeight - 30);
    } else {
        _pageControl.frame = CGRectMake(kAutoViewWidth - 20 * _pageControl.numberOfPages, kAutoViewHeight - 40, 20 * _pageControl.numberOfPages, 20);
    }
    _pageControl.currentPage = 0;
    _pageControl.enabled = NO;
    [self addSubview:_pageControl];
}

#pragma mark --- 计时器到时，系统滚动图片
- (void)animateMoveImage:(NSTimer *)time{
    [_imageScrollView setContentOffset:CGPointMake(kAutoViewWidth * 2, 0) animated:YES];
    _isTimeUp = YES;
    
    [NSTimer scheduledTimerWithTimeInterval:0.4f target:self selector:@selector(scrollViewDidEndDecelerating:) userInfo:nil repeats:NO];
}

#pragma mark --- 图片停止时，调用该函数是使得滚动视图复用
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (_imageScrollView.contentOffset.x == 0) {
        centerImageIndex = centerImageIndex - 1;
        leftImageIndex = leftImageIndex - 1;
        rightImageIndex = rightImageIndex - 1;
        
        if (leftImageIndex == -1) {
            leftImageIndex = _imageLinkURL.count - 1;
        }
        if (centerImageIndex == -1) {
            centerImageIndex = _imageLinkURL.count - 1;
        }
        if (rightImageIndex == -1) {
            rightImageIndex = _imageLinkURL.count - 1;
        }
    } else if(_imageScrollView.contentOffset.x == kAutoViewWidth * 2){
        centerImageIndex = centerImageIndex + 1;
        leftImageIndex = leftImageIndex + 1;
        rightImageIndex = rightImageIndex + 1;
        
        if (leftImageIndex == _imageLinkURL.count) {
            leftImageIndex = 0;
        }
        if (centerImageIndex == _imageLinkURL.count) {
            centerImageIndex = 0;
        }
        if (rightImageIndex == _imageLinkURL.count) {
            rightImageIndex = 0;
        }
    } else {
        return;
    }
    [_leftImageView sd_setImageWithURL:[NSURL URLWithString:_imageLinkURL[leftImageIndex]] placeholderImage:self.placeHoldImage];
    [_centerImageView sd_setImageWithURL:[NSURL URLWithString:_imageLinkURL[centerImageIndex]] placeholderImage:self.placeHoldImage];
    [_rightImageView sd_setImageWithURL:[NSURL URLWithString:_imageLinkURL[rightImageIndex]] placeholderImage:self.placeHoldImage];
    
    _pageControl.currentPage = centerImageIndex;
    
    //有时候只有在右图片跳纤的时候才需要加载
    if (_imageTitleArray){
        if (centerImageIndex == _imageTitleArray.count - 1) {
            _centerImageLabel.text = _imageTitleArray[centerImageIndex];
        }
    }
    _imageScrollView.contentOffset = CGPointMake(kAutoViewWidth, 0);
    
    
    //手动控制图片滚动应该取消那个2.0s的计时器
    if (!_isTimeUp){
        [moveTimer setFireDate:[NSDate dateWithTimeIntervalSinceNow:_imageMoveTime]];
    }
    _isTimeUp = NO;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [moveTimer invalidate];
    moveTimer = nil;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self setUpTime];
}

// 当前显示的图片被点击
- (void)tap{
    if (_callBack) {
        _callBack(centerImageIndex, _imageLinkURL[centerImageIndex]);
    }
}

#pragma mark --  设置相册浏览模式下 标题和页数Label
- (UILabel *)labelForFrame:(CGRect)frame font:(CGFloat)font
{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.backgroundColor = [UIColor clearColor];
    
    [self addSubview:label];
    
    label.font = [UIFont systemFontOfSize:font];
    label.numberOfLines = 0;
    label.textColor = [UIColor whiteColor];
    
    return label;
}

#pragma mark --  图片页数 控制
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    int page = (int)centerImageIndex + 1;
    
    self.imageLabel.text = [NSString stringWithFormat:@"%d/%ld" , page, self.imageLinkURL.count];
    CGFloat height = [NSString heightForString:self.titleArr[page - 1] size:CGSizeMake(kAutoViewWidth- 60, 1000) font:12];
    self.titleLabel.frame = CGRectMake(8, kAutoViewHeight - 130, kAutoViewWidth - 60, height);
    self.titleLabel.text = self.titleArr[page - 1];
    
}



@end
