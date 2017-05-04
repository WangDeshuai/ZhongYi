//
//  Engine.h
//  DistributionQuery
//
//  Created by Macx on 16/10/8.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^SuccessBlock)(NSDictionary*dic);
typedef void (^ErrorBlock)(NSError*error);
@interface Engine : NSObject
//**********************************首页**********************//
#pragma mark --1.加载所有药品信息
+(void)allYaoPinMessage:(NSString*)nameStr success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;

#pragma mark --2加载药品详细信息
+(void)yaoPinXiangQingMessageYaoID:(NSString*)yaoID success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;

#pragma mark --3加载所有药方信息
+(void)yaoFangJiaZaiAllPage:(NSString*)page SearchStr:(NSString*)nameStr success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;

#pragma mark --4加载所有病种分类
+(void)jiaZaiBingZhongClasssuccess:(SuccessBlock)aSuccess error:(ErrorBlock)aError;

#pragma mark --5加载药方详情页
+(void)jiaZaiYaoFangXiangQingYaoID:(NSString*)yaoID success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;
#pragma mark --6病种分类详情页
+(void)bingZhongFenLeiXiangXiID:(NSString*)bzid success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;

#pragma mark --7根据病种分类加载病的详情信息（病详情）
+(void)BingZhongXiangQingClassID:(NSString*)idd success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;


#pragma mark --9根据病种分类加载中医医案信息(中医医案)
+(void)ZhongYiYiAnMessageID:(NSString *)idd Page:(NSString*)page PageSize:(NSString*)size success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;
//#pragma mark --3首页医案管理
//+(void)shouYeYiAnLisetViewPage:(NSString*)page success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;

@end
