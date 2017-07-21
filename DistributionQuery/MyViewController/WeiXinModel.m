//
//  WeiXinModel.m
//  DistributionQuery
//
//  Created by Macx on 17/7/7.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import "WeiXinModel.h"

@implementation WeiXinModel
#pragma mark --微信支付
-(id)initWithWeiXinModelDic:(NSDictionary*)dic{
    self=[super init];
    if (self) {
        _weiXinID=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"appId"]]];
        _weiNoncestr=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"nonceStr"]]];
        _weiPackage=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"packageValue"]]];
        _weiXinPartnerid=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"partnerId"]]];
        _weiXinPrepayid=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"prepayId"]]];
        _weiXinSign=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"sign"]]];
        _weiXinTimestamp=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"timeStamp"]]];
    }
    
    return self;
}
@end
