//
//  NCAnimationViewItem.m
//  CXAnimationButton
//
//  Created by lanou3g on 16/4/14.
//  Copyright © 2016年 com.lcarpark.zfw. All rights reserved.
//

#import "NCAnimationViewItem.h"

static inline CGRect ScaleRect(CGRect rect, float n){
    return CGRectMake((rect.size.width - rect.size.width * n) / 2, (rect.size.height - rect.size.height * n) / 2, rect.size.width * n, rect.size.height * n);
}

@implementation NCAnimationViewItem

- (instancetype)initWithImage:(UIImage *)image highlightedImage:(UIImage *)highlightedImage ContentImage:(UIImage *)contentImage highlightedContentImage:(UIImage *)highlightedContentImage{
    if (self = [super init]) {
        self.image = image;
        self.highlightedImage = highlightedImage;
        self.userInteractionEnabled = YES;
        _contentImageView = [[UIImageView alloc] initWithImage:contentImage];
        _contentImageView.highlightedImage = highlightedContentImage;
        [self addSubview:_contentImageView];
    }
    return self;
}
+ (instancetype)itemWithImage:(UIImage *)image highlightedImage:(UIImage *)highlightedImage ContentImage:(UIImage *)contentImage highlightedContentImage:(UIImage *)highlightedContentImage{
    return [[self alloc] initWithImage:image highlightedImage:highlightedImage ContentImage:contentImage highlightedContentImage:highlightedContentImage];
}

#pragma mark - UIView's methods
- (void)layoutSubviews{
    [super layoutSubviews];
    self.bounds = CGRectMake(0, 0, self.image.size.width, self.image.size.height);
    
    float width = _contentImageView.image.size.width;
    float height = _contentImageView.image.size.height;
    _contentImageView.frame = CGRectMake(self.bounds.size.width / 2 - width / 2, self.bounds.size.height / 2 - height / 2, width, height);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.highlighted = YES;
    if ([_delegate respondsToSelector:@selector(itemTouchesBegan:)]) {
        [_delegate itemTouchesBegan:self];
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGPoint location = [[touches anyObject] locationInView:self];
    if (!CGRectContainsPoint(ScaleRect(self.bounds, 2.0f), location)) {
        self.highlighted = NO;
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.highlighted = NO;
    CGPoint location = [[touches anyObject] locationInView:self];
    if (CGRectContainsPoint(ScaleRect(self.bounds, 2.0f), location)) {
        if ([_delegate respondsToSelector:@selector(itemTouchesEnd:)]) {
            [_delegate itemTouchesEnd:self];
        }
    }
}

#pragma mark - instance methods
- (void)setHighlighted:(BOOL)highlighted{
    [super setHighlighted:highlighted];
    [_contentImageView setHighlighted:highlighted];
}



@end
