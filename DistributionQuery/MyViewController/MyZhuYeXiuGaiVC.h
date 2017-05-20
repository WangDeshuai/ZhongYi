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
// 0 姓名，1 医院名称，2 详细地址，3 性别，
@property(nonatomic,assign)NSInteger  number;
@property(nonatomic,copy)void(^messageBlock)(NSString*name);
@end
