//
//  CustomAlertTwo.h
//  DistributionQuery
//
//  Created by Macx on 17/4/27.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScanCodeModel.h"
@interface CustomAlertTwo : UIView
@property (nonatomic,copy)void(^clickBlock)(UIButton*btn,ScanCodeModel*md,ScanCodeModel*md2);
@property(nonatomic,strong)NSMutableArray * array;
/*
 tag==1 (病名) tag==2(病理) tag==3(舌苔)
 contentArray 内容Array
 */
-(id)initWithTitle:(NSString*)title  canCleBtn:(NSString*)btnName1 achiveBtn:(NSString*)btnName2  Tag:(NSInteger)tag;

-(void)show;
-(void)dissmiss;
@end
