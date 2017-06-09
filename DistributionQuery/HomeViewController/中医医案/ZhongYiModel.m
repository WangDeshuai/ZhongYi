//
//  ZhongYiModel.m
//  DistributionQuery
//
//  Created by Macx on 17/5/4.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import "ZhongYiModel.h"

@implementation ZhongYiModel
//中医医案
-(id)initWithZhongYiDic:(NSDictionary*)dic{
    self=[super init];
    if (self) {
        
//        NSDictionary * categoryDic =[dic objectForKey:@"category"];
      
        _titlename=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"categoryName"]]];
        _contentName=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"patientCondition"]]];
        
        _zhongYiID=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"id"]]];
        _timeStr=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"createTime"]]];

    }
    
    return self;
}
@end
