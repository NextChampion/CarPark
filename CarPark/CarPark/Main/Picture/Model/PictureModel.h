//
//  PictureModel.h
//  CarPark
//
//  Created by lanou3g on 16/4/20.
//  Copyright © 2016年 com.lcarpark.zfw. All rights reserved.
//

#import "BaseModel.h"

@interface PictureModel : BaseModel

@property (assign, nonatomic) NSNumber *commentCount;
@property (strong, nonatomic) NSString *src;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSNumber *type;

@end
