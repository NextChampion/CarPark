//
//  TalkCarDetailModel.h
//  CarPark
//
//  Created by lanou3g on 16/4/23.
//  Copyright © 2016年 com.lcarpark.zfw. All rights reserved.
//

#import "BaseModel.h"

@interface TalkCarDetailModel : BaseModel

@property(strong,nonatomic) NSString *content; //内容和图片的content
@property(assign,nonatomic) NSInteger type;

@property(strong,nonatomic) NSArray *style;

@end
