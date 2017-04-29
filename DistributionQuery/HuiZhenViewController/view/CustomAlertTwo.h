//
//  CustomAlertTwo.h
//  DistributionQuery
//
//  Created by Macx on 17/4/27.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomAlertTwo : UIView
@property (nonatomic,copy)void(^clickBlock)(UIButton*);
@property(nonatomic,strong)NSMutableArray * array;
/*
 tag==1 (病名) tag==2(病理) tag==3(舌苔)
 contentArray 内容Array
 */
-(id)initWithTitle:(NSString*)title  canCleBtn:(NSString*)btnName1 achiveBtn:(NSString*)btnName2 contentArray:(NSArray*)dataArray Tag:(NSInteger)tag;

-(void)show;
-(void)dissmiss;
@end
