//
//  YuYinView.h
//  ZYVoiceToWordTextViewDemo
//
//  Created by Macx on 17/7/20.
//  Copyright © 2017年 ZY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YuYinView : UIView
- (id)init;
//@property(nonatomic,strong)void(^buttonClinkBlock)(UIButton*btn);
@property(nonatomic,copy)void(^TextBlock)(NSString*text ,BOOL Last);

-(void)show;
-(void)dissmiss;
@end
