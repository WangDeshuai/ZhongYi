//
//  CityModel.m
//  DistributionQuery
//
//  Created by Macx on 17/5/19.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import "CityModel.h"

@implementation CityModel
//省
-(id)initWithShengDic:(NSDictionary*)dic{
    self=[super init];
    if (self) {
        _shengName=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"province"]]];
        _shengCode=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]]];
        _shengID=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"id"]]];
    }
    
    return self;
}

//市
-(id)initWithCityDic:(NSDictionary*)dic{
    self=[super init];
    if (self) {
        _cityName=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"city"]]];
        _cityCode=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]]];
         _cityID=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"id"]]];
    }
    
    return self;
}
//县
-(id)initWithXianDic:(NSDictionary*)dic{
    self=[super init];
    if (self) {
        _xianName=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"district"]]];
        _xianCode=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]]];
        _xianID=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"id"]]];
        
    }
    
    return self;
}
@end
