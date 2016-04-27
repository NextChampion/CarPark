//
//  TypeFiveCell.h
//  CarPark
//
//  Created by lanou3g on 16/4/26.
//  Copyright © 2016年 com.lcarpark.zfw. All rights reserved.
//

#import "BaseTableViewCell.h"
@class DataModel;
@interface TypeFiveCell : BaseTableViewCell

@property (strong, nonatomic) UIImageView *picCoverImage;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *srcLabel;
@property (strong, nonatomic) UILabel *commentLabel;
@property (strong, nonatomic) UIImageView *commentImage;

- (void)setDataWithModel:(DataModel *)model;

@end
