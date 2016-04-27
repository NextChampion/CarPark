//
//  MyCell.h
//  视频2
//
//  Created by lanou3g on 15/6/8.
//  Copyright (c) 2015年 my. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DataModel;
@interface MediaCell : UITableViewCell
@property (strong, nonatomic) UIImageView *picCoverImage; // 大图
@property (nonatomic, strong) UIButton *playButton; // 中间的大播放按钮
@property (strong, nonatomic) UILabel *titleLabel; // 标题
@property (strong, nonatomic) UILabel *srcLabel; // 来源
@property (strong, nonatomic) UILabel *commentLabel; // 点评数量
@property (strong, nonatomic) UIImageView *commentImage; // 点评图片
@property (nonatomic, strong) UIImageView *playView; // 播放的小视图
@property (nonatomic, strong) UILabel *playCountLabel; // 播放次数
@property (nonatomic, strong) UILabel *durationLabel; // 视频持续时间

//@property (nonatomic, strong) UIButton *btn;// 控制播放

- (void)setDataWithModel:(DataModel *)model;
@end
