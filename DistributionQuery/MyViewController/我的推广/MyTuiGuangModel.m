//
//  MyTuiGuangModel.m
//  DistributionQuery
//
//  Created by Macx on 17/5/19.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import "MyTuiGuangModel.h"

@implementation MyTuiGuangModel
-(id)initWithTuiGuangDic:(NSDictionary*)dic{
    self=[super init];
    if (self) {
        _imagename=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@""]]];
        _titlename=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]]];
        _phonename=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"phone"]]];
        _yaoQingMa=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"inviterSpreadCode"]]];
        _timename=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"createTime"]]];
    }
    
    return self;
}
//我要兑换
-(id)initWithDuiHuanDic:(NSDictionary*)dic{
    self=[super init];
    if (self) {
        _dhimage=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"filePath"]]];
        _dhTitle=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"title"]]];
        _dhContent=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"content"]]];
        _dhID=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"id"]]];
    }
    
    return self;
}
@end
