//
//  TypeThreeCell.h
//  CarPark
//
//  Created by lanou3g on 16/4/21.
//  Copyright © 2016年 com.lcarpark.zfw. All rights reserved.
//

#import "BaseTableViewCell.h"

@class DataModel;

@interface TypeThreeCell : BaseTableViewCell

@property (strong, nonatomic) UIImageView *picCoverImageLeft; // 三种图中左边那一张
@property (strong, nonatomic) UIImageView *picCoverImageMid; // 三种图中中间那一张
@property (strong, nonatomic) UIImageView *picCoverImageRight; // 三种图中右边那一张
@property (strong, nonatomic) UILabel *titleLabel; // 标题
@property (strong, nonatomic) UILabel *srcLabel; // 来源
@property (strong, nonatomic) UILabel *commentLabel; // 点评数字
@property (strong, nonatomic) UIImageView *commentImage; // 点评图片

- (void)setDataWithModel:(DataModel *)model;
@end
