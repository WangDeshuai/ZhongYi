//
//  TanKuangView.h
//  DistributionQuery
//
//  Created by Macx on 17/7/15.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TanKuangView : UIView
- (id)initWithTitle:(NSString*)title  contentName:(NSString*)content achiveBtn:(NSString*)btnName ;
@property(nonatomic,strong)void(^buttonClinkBlock)(UIButton*btn);
-(void)show;
-(void)dissmiss;

@end
