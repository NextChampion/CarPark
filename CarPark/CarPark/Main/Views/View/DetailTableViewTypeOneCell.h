//
//  DetailTableViewTypeOneCell.h
//  CarPark
//
//  Created by lanou3g on 16/4/27.
//  Copyright © 2016年 com.lcarpark.zfw. All rights reserved.
//

#import "BaseTableViewCell.h"

@class DetailModel;

@interface DetailTableViewTypeOneCell : BaseTableViewCell

@property (nonatomic, strong) UILabel *content;

- (void)setDataWithModel:(DetailModel *)model;

@end
