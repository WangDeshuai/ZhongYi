//
//  RegisterVC.h
//  DistributionQuery
//
//  Created by Macx on 17/4/21.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import "BaseViewController.h"

@interface RegisterVC : BaseViewController
@property(nonatomic,copy)void(^PhonePswBlock)(NSString*phone,NSString*psw);
@end
