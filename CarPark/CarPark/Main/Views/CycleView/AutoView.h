//
//  NewsView.h
//  WhenTheNews
//
//  Created by lanou3g on 16/4/15.
//  Copyright © 2016年 HCC. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, UIPageControlShowStyle) {
    /**
     *  PageControl
     */
    UIPageControlShowStyleNone,
    UIPageControlShowStyleLeft,
    UIPageControlShowStyleCenter,
    UIPageControlShowStyleRight,
};

typedef NS_ENUM(NSUInteger, ImageTitleShowStyle) {
    /**
     *  轮播图每页标题
     */
    ImageTitleShowStyleNone,
    ImageTitleShowStyleLeft,
    ImageTitleShowStyleCenter,
    ImageTitleShowStyleRight,
};
@interface AutoView : UIView <UIScrollViewDelegate>
{
    UILabel *_centerImageLabel;
    CGFloat _imageMoveTime;
}

@property (nonatomic, assign) NSTimer *moveTimer;//这个计时器需要特殊处理，否则会造成内存泄露；
@property (nonatomic, retain, readonly) UIScrollView *imageScrollView;
@property (nonatomic, retain, readonly) UIPageControl * pageControl;
@property (nonatomic, retain, readonly) NSArray *imageLinkURL;
@property (nonatomic, retain) NSArray *titleArr;
@property (nonatomic, retain, readonly) NSArray *imageTitleArray;

@property (nonatomic, assign) UIPageControlShowStyle PageControlShowStyle;//这只page显示位置
@property (nonatomic, assign, readonly) ImageTitleShowStyle imageTitleStyle;//设置标题对应的位置

@property (nonatomic, strong) UIImage *placeHoldImage;//设置展位图片
@property (nonatomic, assign) BOOL isNeedCycleRoll;//是否需要定时循环滚动
@property (nonatomic, assign) CGFloat imageMoveTime;//图片移动计时器
@property (nonatomic, strong, readonly) UILabel *centerImageLabel;//在这里修改Label的一些属性
@property (nonatomic, strong) void(^callBack)(NSInteger index, NSString *imageURL);//给图片创建点击后的回调方法

/**
 *  设置每个图片下方的标题
 * @param imageTitleArray 标题数组
 * @param imageTitleStyle 标题显示风格
 */
- (void)setImageTitleArray:(NSArray *)imageTitleArray withShowStyle:(ImageTitleShowStyle)imageTitleStyle;
/**
 *  创建AutoView对象
 * @param frame 设置Frame
 * @param imageLinkURL 图片链接地址数组，数组的每一项均为字符串
 * @param PageControlShowStyle PageControl 显示位置
 * @param object 控件在哪个文件中
 * @return 广告视图
 */
+ (id)imageScrollViewWithFrame:(CGRect)frame imageLinkURL:(NSArray *)imageLinkURL pageControlShowStyle:(UIPageControlShowStyle)PageControlShowStyle;
+ (id)imageScrollViewWithFrame:(CGRect)frame imageLinkURL:(NSArray *)imageLinkURL titleArr:(NSMutableArray *)titleArr placeHolderImageName:(NSString *)imageName pageControlShowStyle:(UIPageControlShowStyle)PageControlShowStyle;

@property (nonatomic, assign) NSUInteger centerImageIndex;
@property (nonatomic, assign) NSUInteger leftImageIndex;
@property (nonatomic, assign) NSUInteger rightImageIndex;


@end
