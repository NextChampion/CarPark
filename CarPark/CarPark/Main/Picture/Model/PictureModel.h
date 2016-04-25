//
//  PictureModel.h
//  CarPark
//
//  Created by lanou3g on 16/4/20.
//  Copyright © 2016年 com.lcarpark.zfw. All rights reserved.
//

#import "BaseModel.h"

@interface PictureModel : BaseModel

#warning header
@property (nonatomic, assign) NSInteger commentCount;
@property (nonatomic, strong) NSString *dataVersion;
@property (nonatomic, strong) NSString *filePath;
@property (nonatomic, assign) NSInteger imageCount;
@property (nonatomic, strong) NSString *itemType;
@property (nonatomic, strong) NSString *lastModify;
@property (nonatomic, assign) NSInteger newsId;
@property (nonatomic, strong) NSString *picCover;
@property (nonatomic, strong) NSString *publishTime;
@property (nonatomic, strong) NSString *src;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) NSInteger type;
#warning 未知
@property (assign, nonatomic) NSNumber *commentCount;
@property (strong, nonatomic) NSString *src;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSNumber *type;
#warning 未知 footer

@end
