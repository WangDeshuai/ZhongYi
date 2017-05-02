//
//  YaoFangModel.m
//  DistributionQuery
//
//  Created by Macx on 17/5/2.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import "YaoFangModel.h"

@implementation YaoFangModel
//药方列表页
-(id)initWithYaoListViewDic:(NSDictionary*)dic{
    self=[super init];
    if (self) {
        _name=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]]];
        _yaoID=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"id"]]];
    }
    
    return self;
}

//药方分类
-(id)initWithYaoClassViewDic:(NSDictionary*)dic{
    self=[super init];
    if (self) {
        _yaoFangClass=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]]];
        _yaoClassID=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"id"]]];
    }
    
    return self;
}
@end
