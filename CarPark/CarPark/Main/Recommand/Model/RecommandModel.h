//
//  RecommandModel.h
//  CarPark
//
//  Created by lanou3g on 16/4/18.
//  Copyright © 2016年 com.lcarpark.zfw. All rights reserved.
//

#import "BaseModel.h"

@interface RecommandModel : BaseModel
@property(strong,nonatomic)NSString *title;
@property(strong,nonatomic)NSString *picCover;
@property(strong,nonatomic)NSString *src;
@property(strong,nonatomic)NSNumber *commentCount;
@property(strong,nonatomic)NSNumber *type;
@end
