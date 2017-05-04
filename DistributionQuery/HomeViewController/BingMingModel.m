//
//  BingMingModel.m
//  DistributionQuery
//
//  Created by Macx on 17/5/4.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import "BingMingModel.h"

@implementation BingMingModel
//病名详情
-(id)initWithBingMingXiangQingDic:(NSDictionary*)dic{
    self=[super init];
    if (self) {
        //病名
        _xqBingName=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"diseaseName"]]];
        //中医病名
        _xqzyBingName=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"diseaseName"]]];
        //定义
        _xqDingYi=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"define"]]];
        //病因病机
        _xqBingYin=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"pathogeny"]]];
        //临床表现
        _xqLinChuang=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"performance"]]];
        //诊断
        _xqZhenDuan=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"diagnosis"]]];
        //鉴别诊断
        _xqJianBie=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"treatment"]]];
        //常规治疗
        _xqChangGui=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"differentialDiagnosis"]]];

    }
    
    return self;
}
@end
