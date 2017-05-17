//
//  BingMingModel.h
//  DistributionQuery
//
//  Created by Macx on 17/5/4.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BingMingModel : NSObject
@property(nonatomic,copy)NSString *xqBingName;
@property(nonatomic,copy)NSString *xqzyBingName;
@property(nonatomic,copy)NSString *xqDingYi;
@property(nonatomic,copy)NSString *xqBingYin;
@property(nonatomic,copy)NSString *xqLinChuang;
@property(nonatomic,copy)NSString *xqZhenDuan;
@property(nonatomic,copy)NSString *xqJianBie;
@property(nonatomic,copy)NSString *xqChangGui;
@property(nonatomic,copy)NSString * junYao;
@property(nonatomic,copy)NSString * chenYao;
@property(nonatomic,copy)NSString * zuoYao;
@property(nonatomic,copy)NSString * shiYao;
@property(nonatomic,copy)NSString * junYaoID;
@property(nonatomic,copy)NSString * chenYaoID;
@property(nonatomic,copy)NSString * zuoYaoID;
@property(nonatomic,copy)NSString * shiYaoID;

//病名详情
-(id)initWithBingMingXiangQingDic:(NSDictionary*)dic;
@end
