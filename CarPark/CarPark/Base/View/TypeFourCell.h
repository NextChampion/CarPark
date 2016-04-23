//
//  TypeFourCell.h
//  CarPark
//
//  Created by lanou3g on 16/4/21.
//  Copyright © 2016年 com.lcarpark.zfw. All rights reserved.
//

#import "BaseTableViewCell.h"

@class DataModel;

@interface TypeFourCell : BaseTableViewCell

@property (strong, nonatomic) UIImageView *picCoverImage; // 大图
@property (nonatomic, strong) UIImageView *playButtonView; // 中间的大播放按钮
@property (strong, nonatomic) UILabel *titleLabel; // 标题
@property (strong, nonatomic) UILabel *srcLabel; // 来源
@property (strong, nonatomic) UILabel *commentLabel; // 点评数量
@property (strong, nonatomic) UIImageView *commentImage; // 点评图片
@property (nonatomic, strong) UIImageView *playView; // 播放的小视图
@property (nonatomic, strong) UILabel *playCountLabel; // 播放次数
@property (nonatomic, strong) UILabel *durationLabel; // 视频持续时间

- (void)setDataWithModel:(DataModel *)model;

@end
