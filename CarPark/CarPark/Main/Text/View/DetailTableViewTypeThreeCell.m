//
//  DetailTableViewTypeThreeCell.m
//  CarPark
//
//  Created by lanou3g on 16/4/27.
//  Copyright © 2016年 com.lcarpark.zfw. All rights reserved.
//

#import "DetailTableViewTypeThreeCell.h"

@implementation DetailTableViewTypeThreeCell

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, self.contentView.frame.size.width - 10, 30)];
        _titleLabel.font = [UIFont systemFontOfSize:18];
        _titleLabel.numberOfLines = 0;
//        _titleLabel.backgroundColor = [UIColor yellowColor];
        [self.contentView addSubview:_titleLabel];
        __weak typeof(self) weakSelf = self;
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.contentView.mas_top).offset(10);
            make.left.equalTo(weakSelf.contentView.mas_left).offset(12);
            make.right.equalTo(weakSelf.contentView.mas_right).offset(-12);
            make.bottom.equalTo(weakSelf.srcLabel.mas_top).offset(-10);
        }];
    }
    return _titleLabel;
}

- (UILabel *)srcLabel{
    if (!_srcLabel) {
        _srcLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 75, 50, 15)];
        _srcLabel.font = [UIFont systemFontOfSize:12];
        
//        _srcLabel.backgroundColor = [UIColor redColor];
        _srcLabel.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:_srcLabel];
        __weak typeof(self) weakSelf = self;
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(weakSelf.mas_top).offset(10);
            make.left.equalTo(weakSelf.contentView.mas_left).offset(12);
//            make.right.equalTo(weakSelf.mas_right).offset(-12);
            make.bottom.equalTo(weakSelf.contentView.mas_bottom).offset(-10);
            make.size.mas_equalTo(CGSizeMake(40, 15));
        }];
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.contentView.mas_left);
            make.bottom.equalTo(weakSelf.contentView.mas_bottom);
            make.size.mas_equalTo(CGSizeMake(weakSelf.contentView.frame.size.width, 1));
        }];
        
    }
    return _srcLabel;
}

- (UILabel *)publishTimeLabel{
    if (!_publishTimeLabel) {
        _publishTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 75, 200, 15)];
//        _publishTimeLabel.backgroundColor = [UIColor greenColor];
        _publishTimeLabel.font = [UIFont systemFontOfSize:12];
        _publishTimeLabel.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:_publishTimeLabel];
        __weak typeof(self) weakSelf = self;
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.srcLabel.mas_right).offset(12);
            make.bottom.equalTo(weakSelf.contentView.mas_bottom);
            make.size.mas_equalTo(CGSizeMake(50, 15));
        }];
    }
    return _publishTimeLabel;
}

//- (void)setDataWithModel:(ImportantDetailheaderModel *)model{
//    self.titleLabel.text = model.title;
//    self.srcLabel.text = model.src;
//    [self.srcLabel sizeToFit];
//    self.publishTimeLabel.text = model.publishTime;
//    __weak typeof(self) weakSelf = self;
//    [self.publishTimeLabel mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(weakSelf.srcLabel.mas_right).offset(5);
//        make.height.equalTo(@15);
//        make.bottom.equalTo(weakSelf.mas_bottom).offset(-10);
//    }];
//    
//    [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.bottom.mas_equalTo(weakSelf.mas_bottom).offset(-15);
//        make.left.equalTo(weakSelf.mas_left).offset(12);
//        make.height.equalTo(@15);
//        
//    }];
//}
@end
