//
//  BaoGaiDanModel.h
//  DistributionQuery
//
//  Created by Macx on 17/5/11.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaoGaiDanModel : NSObject
//报告单列表
@property(nonatomic,copy)NSString * bgname;
@property(nonatomic,copy)NSString * bgid;
@property(nonatomic,copy)NSString * bgsex;
@property(nonatomic,copy)NSString * bgbingMing;
@property(nonatomic,copy)NSString * bgtime;
-(id)initWithBaoGaoDanDic:(NSDictionary*)dic;
//报告单详情
@property(nonatomic,copy)NSString * xqname;//姓名
@property(nonatomic,copy)NSString * xqsex;//性别
@property(nonatomic,copy)NSString * xqtitlename;//大标题
@property(nonatomic,copy)NSString * xqage;//年龄
@property(nonatomic,copy)NSString * xqsheTai;//舌苔舌质
@property(nonatomic,copy)NSString * xqshoushu;//手术
@property(nonatomic,copy)NSString * xqmaiXiang;//脉象
@property(nonatomic,copy)NSString * xqTNM;//TNM分期
@property(nonatomic,copy)NSString * xqyouFang;//放疗
@property(nonatomic,copy)NSString * xqyouHua;//化疗
@property(nonatomic,copy)NSString * xqbingMing;//病名
@property(nonatomic,copy)NSString * xqbingLi;//病理

@property(nonatomic,copy)NSString * xqzhusu;//主诉
@property(nonatomic,copy)NSString * xqzhuyaowenti;//主要会诊问题
@property(nonatomic,copy)NSString * xqhuikaifang;//会诊开方
@property(nonatomic,copy)NSString * xqgongxiao;//功效

-(id)initWithBaoGaoDanXiangQingDic:(NSDictionary*)dic;
@end
