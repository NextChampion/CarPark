//
//  TypeTwoCell.m
//  CarPark
//
//  Created by lanou3g on 16/4/21.
//  Copyright © 2016年 com.lcarpark.zfw. All rights reserved.
//

#import "TypeTwoCell.h"
#import "DataModel.h"

@implementation TypeTwoCell


- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_titleLabel];
        __weak typeof(self) weakSelf = self;
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.contentView.mas_left).offset(8);
            make.top.equalTo(weakSelf.contentView.mas_top).offset(8);
            make.right.equalTo(weakSelf.contentView.mas_right).offset(-8);
            make.height.equalTo(@21);
        }];
    }
    return _titleLabel;
}

- (UIImageView *)picCoverImage{
    if (!_picCoverImage) {
        _picCoverImage = [[UIImageView alloc] init];
        [self.contentView addSubview:_picCoverImage];
        __weak typeof(self) weakSelf = self;
        [_picCoverImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.contentView.mas_left).offset(8);
            make.top.equalTo(weakSelf.titleLabel.mas_bottom).offset(8);
            make.bottom.equalTo(weakSelf.srcLabel.mas_top).offset(-8);
            make.right.equalTo(weakSelf.contentView.mas_right).offset(-8);
        }];
    }
    return _picCoverImage;
}



- (UILabel *)srcLabel{
    if (!_srcLabel) {
        _srcLabel = [[UILabel alloc] init];
        _srcLabel.font = [UIFont systemFontOfSize:12];
        [_srcLabel setTextColor:[UIColor lightGrayColor]];
        [self.contentView addSubview:_srcLabel];
        __weak typeof(self) weakSelf = self;
        [_srcLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@(60));
            make.height.equalTo(@(15));
            make.bottom.equalTo(weakSelf.contentView.mas_bottom).offset(-8);
            make.left.equalTo(weakSelf.contentView.mas_left).offset(8);
        }];
    }
    return _srcLabel;
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
            make.right.equalTo(weakSelf.contentView.mas_right).offset(-8);
            make.bottom.equalTo(weakSelf.contentView.mas_bottom).offset(-8);
            make.height.equalTo(@(15));
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


- (void)setDataWithModel:(DataModel *)model{
    self.titleLabel.text = model.title;
    self.srcLabel.text = model.src;
    self.commentLabel.text = [NSString stringWithFormat:@"%ld",model.commentCount];
    [self.picCoverImage sd_setImageWithURL:[NSURL URLWithString:model.picCover]];
    
}


@end
