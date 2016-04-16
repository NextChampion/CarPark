//
//  BaseModel.m
//  CarPark
//
//  Created by lanou3g on 16/4/13.
//  Copyright © 2016年 com.lcarpark.zfw. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    NSLog(@"%@",key);
}

@end
