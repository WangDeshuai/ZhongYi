//
//  YaoFangModel.h
//  DistributionQuery
//
//  Created by Macx on 17/5/2.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YaoFangModel : NSObject
//药方列表页
@property(nonatomic,copy)NSString * name;
@property(nonatomic,copy)NSString * yaoID;
-(id)initWithYaoListViewDic:(NSDictionary*)dic;

//药方列表详情页
@property(nonatomic,copy)NSString * xqfangMing;
@property(nonatomic,copy)NSString * xqzuCheng;
@property(nonatomic,copy)NSString * xqgongXiao;
@property(nonatomic,copy)NSString * xqzhuZhi;
@property(nonatomic,copy)NSString * xqfangJie;
@property(nonatomic,copy)NSString * xqyongFa;
@property(nonatomic,copy)NSString * xqjinJi;
@property(nonatomic,copy)NSString * xqzhuYiShiXiang;
-(id)initWithYaoFangXiangQingDic:(NSDictionary*)dic;


//药方分类
@property(nonatomic,copy)NSString *yaoFangClass;
@property(nonatomic,copy)NSString * yaoClassID;
-(id)initWithYaoClassViewDic:(NSDictionary*)dic;

//药方分类详情
@property(nonatomic,copy)NSString *titleclassname;
@property(nonatomic,copy)NSString * gongclassxiao;
@property(nonatomic,copy)NSString * fenleiID;
-(id)initWithFenLeiXiangQingDic:(NSDictionary*)dic;


@end
