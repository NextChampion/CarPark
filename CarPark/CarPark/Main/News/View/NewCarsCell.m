//
//  NewCarsCell.m
//  CarPark
//
//  Created by lanou3g on 16/4/16.
//  Copyright © 2016年 com.lcarpark.zfw. All rights reserved.
//

#import "NewCarsCell.h"
#import "NewCarsModel.h"
#import "UIImageView+WebCache.h"

@implementation NewCarsCell


- (void)setDataWithModel:(NewCarsModel *)model{
    self.titleLabel.text = model.title;
    self.commentLabel.text = [NSString stringWithFormat:@"%@",model.commentCount];
    UIImage *placeImg = [UIImage imageNamed:@"downloads.png"];
    [self.carImageView sd_setImageWithURL:[NSURL URLWithString:model.picCover] placeholderImage:placeImg];
    NSLog(@"%@",model.picCover);
}


@end
