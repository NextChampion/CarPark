//
//  BaseCollectionViewCell.h
//  CarPark
//
//  Created by lanou3g on 16/4/13.
//  Copyright © 2016年 com.lcarpark.zfw. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BaseModel;

@interface BaseCollectionViewCell : UICollectionViewCell



// 通过model对象设置cell上的数据
- (void)setDataWithModel:(BaseModel *)model;

@end
