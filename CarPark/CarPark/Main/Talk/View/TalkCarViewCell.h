//
//  TalkCarView.h
//  CarPark
//
//  Created by lanou3g on 16/4/20.
//  Copyright © 2016年 com.lcarpark.zfw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseCollectionViewCell.h"

@interface TalkCarViewCell : BaseCollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *title;

@property (weak, nonatomic) IBOutlet UIImageView *picCover;

@property (weak, nonatomic) IBOutlet UILabel *mediaName;

@property (weak, nonatomic) IBOutlet UILabel *commentCount;




@end
