//
//  DetailModel.h
//  CarPark
//
//  Created by lanou3g on 16/4/27.
//  Copyright © 2016年 com.lcarpark.zfw. All rights reserved.
//

#import "BaseModel.h"

@interface DetailModel : BaseModel

@property (nonatomic, assign) NSInteger type; // 数据的类型
@property (nonatomic, strong) NSString *content; // 数据的内容
@property (nonatomic, strong) NSArray *style; // 如果内容为图片 该数组存放图片大小属性

@end
