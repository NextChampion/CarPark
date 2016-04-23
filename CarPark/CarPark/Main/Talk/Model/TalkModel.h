//
//  TalkModel.h
//  CarPark
//
//  Created by lanou3g on 16/4/22.
//  Copyright © 2016年 com.lcarpark.zfw. All rights reserved.
//

#import "BaseModel.h"

@interface TalkModel : BaseModel
@property(strong,nonatomic) NSString *picCover;
@property(strong,nonatomic) NSString *mediaName;
@property(strong,nonatomic) NSNumber *commentCount;
@property(strong,nonatomic) NSString *title;

@end
