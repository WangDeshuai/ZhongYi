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
//病名详情
-(id)initWithBingMingXiangQingDic:(NSDictionary*)dic;
@end
