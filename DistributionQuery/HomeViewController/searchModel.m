//
//  searchModel.m
//  DistributionQuery
//
//  Created by Macx on 17/6/9.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import "searchModel.h"

@implementation searchModel
-(id)initWithSearchDic:(NSDictionary*)dic{
    self=[super init];
    if (self) {
        NSString * type =[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"type"]]];
        _type=type;
        if ([type isEqualToString:@"1"]) {
            //药
            _titleName=@"中药";
            _imageName=@"sc_yao";
        }else if ([type isEqualToString:@"2"]){
            //药方
            _titleName=@"方剂";
            _imageName=@"sc_yao";
        }else if ([type isEqualToString:@"3"]){
            //病
            _titleName=@"病种";
            _imageName=@"sc_bing";
        }else if ([type isEqualToString:@"4"]){
            //医案
            _titleName=@"中医医案";
            _imageName=@"sc_ya";
        }else{
            //讲座
            _titleName=@"讲座";
            _imageName=@"sc_jz";
        }
        
        _idd=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"id"]]];
        _contentName=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]]];
        
    }
    
    return self;
}
@end
