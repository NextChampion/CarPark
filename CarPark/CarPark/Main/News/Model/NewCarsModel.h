//
//  NewCarsModel.h
//  CarPark
//
//  Created by lanou3g on 16/4/16.
//  Copyright © 2016年 com.lcarpark.zfw. All rights reserved.
//

#import "BaseModel.h"

@interface NewCarsModel : BaseModel

//标题
@property (nonatomic, strong) NSString *title;
//@property (nonatomic, strong) NSString *origin;
//评论数
@property (nonatomic, strong) NSString *commentCount;
//图片连接
@property (nonatomic, strong) NSString *picCover;
//用来推出详细界面的参数
@property (nonatomic,strong) NSString *newsId;
@property (nonatomic,strong) NSString *lastModify;


@end
