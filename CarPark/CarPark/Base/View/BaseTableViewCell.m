//
//  BaseTableViewCell.m
//  CarPark
//
//  Created by lanou3g on 16/4/13.
//  Copyright © 2016年 com.lcarpark.zfw. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "BaseModel.h"

@implementation BaseTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setupView{
    
}


// 通过model对象设置cell上的数据
- (void)setDataWithModel:(BaseModel *)model{
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
