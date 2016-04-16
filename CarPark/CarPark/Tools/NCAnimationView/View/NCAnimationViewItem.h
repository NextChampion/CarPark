//
//  NCAnimationViewItem.h
//  CXAnimationButton
//
//  Created by lanou3g on 16/4/14.
//  Copyright © 2016年 com.lcarpark.zfw. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NCAnimationViewItem;
@protocol NCAnimationViewItemDelegate <NSObject>

- (void)itemTouchesBegan:(NCAnimationViewItem *)item;
- (void)itemTouchesEnd:(NCAnimationViewItem *)item;

@end



@interface NCAnimationViewItem : UIImageView

@property (nonatomic, strong) UIImageView *contentImageView;
@property (nonatomic, assign) CGPoint startPoint;
@property (nonatomic, assign) CGPoint endPoint;
@property (nonatomic, assign) CGPoint neighbouringPoint;
@property (nonatomic, assign) CGPoint farPoint;

@property (nonatomic, assign) id<NCAnimationViewItemDelegate> delegate;

- (instancetype)initWithImage:(UIImage *)image highlightedImage:(UIImage *)highlightedImage ContentImage:(UIImage *)contentImage highlightedContentImage:(UIImage *)highlightedContentImage;

+ (instancetype)itemWithImage:(UIImage *)image highlightedImage:(UIImage *)highlightedImage ContentImage:(UIImage *)contentImage highlightedContentImage:(UIImage *)highlightedContentImage;

@end
