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
//药方列表详情页
-(id)initWithYaoFangXiangQingDic:(NSDictionary*)dic{
    self=[super init];
    if (self) {
        //方名
        _xqfangMing=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]]];
        
        NSArray * zuchengArr =[dic objectForKey:@"comprises"];
        NSMutableArray * nameArr =[NSMutableArray new];
        for (NSDictionary * dicc  in zuchengArr) {
            NSString * zName =[ToolClass isString:[NSString stringWithFormat:@"%@",[dicc objectForKey:@"drug_name"]]];
            NSString * zKeShu=[ToolClass isString:[NSString stringWithFormat:@"%@",[dicc objectForKey:@"value"]]];
            NSString * zk =[NSString stringWithFormat:@"%@%@",zName,zKeShu];
            [nameArr addObject:zk];
        }
        

        //组成
        _xqzuCheng=[nameArr componentsJoinedByString:@""];
        //功效
        _xqgongXiao=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"effect"]]];
        //主治
        _xqzhuZhi=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"attending"]]];
        //方解
        _xqfangJie=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"solve"]]];
        //用法
        _xqyongFa=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"method"]]];
        //禁忌
        _xqjinJi=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"taboo"]]];
        //注意事项
        _xqzhuYiShiXiang=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"annotation"]]];
       
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
//药方分类详情
-(id)initWithFenLeiXiangQingDic:(NSDictionary*)dic{
    self=[super init];
    if (self) {
        _fenleiID=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"id"]]];
        _gongclassxiao=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"effect"]]];
         _titleclassname=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]]];
    }
    
    return self;
}
@end
