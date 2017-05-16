//
//  CustomAlertThree.h
//  DistributionQuery
//
//  Created by Macx on 17/5/10.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomAlertThree : UIView
-(id)initWithTitle:(NSString*)title  canCleBtn:(NSString*)btnName1 achiveBtn:(NSString*)btnName2 ;
@property(nonatomic,copy)void(^NameBlock)(NSString*name);
-(void)show;
-(void)dissmiss;
@end
