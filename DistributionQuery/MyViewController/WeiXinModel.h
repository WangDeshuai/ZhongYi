//
//  WeiXinModel.h
//  DistributionQuery
//
//  Created by Macx on 17/7/7.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeiXinModel : NSObject
#pragma mark --微信预支付的
@property(nonatomic,copy)NSString * weiXinID;//微信idd
@property(nonatomic,copy)NSString * weiNoncestr;
@property(nonatomic,copy)NSString * weiPackage;
@property(nonatomic,copy)NSString * weiXinPartnerid;//
@property(nonatomic,copy)NSString * weiXinPrepayid;//
@property(nonatomic,copy)NSString * weiXinSign;//
@property(nonatomic,copy)NSString * weiXinTimestamp;
-(id)initWithWeiXinModelDic:(NSDictionary*)dic;
@end
