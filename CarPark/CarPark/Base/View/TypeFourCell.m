//
//  TypeFourCell.m
//  CarPark
//
//  Created by lanou3g on 16/4/21.
//  Copyright © 2016年 com.lcarpark.zfw. All rights reserved.
//

#import "TypeFourCell.h"
#import "DataModel.h"

@interface TypeFourCell ()
@end


@implementation TypeFourCell

- (UILabel *)srcLabel{
    if (!_srcLabel) {
        _srcLabel = [[UILabel alloc] init];
        [_srcLabel setTextColor:[UIColor lightGrayColor]];
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
        _playCountLabel = [[UILabel alloc] init];
        _playCountLabel.font = [UIFont systemFontOfSize:12];
        [_playCountLabel setTextColor:[UIColor lightGrayColor]];
        [self.contentView addSubview:_playCountLabel];
        __weak typeof(self) weakSelf = self;
        [_playCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(weakSelf.contentView.mas_right).offset(-8);
            make.bottom.equalTo(weakSelf.contentView.mas_bottom).offset(-8);
            make.height.equalTo(@13);
        }];
        
        UIImageView *playView = [[UIImageView alloc] init];
        [self.contentView addSubview:playView];
        [playView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(weakSelf.playCountLabel.mas_left);
            make.bottom.equalTo(weakSelf.contentView.mas_bottom).offset(-8);
            make.width.equalTo(@13);
            make.height.equalTo(@13);
        }];
        [playView sd_setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"icon_play_Label_left.png"]];
    }
    return _playCountLabel;
}



- (UILabel *)commentLabel{
    if (!_commentLabel) {
        _commentLabel = [[UILabel alloc] init];
        _commentLabel.font = [UIFont systemFontOfSize:12];
        [_commentLabel setTextColor:[UIColor lightGrayColor]];
        [_commentLabel sizeToFit]; // 宽度自适应
        [self.contentView addSubview:_commentLabel];
        __weak typeof(self) weakSelf = self;
        [_commentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(weakSelf.playCountLabel.mas_left).offset(-23);
            make.bottom.equalTo(weakSelf.contentView.mas_bottom).offset(-8);
            make.height.equalTo(@15);
        }];
        
        UIImageView *commentIcon = [[UIImageView alloc] init];
        [commentIcon sd_setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"commenticon.png"]];
        [self.contentView addSubview:commentIcon];
        [commentIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(weakSelf.commentLabel.mas_left).offset(-2);
            make.bottom.equalTo(weakSelf.contentView.mas_bottom).offset(-8);
            make.width.equalTo(@13);
            make.height.equalTo(@13);
        }];
    }
    return _commentLabel;
}


- (UIImageView *)picCoverImage{
    if (!_picCoverImage) {
        _picCoverImage = [[UIImageView alloc] init];
//        _picCoverImage.userInteractionEnabled = YES;
        [self.contentView addSubview:_picCoverImage];
        __weak typeof(self) weakSelf = self;
        [_picCoverImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.contentView.mas_left);
            make.right.equalTo(weakSelf.contentView.mas_right);
            make.top.equalTo(weakSelf.contentView.mas_top).offset(8);
            make.bottom.equalTo(weakSelf.commentLabel.mas_top).offset(-8);
        }];
        
        UIView *blackView = [[UIView alloc] init];
        blackView.backgroundColor = [UIColor blackColor];
        blackView.alpha = 0.3;
        [_picCoverImage addSubview:blackView];
        [blackView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.contentView.mas_left);
            make.right.equalTo(weakSelf.contentView.mas_right);
            make.top.equalTo(weakSelf.contentView.mas_top).offset(8);
            make.bottom.equalTo(weakSelf.commentLabel.mas_top).offset(-8);
        }];
        
        UIImageView *buttonView = [[UIImageView alloc] init];
        [self.picCoverImage addSubview:buttonView];
        [buttonView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(weakSelf.picCoverImage.center);
            make.width.equalTo(@60);
            make.height.equalTo(@60);
        }];
        [buttonView sd_setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"icon_play.png"]];
    }
    return _picCoverImage;
}

//- (UIButton *)playButton{
//    if (!_playButton) {
//        _playButton = [[UIButton alloc] init];
//        [self.contentView addSubview:_playButton];
//        __weak typeof(self) weakSelf = self;
//        [_playButton mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.center.mas_equalTo(weakSelf.picCoverImage.center);
//            make.width.equalTo(@60);
//            make.height.equalTo(@60);
//        }];
//    }
//    return _playButton;
//}


- (UILabel *)durationLabel{
    if (!_durationLabel) {
        _durationLabel = [[UILabel alloc] init];
        _durationLabel.font = [UIFont systemFontOfSize:12];
        [_durationLabel setTextColor:[UIColor whiteColor]];
        [self.picCoverImage addSubview:_durationLabel];
        __weak typeof(self) weakSelf = self;
        [_durationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(weakSelf.picCoverImage.mas_right).offset(-8);
            make.bottom.equalTo(weakSelf.picCoverImage.mas_bottom).offset(-5);
            make.height.equalTo(@13);
        }];
    }
    return _durationLabel;
}


- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        [_titleLabel setTextColor:[UIColor whiteColor]];
        [self.picCoverImage addSubview:_titleLabel];
        __weak typeof(self) weakSelf = self;
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.picCoverImage.mas_left).offset(8);
            make.right.equalTo(weakSelf.picCoverImage.mas_right);
            make.top.equalTo(weakSelf.picCoverImage.mas_top).offset(8);
            make.height.equalTo(@21);
        }];
    }
    return _titleLabel;
}

- (void)setDataWithModel:(DataModel *)model{
    self.titleLabel.text = model.title;
//    [self.playButton.imageView sd_setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"icon_play.png"]];
//    [self.playButton setBackgroundImage:[UIImage imageNamed:@"icon_play.png"] forState:UIControlStateNormal];
    self.commentLabel.text = [NSString stringWithFormat:@"%ld",model.commentCount];
    [self.picCoverImage sd_setImageWithURL:[NSURL URLWithString:model.picCover]];
    self.durationLabel.text = model.duration;
    self.srcLabel.text = model.nickName;
    self.playCountLabel.text = [NSString stringWithFormat:@"%.2f万",(float)model.totalvisit/10000];
}

@end
