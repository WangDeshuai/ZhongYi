//
//  BaoGaiDanModel.m
//  DistributionQuery
//
//  Created by Macx on 17/5/11.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import "BaoGaiDanModel.h"

@implementation BaoGaiDanModel
-(id)initWithBaoGaoDanDic:(NSDictionary*)dic{
    self=[super init];
    if (self) {
        _bgname=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]]];
         _bgid=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"id"]]];
        NSString * sex=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"sex"]]];
        if ([sex isEqualToString:@"M"]) {
            _bgsex=@"男";
        }else{
            _bgsex=@"女";
        }
        
        //病名是个字典
        if ([dic objectForKey:@"diseaseName"]==[NSNull null] ||[dic objectForKey:@"diseaseName"]==nil) {
            _bgbingMing=@"暂无病名";
        }else{
             _bgbingMing=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"diseaseName"]]];
        }
       
        
        _bgtime=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"createTime"]]];
    }
    
    return self;
}
//报告单详情
-(id)initWithBaoGaoDanXiangQingDic:(NSDictionary*)dic{
    self=[super init];
    if (self) {
        //姓名
        _xqname=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]]];
        //性别
        _xqsex=[self quChuLaiStr:[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"sex"]]]];
        //大标题
        _xqtitlename= [self quChuLaiStr:[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"type"]]]];  //;
        //年龄
        _xqage=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"age"]]];
        //舌苔舌质
        _xqsheTai=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"tongue"]]];
        //手术
        _xqshoushu=[self quChuLaiStr:[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"isOperation"]]]];
        
        //脉象
        _xqmaiXiang=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"pulseCondition"]]];
        //TNM分期
        _xqTNM=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"TNM"]]];
        //放疗
        NSString * YN =[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"isRadiotherapy"]]];
        if ([YN isEqualToString:@"Y"]) {
            _xqyouFang=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"radiotherapyCycle"]]];
        }else{
            _xqyouFang=@"无";
        }
     
        //化疗
        NSString * YNN =[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"isChemotherapy"]]];
        if ([YNN isEqualToString:@"Y"]) {
            _xqyouHua=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"chemotherapyCycle"]]];
        }else{
            _xqyouHua=@"无";
        }
        
        //病名
        _xqbingMing=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"diseaseName"]]];
        //病理
        _xqbingLi=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"pathologyName"]]];
        //主诉
         _xqzhusu=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"symptom"]]];
        //主要会诊问题
         _xqzhuyaowenti=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"problem"]]];
        //会诊开方
         _xqhuikaifang=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"content"]]];
        //功效
          _xqgongxiao=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"effect"]]];
    }
    
    return self;
}
-(NSString*)quChuLaiStr:(NSString*)str{
    NSMutableDictionary * dicc =[NSMutableDictionary new];
    [dicc setObject:@"肿瘤会诊" forKey:@"1"];
    [dicc setObject:@"其它疑难杂症" forKey:@"2"];
    [dicc setObject:@"男" forKey:@"M"];
    [dicc setObject:@"女" forKey:@"F"];
    [dicc setObject:@"有" forKey:@"Y"];
    [dicc setObject:@"无" forKey:@"N"];
    
    return [dicc objectForKey:str];
}
@end
