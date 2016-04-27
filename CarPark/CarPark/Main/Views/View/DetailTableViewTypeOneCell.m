//
//  DetailTableViewTypeOneCell.m
//  CarPark
//
//  Created by lanou3g on 16/4/27.
//  Copyright © 2016年 com.lcarpark.zfw. All rights reserved.
//

#import "DetailTableViewTypeOneCell.h"
#import "DetailModel.h"
@implementation DetailTableViewTypeOneCell

- (UILabel *)content{
    if (!_content) {
        _content = [[UILabel alloc] init];
        _content.numberOfLines = 0;
        _content.font = [UIFont systemFontOfSize:15];
        //        _content.backgroundColor = [UIColor greenColor];
        [self.contentView addSubview:_content];
        
    }
    return _content;
}

- (void)setDataWithModel:(DetailModel *)model{
    self.content.text = model.content;
    if (model.style) {
//        self.content.font = [UIFont fontWithName:@"AmericanTypewriter-Bold" size:15.0f];
    }
    __weak typeof(self) weakSelf = self;
    [_content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.contentView.mas_top).offset(10);
        make.left.equalTo(weakSelf.contentView.mas_left).offset(12);
        make.right.equalTo(weakSelf.contentView.mas_right).offset(-12);
        make.bottom.equalTo(weakSelf.contentView.mas_bottom).offset(-10);
    }];
}
@end
