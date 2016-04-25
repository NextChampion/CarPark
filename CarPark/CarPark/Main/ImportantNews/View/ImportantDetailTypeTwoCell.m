//
//  ImportantDetailTypeTwoCell.m
//  CarPark
//
//  Created by lanou3g on 16/4/22.
//  Copyright © 2016年 com.lcarpark.zfw. All rights reserved.
//

#import "ImportantDetailTypeTwoCell.h"
#import "ImportDetailModel.h"

@implementation ImportantDetailTypeTwoCell

- (NSArray *)style{
    if (!_style) {
        _style = [[NSArray alloc] init];
    }
    return _style;
}
- (UIView *)content{
    if (!_content) {
        _content = [[UIImageView alloc] initWithFrame:CGRectMake(12, 0, ScreenWidth, 80)];
        _content.backgroundColor = BackGroudColor;
        [self.contentView addSubview:_content];
        __weak typeof(self) weakSelf = self;
        [_content mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.contentView.mas_top).offset(15);
            make.left.equalTo(weakSelf.contentView.mas_left).offset(15);
            make.right.equalTo(weakSelf.contentView.mas_right).offset(-15);
            make.bottom.equalTo(weakSelf.contentView.mas_bottom).offset(-15);
        }];
    }
    return _content;
}

- (void)setDataWithModel:(ImportDetailModel *)model{
    [self.content sd_setImageWithURL:[NSURL URLWithString:model.content]];
    __weak typeof(self) weakSelf = self;
    NSArray *array = model.style;
    NSInteger width = [array[0][@"width"] integerValue];
    NSInteger height = [array[0][@"height"] integerValue];
    NSLog(@"%@",array);
    [self.content mas_updateConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(weakSelf.contentView.center);
        make.size.mas_equalTo(CGSizeMake(width , height*ScreenWidth/width));
    }];
}

@end
