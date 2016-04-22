//
//  RecommandTableCell.h
//  CarPark
//
//  Created by lanou3g on 16/4/18.
//  Copyright © 2016年 com.lcarpark.zfw. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface RecommandTableCell : BaseTableViewCell
/** 标题*/
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
/** 评论数量*/
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;
/** 车信息来源*/
@property (weak, nonatomic) IBOutlet UILabel *scrLabel;
/** 图片*/
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;

@end
