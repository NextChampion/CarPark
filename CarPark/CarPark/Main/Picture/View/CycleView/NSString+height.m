//
//  NSString+height.m
//  WhenTheNews
//
//  Created by lanou3g on 16/4/21.
//  Copyright © 2016年 HCC. All rights reserved.
//

#import "NSString+height.h"

@implementation NSString (height)

+ (CGFloat)heightForString:(NSString *)string size:(CGSize)size font:(CGFloat)font
{
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:font]};
    CGRect rect = [string boundingRectWithSize:size options:(NSStringDrawingUsesLineFragmentOrigin) attributes:dic context:nil];
    return rect.size.height;
}

@end
