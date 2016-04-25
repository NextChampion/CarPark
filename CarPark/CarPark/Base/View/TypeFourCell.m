//
//  TypeFourCell.m
//  CarPark
//
//  Created by lanou3g on 16/4/21.
//  Copyright © 2016年 com.lcarpark.zfw. All rights reserved.
//

#import "TypeFourCell.h"
#import "DataModel.h"

@implementation TypeFourCell

- (UILabel *)srcLabel{
    if (!_srcLabel) {
        _srcLabel = [[UILabel alloc] init];
        _srcLabel.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:_srcLabel];
        __weak typeof(self) weakSelf = self;
        [_srcLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.contentView.mas_left).offset(8);
            make.bottom.equalTo(weakSelf.contentView.mas_bottom).offset(-8);
            make.height.equalTo(@15);
        }];
    }
    return _srcLabel;
}

- (UILabel *)playCountLabel{
    if (!_playCountLabel) {
        _playCountLabel.font = [UIFont systemFontOfSize:12];
        _playCountLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_playCountLabel];
        __weak typeof(self) weakSelf = self;
        [_playCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(weakSelf.contentView.mas_right).offset(-8);
            make.bottom.equalTo(weakSelf.contentView.mas_bottom).offset(-8);
            make.width.equalTo(@60);
            make.height.equalTo(@15);
        }];
    }
    return _playCountLabel;
}

- (UIImageView *)playView{
    if (!_playView) {
        _playView = [[UIImageView alloc] init];
        [self.contentView addSubview:_playView];
        __weak typeof(self) weakSelf = self;
        [_playView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(weakSelf.playCountLabel.mas_left);
            make.bottom.equalTo(weakSelf.contentView.mas_bottom).offset(-8);
            make.width.equalTo(@15);
            make.height.equalTo(@15);
        }];
    }
    return _playView;
}

- (UILabel *)commentLabel{
    if (!_commentLabel) {
        _commentLabel = [[UILabel alloc] init];
        [_commentLabel sizeToFit]; // 宽度自适应
        [self.contentView addSubview:_commentLabel];
        __weak typeof(self) weakSelf = self;
        [_commentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(weakSelf.playView.mas_left);
            make.bottom.equalTo(weakSelf.contentView.mas_bottom).offset(-8);
            make.width.equalTo(@60);
            make.height.equalTo(@15);
        }];
    }
    return _commentLabel;
}

- (UIImageView *)commentImage{
    if (!_commentImage) {
        _commentImage = [[UIImageView alloc] init];
        [self.contentView addSubview:_commentImage];
        __weak typeof(self) weakSelf = self;
        [_commentImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(weakSelf.commentLabel.mas_left);
            make.bottom.equalTo(weakSelf.contentView.mas_bottom).offset(-8);
            make.width.equalTo(@15);
            make.height.equalTo(@15);
        }];
    }
    return _commentImage;
}

- (UIImageView *)picCoverImage{
    if (!_picCoverImage) {
        _picCoverImage = [[UIImageView alloc] init];
        [self.contentView addSubview:_picCoverImage];
        __weak typeof(self) weakSelf = self;
        [_picCoverImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.contentView.mas_left);
            make.right.equalTo(weakSelf.contentView.mas_right);
            make.top.equalTo(weakSelf.contentView.mas_top).offset(8);
            make.bottom.equalTo(weakSelf.commentLabel.mas_top).offset(-8);
        }];
    }
    return _picCoverImage;
}

- (UILabel *)durationLabel{
    if (!_durationLabel) {
        _durationLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_durationLabel];
        __weak typeof(self) weakSelf = self;
        [_durationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(weakSelf.picCoverImage.mas_right);
            make.bottom.equalTo(weakSelf.picCoverImage.mas_bottom);
            make.width.equalTo(@60);
            make.height.equalTo(@15);
        }];
    }
    return _durationLabel;
}

- (UIImageView *)playButtonView{
    if (!_playButtonView) {
        _playButtonView = [[UIImageView alloc] init];
        [self.picCoverImage addSubview:_playButtonView];
        __weak typeof(self) weakSelf = self;
        [_playButtonView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(weakSelf.picCoverImage.center);
            make.width.equalTo(@40);
            make.height.equalTo(@40);
        }];
    }
    return _playButtonView;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        [self.picCoverImage addSubview:_titleLabel];
        __weak typeof(self) weakSelf = self;
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.picCoverImage.mas_left);
            make.right.equalTo(weakSelf.picCoverImage.mas_right);
            make.top.equalTo(weakSelf.picCoverImage.mas_top);
            make.height.equalTo(@21);
        }];
    }
    return _titleLabel;
}

- (void)setDataWithModel:(DataModel *)model{
    self.titleLabel.text = model.title;
    self.commentLabel.text = [NSString stringWithFormat:@"%ld",model.commentCount];
    [self.picCoverImage sd_setImageWithURL:[NSURL URLWithString:model.picCover]];
    self.durationLabel.text = model.duration;
    self.srcLabel.text = model.nickName;
    self.playCountLabel.text = [NSString stringWithFormat:@"%ld万",model.totalvisit/10000];
}

@end
