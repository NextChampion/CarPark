//
//  NewCarsCell.m
//  CarPark
//
//  Created by lanou3g on 16/4/16.
//  Copyright © 2016年 com.lcarpark.zfw. All rights reserved.
//

#import "NewCarsCell.h"
#import "NewCarsModel.h"

@implementation NewCarsCell


- (void)setDataWithModel:(NewCarsModel *)model{
    self.titleLabel.text = model.title;
    self.commentLabel.text = [NSString stringWithFormat:@"%@",model.commentCount];
}


@end
