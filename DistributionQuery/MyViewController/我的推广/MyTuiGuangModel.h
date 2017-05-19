//
//  MyTuiGuangModel.h
//  DistributionQuery
//
//  Created by Macx on 17/5/19.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyTuiGuangModel : NSObject
//我的推广
@property(nonatomic,copy)NSString * imagename;
@property(nonatomic,copy)NSString * titlename;
@property(nonatomic,copy)NSString * phonename;
@property(nonatomic,copy)NSString * yaoQingMa;
@property(nonatomic,copy)NSString * timename;
-(id)initWithTuiGuangDic:(NSDictionary*)dic;

//我要兑换
@property(nonatomic,copy)NSString * dhimage;
@property(nonatomic,copy)NSString * dhTitle;
@property(nonatomic,copy)NSString * dhContent;
@property(nonatomic,copy)NSString * dhID;
-(id)initWithDuiHuanDic:(NSDictionary*)dic;
@end
