//
//  ChooseCityVC.h
//  DistributionQuery
//
//  Created by Macx on 17/5/19.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import "BaseViewController.h"

@interface ChooseCityVC : BaseViewController
@property(nonatomic,copy)void(^CityNameBlock)(NSString*shengName,NSString*shiName,NSString *xianName,NSString* xianCode);
@end
