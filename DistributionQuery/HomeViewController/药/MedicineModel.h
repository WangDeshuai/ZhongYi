//
//  MedicineModel.h
//  DistributionQuery
//
//  Created by Macx on 17/4/27.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MedicineModel : NSObject
//药
@property(nonatomic,copy)NSString * yaoTitleName;
@property(nonatomic,copy)NSString * yaoImageName;
@property(nonatomic,copy)NSString * yaoDexName;
@property(nonatomic,copy)NSString * yaoID;
-(id)initWithYaoDic:(NSDictionary*)dic;
//药详情页
@property(nonatomic,copy)NSString * xqimageName;//图片
@property(nonatomic,copy)NSString * xqYaoName;//药名
@property(nonatomic,copy)NSString * xqYaoBieName;//别名
@property(nonatomic,copy)NSString * xqXingWei;//性味
@property(nonatomic,copy)NSString * xqGuiJing;//归经
@property(nonatomic,copy)NSString * xqGongXiao;//功效
@property(nonatomic,copy)NSString * xqZhuZhi;//主治
@property(nonatomic,copy)NSString * xqChengFen;//成分
@property(nonatomic,copy)NSString * xqJinJi;//禁忌
@property(nonatomic,copy)NSString * xqDuXing;//毒性
@property(nonatomic,copy)NSString * xqKangLiPu;//抗瘤谱
@property(nonatomic,copy)NSString * xqYongFa;//用法用量
@property(nonatomic,copy)NSString * xqPeiWuXiaoYong;//配伍效用
@property(nonatomic,copy)NSString * xqxianDaiYaoLi;//现代药理研究
-(id)initWithYaoXiangQingDic:(NSDictionary*)dic;

@end
