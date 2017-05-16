//
//  CustomAlertFive.h
//  DistributionQuery
//
//  Created by Macx on 17/5/10.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScanCodeModel.h"
@interface CustomAlertFive : UIView
-(id)initWithTitle:(NSString*)title  canCleBtn:(NSString*)btnName1 achiveBtn:(NSString*)btnName2 ;
@property(nonatomic,copy)void(^NameBlock)(ScanCodeModel*name);
-(void)show;
-(void)dissmiss;
@end
