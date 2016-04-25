//
//  ImportantDetailTypeOneCell.h
//  CarPark
//
//  Created by lanou3g on 16/4/22.
//  Copyright © 2016年 com.lcarpark.zfw. All rights reserved.
//

#import "BaseTableViewCell.h"
@class ImportDetailModel;

@interface ImportantDetailTypeOneCell : BaseTableViewCell
@property (nonatomic, strong) UILabel *content;

- (void)setDataWithModel:(ImportDetailModel *)model;

@end
