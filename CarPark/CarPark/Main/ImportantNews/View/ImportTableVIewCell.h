//
//  ImportScrollViewController.h
//  CarPark
//
//  Created by lanou3g on 16/4/18.
//  Copyright © 2016年 com.lcarpark.zfw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewCell.h"
#import "ImportModel.h"

@interface ImportTableVIewCell : BaseTableViewCell

/** image*/
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
/** 标题Label*/
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
/** 状态Label*/
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;
/** 评论Label*/
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;

@property(retain,nonatomic)ImportModel *Model;


@end
