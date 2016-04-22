//
//  NewCarsCell.h
//  CarPark
//
//  Created by lanou3g on 16/4/16.
//  Copyright © 2016年 com.lcarpark.zfw. All rights reserved.
//

#import "BaseCollectionViewCell.h"
@interface NewCarsCell : BaseCollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *commentLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UIImageView *carImageView;
@end
