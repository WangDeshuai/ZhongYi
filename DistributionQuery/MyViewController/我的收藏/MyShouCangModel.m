//
//  MyShouCangModel.m
//  DistributionQuery
//
//  Created by Macx on 17/5/18.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import "MyShouCangModel.h"

@implementation MyShouCangModel
-(id)initWithShangCangDic:(NSDictionary*)dic{
    self=[super init];
    if (self) {
        _targetID=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"targetId"]]];
         _type=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"type"]]];
        NSString * typename =[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"type"]]];
         _typeName=[self stingName:typename];
        
        _imagename=[self stingImageName:typename];
        
        
         _titlename=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]]];
    }
    
    return self;
}


-(NSString*)stingName:(NSString*)name{
    NSMutableDictionary * dicc =[NSMutableDictionary new];
    [dicc setObject:@"药" forKey:@"1"];
    [dicc setObject:@"病" forKey:@"2"];
    [dicc setObject:@"讲座" forKey:@"3"];
    [dicc setObject:@"中医医案" forKey:@"4"];
    
    return [dicc objectForKey:name];
    
}
-(NSString*)stingImageName:(NSString*)name{
    NSMutableDictionary * dicc =[NSMutableDictionary new];
    [dicc setObject:@"sc_bing" forKey:@"1"];
    [dicc setObject:@"sc_jz" forKey:@"2"];
    [dicc setObject:@"sc_ya" forKey:@"3"];
    [dicc setObject:@"sc_yao" forKey:@"4"];
    
    return [dicc objectForKey:name];
    
}


@end
