//
//  VideoModel.h
//  CarPark
//
//  Created by lanou3g on 16/4/23.
//  Copyright © 2016年 com.lcarpark.zfw. All rights reserved.
//

#import "BaseModel.h"

@interface VideoModel : BaseModel

@property (nonatomic, assign) NSInteger commentcount;
@property (nonatomic, strong) NSString *coverimg;
@property (nonatomic, strong) NSString *duration;
@property (nonatomic, strong) NSString *modifytime;
@property (nonatomic, strong) NSString *mp4link;
@property (nonatomic, strong) NSString *publishtime;
@property (nonatomic, strong) NSString *sourcename;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) NSInteger totalvisit;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, strong) NSString *videoid;
@property (nonatomic, strong) NSDictionary *user;
@end
