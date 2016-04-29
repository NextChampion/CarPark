//
//  TypeOneVell.m
//  CarPark
//
//  Created by lanou3g on 16/4/21.
//  Copyright © 2016年 com.lcarpark.zfw. All rights reserved.
//

#import "TypeOneCell.h"
#import "DataModel.h"
#import "BaseModel.h"

//@property (strong, nonatomic) UIImageView *picCoverImage;
//@property (strong, nonatomic) UILabel *titleLabel;
//@property (strong, nonatomic) UILabel *srcLabel;
//@property (strong, nonatomic) UILabel *commentLabel;
//@property (strong, nonatomic) UIImageView *commentImage;

@implementation TypeOneCell

- (UIImageView *)picCoverImage{
    if (!_picCoverImage) {
        _picCoverImage = [[UIImageView alloc] init];
        [self.contentView addSubview:_picCoverImage];
        __weak typeof (self) weakSelf = self;
        [_picCoverImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.contentView.mas_top).offset(8);
            make.left.equalTo(weakSelf.contentView.mas_left).offset(8);
            make.bottom.equalTo(weakSelf.contentView.mas_bottom).offset(-8);
            make.width.equalTo(@(ScreenWidth/3));
        }];
    }
    return _picCoverImage;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.numberOfLines = 0;
        _titleLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_titleLabel];
        __weak typeof (self) weakSelf = self;
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.contentView.mas_top).offset(8);
            make.left.equalTo(weakSelf.picCoverImage.mas_right).offset(10);
            make.right.equalTo(weakSelf.contentView.mas_right).offset(-8);
        }];
    }
    return _titleLabel;
}

- (UILabel *)srcLabel{
    if (!_srcLabel) {
        _srcLabel = [[UILabel alloc] init];
        _srcLabel.font = [UIFont systemFontOfSize:12];
        _srcLabel.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:_srcLabel];
        __weak typeof (self) weakSelf = self;
        [_srcLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(weakSelf.contentView.mas_bottom).offset(-8);
            make.left.equalTo( weakSelf.picCoverImage.mas_right).offset(10);
            make.height.equalTo(@(15));
        }];
    }
    return _srcLabel;
}

- (UILabel *)commentLabel{
    if (!_commentLabel) {
        _commentLabel = [[UILabel alloc] init];
        _commentLabel.font = [UIFont systemFontOfSize:12];
        _commentLabel.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:_commentLabel];
        __weak typeof (self) weakSelf = self;
        [_commentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(weakSelf.contentView.mas_bottom).offset(-8);
            make.right.equalTo(weakSelf.contentView.mas_right).offset(-8);
            make.height.equalTo(@(15));
        }];
    }
    return _commentLabel;
}

- (UIImageView *)commentImage{
    if (!_commentImage) {
        _commentImage = [[UIImageView alloc] init];
        [self.contentView addSubview:_commentImage];
        __weak typeof (self) weakSelf = self;
        [_commentImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(weakSelf.contentView.mas_bottom).offset(-8);
            make.right.equalTo(weakSelf.commentLabel.mas_left).offset(-2);
            make.width.equalTo(@(13));
            make.height.equalTo(@(13));
        }];
    }
    return _commentImage;
}

// 自适应高度
- (CGFloat)stringHeight:(NSString *)aString{
    // !!!: 1 传参数的时候,宽度最好和以前的label宽度一样  2 字体的大小,最好和label上面字体的大小一样
    CGRect temp = [aString boundingRectWithSize:CGSizeMake(355, 10000000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:17]} context:nil];
    return temp.size.height;
}

- (void)setDataWithModel:(DataModel *)model{
    self.titleLabel.text = model.title;
    self.commentLabel.text = [NSString stringWithFormat:@"%ld",model.commentCount];
    self.srcLabel.text = model.src;
    [self.picCoverImage sd_setImageWithURL:[NSURL URLWithString:model.picCover] placeholderImage:[UIImage imageNamed:@"placeholder_image.png"]];
//    [self.picCoverImage sd_setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"placeholder_word.png"]];
//    self.commentImage.image  = [UIImage imageNamed:@"commenticon.png"];
    [self.commentImage sd_setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"commenticon.png"]];
}

@end
