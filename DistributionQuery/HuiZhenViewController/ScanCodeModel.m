//
//  ScanCodeModel.m
//  DistributionQuery
//
//  Created by Macx on 17/5/7.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import "ScanCodeModel.h"

@implementation ScanCodeModel
//病名model
-(id)initWithBingMingDic:(NSDictionary*)dic{
    self=[super init];
    if (self) {
        _bingMingID=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"id"]]];
        _bingMingName=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]]];
    }
    
    return self;
}
//病理
-(id)initWithBingLiDic:(NSDictionary*)dic{
    self=[super init];
    if (self) {
        _bingLiID=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"id"]]];
        _bingLiName=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]]];
    }
    
    return self;
}
//舌苔
-(id)initWithSheTaiDic:(NSDictionary*)dic{
    self=[super init];
    if (self) {
        _sheTaiID=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"id"]]];
        _sheTaiName=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]]];
    }
    return self;
}
//舌质model
-(id)initWithSheZhiDic:(NSDictionary*)dic{
    self=[super init];
    if (self) {
        _sheZhiID=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"id"]]];
        _sheZhiName=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]]];
    }
    
    return self;
}
//脉象model
-(id)initWithMaiXiangDic:(NSDictionary*)dic{
    self=[super init];
    if (self) {
        _maiXiangID=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"id"]]];
        _maiXiangName=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]]];
    }
    
    return self;
}
//住宿model
-(id)initWithZhuSuDic:(NSDictionary*)dic{
    self=[super init];
    if (self) {
        _zhuSuID=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"id"]]];
        _zhuSuName=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]]];
    }
    
    return self;
}
@end
