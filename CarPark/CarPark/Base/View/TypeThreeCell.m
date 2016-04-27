//
//  TypeThreeCell.m
//  CarPark
//
//  Created by lanou3g on 16/4/21.
//  Copyright © 2016年 com.lcarpark.zfw. All rights reserved.
//

#import "TypeThreeCell.h"
#import "DataModel.h"


//@property (strong, nonatomic) UIImageView *picCoverImageLeft; // 三种图中左边那一张
//@property (strong, nonatomic) UIImageView *picCoverImageMid; // 三种图中中间那一张
//@property (strong, nonatomic) UIImageView *picCoverImageRight; // 三种图中右边那一张
//@property (strong, nonatomic) UILabel *titleLabel; // 标题
//@property (strong, nonatomic) UILabel *srcLabel; // 来源
//@property (strong, nonatomic) UILabel *commentLabel; // 点评数字
//@property (strong, nonatomic) UIImageView *commentImage; // 点评图片

@implementation TypeThreeCell

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:15];
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

- (UIImageView *)picCoverImageLeft{
    if (!_picCoverImageLeft) {
        _picCoverImageLeft = [[UIImageView alloc] initWithFrame:CGRectMake(8, 23, 60, 60)];
        _picCoverImageLeft.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:_picCoverImageLeft];
        __weak typeof(self) weakSelf = self;
        [_picCoverImageLeft mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.contentView.mas_left).offset(8);
            make.top.equalTo(weakSelf.titleLabel.mas_bottom).offset(8);
            make.bottom.equalTo(weakSelf.srcLabel.mas_top).offset(-8);
            make.right.equalTo(weakSelf.picCoverImageMid.mas_left).offset(-5);
        }];
    }
    return _picCoverImageLeft;
}

- (UIImageView *)picCoverImageMid{
    if (!_picCoverImageMid) {
        _picCoverImageMid = [[UIImageView alloc] initWithFrame:CGRectMake(75, 23, 60, 60)];
        _picCoverImageMid.backgroundColor = [UIColor greenColor];
        [self.contentView addSubview:_picCoverImageMid];
        __weak typeof(self) weakSelf = self;
        [_picCoverImageMid mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(weakSelf.picCoverImageLeft.mas_width);
            make.top.equalTo(weakSelf.titleLabel.mas_bottom).offset(8);
            make.bottom.equalTo(weakSelf.picCoverImageLeft.mas_bottom);
            make.right.equalTo(weakSelf.picCoverImageRight.mas_left).offset(-5);
        }];
    }
    return _picCoverImageMid;
}

- (UIImageView *)picCoverImageRight{
    if (!_picCoverImageRight) {
        _picCoverImageRight = [[UIImageView alloc] initWithFrame:CGRectMake(140, 23, 60, 60)];
        _picCoverImageRight.backgroundColor = [UIColor blueColor];
        [self.contentView addSubview:_picCoverImageRight];
        __weak typeof(self) weakSelf = self;
        [_picCoverImageRight mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(weakSelf.picCoverImageLeft.mas_width);
            make.top.equalTo(weakSelf.titleLabel.mas_bottom).offset(8);
            make.bottom.equalTo(weakSelf.picCoverImageLeft.mas_bottom);
            make.right.equalTo(weakSelf.contentView.mas_right).offset(-8);
        }];
    }
    return _picCoverImageRight;
}

- (UILabel *)srcLabel{
    if (!_srcLabel) {
        _srcLabel = [[UILabel alloc] init];
        _srcLabel.font = [UIFont systemFontOfSize:12];
        [_srcLabel setTextColor:[UIColor lightGrayColor]];
        [self.contentView addSubview:_srcLabel];
        __weak typeof (self) weakSelf = self;
        [_srcLabel mas_makeConstraints:^(MASConstraintMaker *make) {
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

- (UIImageView *)commentImage{
    if (!_commentImage) {
        _commentImage = [[UIImageView alloc] init];
        _commentImage.image = [UIImage imageNamed:@"commenticon.png"];
        [self.contentView addSubview:_commentImage];
        __weak typeof(self) weakSelf = self;
        [_commentImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@(15));
            make.height.equalTo(@(15));
            make.right.equalTo(weakSelf.commentLabel.mas_left);
            make.bottom.equalTo(weakSelf.contentView.mas_bottom).offset(-8);
        }];
    }
    return _commentImage;
}

- (void)setDataWithModel:(DataModel *)model{
    self.titleLabel.text = model.title;
    self.srcLabel.text = model.src;
    self.commentLabel.text = [NSString stringWithFormat:@"%ld",model.commentCount];
    NSArray *pics = [model.picCover componentsSeparatedByString:@";"];
    [self.picCoverImageLeft sd_setImageWithURL:[NSURL URLWithString:pics[0]]];
    [self.picCoverImageMid sd_setImageWithURL:[NSURL URLWithString:pics[1]]];
    [self.picCoverImageRight sd_setImageWithURL:[NSURL URLWithString:pics[2]]];
}
@end
