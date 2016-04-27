//
//  ImportantDetailHeaderView.h
//  CarPark
//
//  Created by lanou3g on 16/4/22.
//  Copyright © 2016年 com.lcarpark.zfw. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ImportantDetailheaderModel;

@interface ImportantDetailHeaderView : UIView
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *srcLabel;
@property (nonatomic, strong) UILabel *publishTimeLabel;

- (void)setDataWithModel:(ImportantDetailheaderModel *)model;
@end
