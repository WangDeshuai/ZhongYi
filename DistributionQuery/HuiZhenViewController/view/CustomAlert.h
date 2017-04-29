//
//  CustomAlert.h
//  DistributionQuery
//
//  Created by Macx on 17/4/22.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomAlert : UIView
@property (nonatomic,copy)void(^clickBlock)(UIButton*);
@property(nonatomic,strong)NSMutableArray * array;
-(id)initWithTitle:(NSString*)title  canCleBtn:(NSString*)btnName1 achiveBtn:(NSString*)btnName2 contentArray:(NSArray*)dataArray;

-(void)show;
-(void)dissmiss;

@end
