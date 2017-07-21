//
//  Engine1.h
//  DistributionQuery
//
//  Created by Macx on 17/6/23.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^SuccessBlock)(NSDictionary*dic);
typedef void (^ErrorBlock)(NSError*error);
@interface Engine1 : NSObject
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
#pragma mark --14.分页加载所有的积分商品信息
+(void)shangPinJiaZaiMessage:(NSString*)page success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;


#pragma mark --16.加载所有的舌苔信息
+(void)jiaZaiAllSheMessagesuccess:(SuccessBlock)aSuccess error:(ErrorBlock)aError;
#pragma mark --17.加载所有的舌质信息
+(void)jiaZaiAllSheZhiMessagesuccess:(SuccessBlock)aSuccess error:(ErrorBlock)aError;
//18接口安卓
#pragma mark --19.加载所有的脉象信息
+(void)jiaZaiAllMaiXiangMessagesuccess:(SuccessBlock)aSuccess error:(ErrorBlock)aError;
#pragma mark --20.加载所有的病理信息
+(void)jiaZaiBingLiMessagesuccess:(SuccessBlock)aSuccess error:(ErrorBlock)aError;
#pragma mark --21.加载所有的病种分类信息
+(void)jiaZaiBingMingAllMessageID:(NSString*)idd success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;

#pragma mark --22.加载所有的主诉信息
+(void)jiaZaiZhuSuMessageID:(NSString*)idd success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;
+(void)jiaZaiZhuSuErJiMeesageID:(NSString*)idd success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;


#pragma mark --23.加载所有的地区（省、市、区县）信息
+(void)shengShiXianDiQu:(NSString*)idd success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;
#pragma mark --加载市
+(void)CityID:(NSString*)idd success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;

#pragma mark --24.分页加载所有我的报告单信息
+(void)baoGaiDanPage:(NSString*)page  success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;
#pragma mark --25.加载我的报告单详情信息
+(void)baoGaiDanXiangQingMessageID:(NSString*)idd success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;

#pragma mark --26.编辑我的报告单信息
+(void)bianJiMyBaoGaoDanMessage:(NSString*)idd success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;


#pragma mark --27.新增我的报告单信息
+(void)saveBaoGaoDanID:(NSString*)idd Type:(NSString*)leiXing XingMing:(NSString*)name Sex:(NSString*)sex Age:(NSString*)age BingMingID:(NSString*)bingMing ZhuSuID:(NSString*)zhusu BingLiID:(NSString*)bingli MaiXiangID:(NSString*)maixiang SheZhiID:(NSString*)shezhi SheTaiID:(NSString*)shetai YouWuFangYN:(NSString*)yn FangZhouQi:(NSString*)zhouqi HuaYN:(NSString*)ynn HuaZhouQi:(NSString*)zhouq ShouShuID:(NSString*)shoushu TNMfen:(NSString*)tnm Pro:(NSString*)pro success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;

#pragma mark --28.更新报告单信息
+(void)saveGengXinBaoGaoDanMessageID:(NSString*)idd MessageName:(NSString*)name MessageSex:(NSString*)sex Age:(NSString*)age success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;


#pragma mark --29.保存我的意见反馈信息(带有图片)
+(void)messageFanKuiContent:(NSString*)content ImageArr:(UIImage*)image success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;


#pragma mark --30.分页加载我的收藏信息
+(void)shouCangPage:(NSString*)page success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;

#pragma mark --31.保存我的收藏信息
+(void)shouCangSaveStype:(NSString*)type MessageID:(NSString*)messageid uccess:(SuccessBlock)aSuccess error:(ErrorBlock)aError;

#pragma mark --验证我的收藏信息
+(void)YanZhengMyShouCangMessageID:(NSString*)messageID Type:(NSString*)type success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;

#pragma mark --32加载我的推广信息
+(void)jiaZaiTuiGuangMessagesuccess:(SuccessBlock)aSuccess error:(ErrorBlock)aError;

#pragma mark --33.加载个人主页
+(void)chaXunMyZhuYesuccess:(SuccessBlock)aSuccess error:(ErrorBlock)aError;


#pragma mark --34.注册会员信息
+(void)registerMessagePhone:(NSString*)phone Password:(NSString*)psw  ResPassword:(NSString*)pswTwo  YaoQingMa:(NSString*)yaoqing YanZhengMa:(NSString*)code success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;
#pragma mark-- 35.会员登录
+(void)loginAppPhone:(NSString*)phone Password:(NSString*)psw  success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;

#pragma mark --36.个人主页保存信息
+(void)myZhuYeSaveMessageCanShuName:(NSString*)name ValueName:(NSString*)value  success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;


#pragma mark --37.会员头像修改
+(void)headImage:(UIImage*)image success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;

#pragma mark --38.会员修改密码
+(void)XiuGaiPassWordYuan:(NSString*)oldWord NewWord:(NSString*)newword success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;

#pragma mark --39.会员重置密码
+(void)forGetPassWordCode:(NSString*)code Phone:(NSString*)phone Password:(NSString*)psw1 PassWordTwo:(NSString*)psw2 success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;

#pragma mark --40.加载所有的病种分类信息（适用于药方页加载病种分类的接口）
+(void)yaoFangClassFenLeisuccess:(SuccessBlock)aSuccess error:(ErrorBlock)aError;


#pragma mark --41.加载所有的病种分类信息（适用于病名页加载病种分类的接口）
+(void)bingMingFenLeisuccess:(SuccessBlock)aSuccess error:(ErrorBlock)aError;

#pragma mark --42.加载首页轮播图
+(void)shouYiFirstLunBosuccess:(SuccessBlock)aSuccess error:(ErrorBlock)aError;

#pragma mark --43.首页全局搜索
+(void)searchFirstKeyWord:(NSString*)name success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;

#pragma mark --44.发送短信验证码
+(void)sendCodePhone:(NSString*)phone Type:(NSString*)type success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;

#pragma mark --46.生成支付宝预付定单
+(void)huoQuDingDanHaoName:(NSString*)dingDanName Price:(NSString*)price Type:(NSString*)type  success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;

#pragma mark --47.生成微信预支付订单
+(void)weiXinYuZhiFuPrice:(NSString*)price Type:(NSString*)type MiaoShu:(NSString*)ms success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;

#pragma mark --48.查询会员升级以及续费所需支付金额
+(void)chaXunVipShengJiLoginPhonesuccess:(SuccessBlock)aSuccess error:(ErrorBlock)aError;

#pragma mark --50.加载会员信息并跳转三辩会诊页面
+(void)sanBianHuiZhenPaysuccess:(SuccessBlock)aSuccess error:(ErrorBlock)aError;

@end
