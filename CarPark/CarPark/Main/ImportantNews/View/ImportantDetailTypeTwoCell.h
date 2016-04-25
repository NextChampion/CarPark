//
//  ImportantDetailTypeTwoCell.h
//  CarPark
//
//  Created by lanou3g on 16/4/22.
//  Copyright © 2016年 com.lcarpark.zfw. All rights reserved.
//

#import "BaseTableViewCell.h"
@class ImportDetailModel;

@interface ImportantDetailTypeTwoCell : BaseTableViewCell
@property (nonatomic, strong) UIImageView *content;
@property (nonatomic, strong) NSArray *style;

- (void)setDataWithModel:(ImportDetailModel *)model;
@end
