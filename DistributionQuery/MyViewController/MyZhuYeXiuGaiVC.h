//
//  MyZhuYeXiuGaiVC.h
//  DistributionQuery
//
//  Created by Macx on 17/5/2.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import "BaseViewController.h"

@interface MyZhuYeXiuGaiVC : BaseViewController
@property(nonatomic,copy)NSString * titleStr;
@property(nonatomic,assign)NSInteger  number;
@property(nonatomic,copy)void(^messageBlock)(NSString*name);
@end
