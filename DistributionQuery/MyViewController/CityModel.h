//
//  CityModel.h
//  DistributionQuery
//
//  Created by Macx on 17/5/19.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CityModel : NSObject
//省
@property(nonatomic,copy)NSString * shengName;
@property(nonatomic,copy)NSString * shengCode;
@property(nonatomic,copy)NSString * shengID;
-(id)initWithShengDic:(NSDictionary*)dic;
//市
@property(nonatomic,copy)NSString * cityName;
@property(nonatomic,copy)NSString * cityCode;
@property(nonatomic,copy)NSString * cityID;
-(id)initWithCityDic:(NSDictionary*)dic;
//县
@property(nonatomic,copy)NSString * xianName;
@property(nonatomic,copy)NSString * xianCode;
@property(nonatomic,copy)NSString * xianID;
-(id)initWithXianDic:(NSDictionary*)dic;


@end
