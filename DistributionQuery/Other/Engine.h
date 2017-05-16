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
#pragma mark --8分页加载中医医案信息(首页)
+(void)FirstJiaZaiYiAnMessagePage:(NSString*)page PageSize:(NSString*)pagesize success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;

#pragma mark --9根据病种分类加载中医医案信息(中医医案)
+(void)ZhongYiYiAnMessageID:(NSString *)idd Page:(NSString*)page PageSize:(NSString*)size success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;


#pragma mark --10.点击某个医案加载中医医案详情
+(void)YiAnXiangQingMessageID:(NSString*)idd success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;


#pragma mark --11.分页加载所有讲座信息
+(void)jiaZaiJiangZuoAllMessagePage:(NSString*)page success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;

#pragma mark --12.根据病种分类加载讲座信息(讲座)
+(void)jiangZuoBingZhongID:(NSString*)idd Page:(NSString*)page PageSize:(NSString*)pagesize success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;

#pragma mark --13.点击某个讲座后加载讲座详情
+(void)jiangZuoXiangQingMeessageID:(NSString*)mesID success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;

#pragma mark --16.加载所有的舌苔信息
+(void)jiaZaiAllSheMessagesuccess:(SuccessBlock)aSuccess error:(ErrorBlock)aError;
#pragma mark --17.加载所有的舌质信息
+(void)jiaZaiAllSheZhiMessagesuccess:(SuccessBlock)aSuccess error:(ErrorBlock)aError;
#pragma mark --18.加载所有的脉象信息
+(void)jiaZaiAllMaiXiangMessagesuccess:(SuccessBlock)aSuccess error:(ErrorBlock)aError;
#pragma mark --19.加载所有的病理信息
+(void)jiaZaiBingLiMessagesuccess:(SuccessBlock)aSuccess error:(ErrorBlock)aError;
#pragma mark --20.加载所有的病种分类信息
+(void)jiaZaiBingMingAllMessageID:(NSString*)idd success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;

#pragma mark --21.加载所有的主诉信息
+(void)jiaZaiZhuSuMessageID:(NSString*)idd success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;
#pragma mark --23.分页加载所有我的报告单信息
+(void)baoGaiDanPage:(NSString*)page memBerID:(NSString*)idd success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;
#pragma mark --24.加载我的报告单详情信息
+(void)baoGaiDanXiangQingMessageID:(NSString*)idd success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;

#pragma mark --26.新增我的报告单信息
+(void)saveBaoGaoDanID:(NSString*)idd Type:(NSString*)leiXing XingMing:(NSString*)name Sex:(NSString*)sex Age:(NSString*)age BingMingID:(NSString*)bingMing ZhuSuID:(NSString*)zhusu BingLiID:(NSString*)bingli MaiXiangID:(NSString*)maixiang SheZhiID:(NSString*)shezhi SheTaiID:(NSString*)shetai YouWuFangYN:(NSString*)yn FangZhouQi:(NSString*)zhouqi HuaYN:(NSString*)ynn HuaZhouQi:(NSString*)zhouq ShouShuID:(NSString*)shoushu TNMfen:(NSString*)tnm Pro:(NSString*)pro success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;



@end
