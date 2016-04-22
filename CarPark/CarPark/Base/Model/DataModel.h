//
//  dataModel.h
//  CarPark
//
//  Created by lanou3g on 16/4/21.
//  Copyright © 2016年 com.lcarpark.zfw. All rights reserved.
//

#import "BaseModel.h"

@interface DataModel : BaseModel


@property (nonatomic, assign) NSInteger commentCount;
@property (nonatomic, strong) NSString *dataVersion;
@property (nonatomic, strong) NSString *duration;
@property (nonatomic, strong) NSString *filePath;
@property (nonatomic, strong) NSString *itemType;
@property (nonatomic, strong) NSString *lastModify;
@property (nonatomic, strong) NSString *newsId;
@property (nonatomic, strong) NSString *nickName;
@property (nonatomic, strong) NSString *picName;
@property (nonatomic, strong) NSString *picCover;
@property (nonatomic, strong) NSString *publishTime;
@property (nonatomic, strong) NSString *src;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) NSInteger totalvisit;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, strong) NSString *userAvatar;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *videoId;
@property (nonatomic, assign) NSInteger viewCount;


@end
