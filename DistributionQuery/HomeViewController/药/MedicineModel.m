//
//  MedicineModel.m
//  DistributionQuery
//
//  Created by Macx on 17/4/27.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import "MedicineModel.h"

@implementation MedicineModel
//药
-(id)initWithYaoDic:(NSDictionary*)dic{
    self=[super init];
    if (self) {
        
         _yaoDexName=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"spelling"]]];
        
         _yaoTitleName=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"drugName"]]];
        _yaoImageName=[ToolClass isString:[NSString stringWithFormat:@"%@%@",_yaoTitleName,[dic objectForKey:@"filePath"]]];
        
        _yaoID=[ToolClass isString:[NSString stringWithFormat:@"%@%@",_yaoTitleName,[dic objectForKey:@"id"]]];
    }
    
    return self;
}
//药详情页
-(id)initWithYaoXiangQingDic:(NSDictionary*)dic{
    self=[super init];
    if (self) {
        //图片
          _xqimageName=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"filePath"]]];
        //药名
        _xqYaoName=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"drugName"]]];
        //别名
        _xqYaoBieName=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"byName"]]];
        //性味
        _xqXingWei=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"taste"]]];
        //归经
        _xqGuiJing=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"meridian"]]];
        //功效
        _xqGongXiao=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"effect"]]];
       //主治
        _xqZhuZhi=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"attending"]]];
       //成分
        _xqChengFen=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"activeIngredient"]]];
      //禁忌
        _xqJinJi=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"taboo"]]];
       //毒性
        _xqDuXing=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"toxicity"]]];
       //抗瘤谱
        _xqKangLiPu=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"tumorSpectrum"]]];
      //用法用量
        _xqYongFa=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"method"]]];
       //配伍效用
        _xqPeiWuXiaoYong=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"utility"]]];
        //现代药理研究
        _xqxianDaiYaoLi=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"research"]]];

    }
    
    return self;
}
@end
