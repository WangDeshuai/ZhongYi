//
//  Engine.m
//  DistributionQuery
//
//  Created by Macx on 16/10/8.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "Engine.h"
@implementation Engine
#pragma mark --1.加载所有药品信息
+(void)allYaoPinMessage:(NSString*)nameStr success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
   
    NSString * urlStr =[NSString stringWithFormat:@"%@/api/drug/list",SERVICE];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    NSMutableDictionary * dic =[NSMutableDictionary new];
    [dic setObject:[ToolClass isString:[NSString stringWithFormat:@"%@",nameStr]] forKey:@"drugName"];
    
    [manager POST:urlStr parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"1.加载所有药品信息%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"1.加载所有药品信息%@",error);
        [LCProgressHUD showMessage:@"1.网络超时"];
        aError(error);
        
    }];

}


#pragma mark --2加载药品详细信息
+(void)yaoPinXiangQingMessageYaoID:(NSString*)yaoID success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    
    NSString * urlStr =[NSString stringWithFormat:@"%@/api/drug/view",SERVICE];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    NSMutableDictionary * dic =[NSMutableDictionary new];
    [dic setObject:[ToolClass isString:[NSString stringWithFormat:@"%@",yaoID]] forKey:@"id"];
    
    [manager POST:urlStr parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"2加载药品详细信息%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"2加载药品详细信息%@",error);
        [LCProgressHUD showMessage:@"2.网络超时"];
        aError(error);
        
    }];

    
}
#pragma mark --3加载所有药方信息
+(void)yaoFangJiaZaiAllPage:(NSString*)page SearchStr:(NSString*)nameStr success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    NSString * urlStr =[NSString stringWithFormat:@"%@/api/prescription/list",SERVICE];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    NSMutableDictionary * dic =[NSMutableDictionary new];
    [dic setObject:[ToolClass isString:[NSString stringWithFormat:@"%@",page]] forKey:@"pageIndex"];
    [dic setObject:@"1" forKey:@"type"];
    [dic setObject:@"10" forKey:@"pageSize"];
    [dic setObject:[ToolClass isString:[NSString stringWithFormat:@"%@",nameStr]] forKey:@"name"];
    [manager POST:urlStr parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"3加载所有药方信息%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"3加载所有药方信息%@",error);
        [LCProgressHUD showMessage:@"3.网络超时"];
        aError(error);
        
    }];

    
}

#pragma mark --4加载所有病种分类
+(void)jiaZaiBingZhongClasssuccess:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    
    NSString * urlStr =[NSString stringWithFormat:@"%@/api/disease/category/list",SERVICE];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];

    [manager POST:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"4加载所有病种分类%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"4加载所有病种分类%@",error);
        [LCProgressHUD showMessage:@"4.网络超时"];
        aError(error);
        
    }];
}

#pragma mark --5加载药方详情页
+(void)jiaZaiYaoFangXiangQingYaoID:(NSString*)yaoID success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    
    NSString * urlStr =[NSString stringWithFormat:@"%@/api/prescription/view",SERVICE];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    NSMutableDictionary * dic =[NSMutableDictionary new];
    [dic setObject:[ToolClass isString:[NSString stringWithFormat:@"%@",yaoID]] forKey:@"id"];
    [manager POST:urlStr parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"5加载药方详情页%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"5加载药方详情页%@",error);
        [LCProgressHUD showMessage:@"5.网络超时"];
        aError(error);
        
    }];

}

#pragma mark --6病种分类详情页
+(void)bingZhongFenLeiXiangXiID:(NSString*)bzid success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    
    NSString * urlStr =[NSString stringWithFormat:@"%@/api/prescription/queryByCategoryId",SERVICE];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    NSMutableDictionary * dic =[NSMutableDictionary new];
    [dic setObject:[ToolClass isString:[NSString stringWithFormat:@"%@",bzid]] forKey:@"categoryId"];
     [dic setObject:@"" forKey:@"pageSize"];
     [dic setObject:@"" forKey:@"pageIndex"];
    [manager POST:urlStr parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"6病种分类详情页%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"6病种分类详情页%@",error);
        [LCProgressHUD showMessage:@"6.网络超时"];
        aError(error);
        
    }];
    
}
#pragma mark --7根据病种分类加载病的详情信息（病详情）
+(void)BingZhongXiangQingClassID:(NSString*)idd success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    
    NSString * urlStr =[NSString stringWithFormat:@"%@/api/disease/view?categoryId=%@",SERVICE,idd];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
//    NSMutableDictionary * dic =[NSMutableDictionary new];
//    [dic setObject:[ToolClass isString:[NSString stringWithFormat:@"%@",idd]] forKey:@"categoryId"];
   
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"7根据病种分类加载病的详情信息（病详情）%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"7根据病种分类加载病的详情信息（病详情）%@",error);
        [LCProgressHUD showMessage:@"7.网络超时"];
        aError(error);
        
    }];
}
#pragma mark --8分页加载中医医案信息(首页)
+(void)FirstJiaZaiYiAnMessagePage:(NSString*)page PageSize:(NSString*)pagesize success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    
    NSString * urlStr =[NSString stringWithFormat:@"%@/api/consilia/list",SERVICE];
    //urlStr= [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    NSMutableDictionary * dic =[NSMutableDictionary new];
        [dic setObject:[ToolClass isString:[NSString stringWithFormat:@"%@",page]] forKey:@"pageIndex"];
    [dic setObject:[ToolClass isString:[NSString stringWithFormat:@"%@",pagesize]] forKey:@"pageSize"];
    
    [manager POST:urlStr parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"8分页加载中医医案信息(首页)%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"8分页加载中医医案信息(首页)%@",error);
        [LCProgressHUD showMessage:@"8.网络超时"];
        aError(error);
        
    }];
}
#pragma mark --9根据病种分类加载中医医案信息(中医医案)
+(void)ZhongYiYiAnMessageID:(NSString *)idd Page:(NSString*)page PageSize:(NSString*)size success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    
    NSString * urlStr =[NSString stringWithFormat:@"%@/api/consilia/queryByCategoryId",SERVICE];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    NSMutableDictionary * dic =[NSMutableDictionary new];
    [dic setObject:[ToolClass isString:[NSString stringWithFormat:@"%@",idd]] forKey:@"categoryId"];
    
    [dic setObject:[ToolClass isString:[NSString stringWithFormat:@"%@",page]] forKey:@"pageIndex"];
    [dic setObject:[ToolClass isString:[NSString stringWithFormat:@"%@",size]] forKey:@"pageSize"];
    
    [manager POST:urlStr parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"9根据病种分类加载中医医案信息(中医医案)%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"9根据病种分类加载中医医案信息(中医医案)）%@",error);
        [LCProgressHUD showMessage:@"9.网络超时"];
        aError(error);
        
    }];
}
#pragma mark --10.点击某个医案加载中医医案详情
+(void)YiAnXiangQingMessageID:(NSString*)idd success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    
    NSString * urlStr =[NSString stringWithFormat:@"%@/api/consilia/view",SERVICE];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    NSMutableDictionary * dic =[NSMutableDictionary new];
    [dic setObject:[ToolClass isString:[NSString stringWithFormat:@"%@",idd]] forKey:@"id"];
    
    [manager POST:urlStr parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"10.点击某个医案加载中医医案详情%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"10.点击某个医案加载中医医案详情%@",error);
        [LCProgressHUD showMessage:@"10.网络超时"];
        aError(error);
        
    }];
    
    
}
#pragma mark --11.分页加载所有讲座信息
+(void)jiaZaiJiangZuoAllMessagePage:(NSString*)page success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    NSString * urlStr =[NSString stringWithFormat:@"%@/api/video/list",SERVICE];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    NSMutableDictionary * dic =[NSMutableDictionary new];
    [dic setObject:[ToolClass isString:[NSString stringWithFormat:@"%@",@"10"]] forKey:@"pageSize"];
     [dic setObject:[ToolClass isString:[NSString stringWithFormat:@"%@",page]] forKey:@"pageIndex"];
    
    [manager POST:urlStr parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"11.分页加载所有讲座信息%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"11.分页加载所有讲座信息%@",error);
        [LCProgressHUD showMessage:@"11.网络超时"];
        aError(error);
        
    }];
    
    
}
#pragma mark --12.根据病种分类加载讲座信息(讲座)
+(void)jiangZuoBingZhongID:(NSString*)idd Page:(NSString*)page PageSize:(NSString*)pagesize success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    
    NSString * urlStr =[NSString stringWithFormat:@"%@/api/video/queryByCategoryId",SERVICE];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    NSMutableDictionary * dic =[NSMutableDictionary new];
    [dic setObject:[ToolClass isString:[NSString stringWithFormat:@"%@",idd]] forKey:@"categoryId"];
    [dic setObject:[ToolClass isString:[NSString stringWithFormat:@"%@",page]] forKey:@"pageIndex"];
    [dic setObject:[ToolClass isString:[NSString stringWithFormat:@"%@",pagesize]] forKey:@"pageSize"];
    
    [manager POST:urlStr parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"12.根据病种分类加载讲座信息(讲座)%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"12.根据病种分类加载讲座信息(讲座)%@",error);
        [LCProgressHUD showMessage:@"12.网络超时"];
        aError(error);
        
    }];
}

#pragma mark --13.点击某个讲座后加载讲座详情
+(void)jiangZuoXiangQingMeessageID:(NSString*)mesID success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    
    
    NSString * urlStr =[NSString stringWithFormat:@"%@/api/video/view",SERVICE];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    NSMutableDictionary * dic =[NSMutableDictionary new];
    [dic setObject:[ToolClass isString:[NSString stringWithFormat:@"%@",mesID]] forKey:@"id"];
    
    [manager POST:urlStr parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"13.点击某个讲座后加载讲座详情%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"13.点击某个讲座后加载讲座详情%@",error);
        [LCProgressHUD showMessage:@"13.网络超时"];
        aError(error);
        
    }];
    
}


#pragma mark --14.分页加载所有的积分商品信息
+(void)shangPinJiaZaiMessage:(NSString*)page success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    
    NSString * urlStr =[NSString stringWithFormat:@"%@/api/images/list",SERVICE];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    NSMutableDictionary * dic =[NSMutableDictionary new];
    [dic setObject:[ToolClass isString:[NSString stringWithFormat:@"%@",page]] forKey:@"pageIndex"];
    [dic setObject:[ToolClass isString:[NSString stringWithFormat:@"%@",@"10"]] forKey:@"pageSize"];
    
    [manager POST:urlStr parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"14.分页加载所有的积分商品信息%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"14.分页加载所有的积分商品信息%@",error);
        [LCProgressHUD showMessage:@"14.网络超时"];
        aError(error);
        
    }];
}


#pragma mark --16.加载所有的舌苔信息
+(void)jiaZaiAllSheMessagesuccess:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    
    NSString * urlStr =[NSString stringWithFormat:@"%@/api/report/queryCoatedTongues",SERVICE];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
   
    
    [manager POST:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"16.加载所有的舌苔信息%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"16.加载所有的舌苔信息%@",error);
        [LCProgressHUD showMessage:@"16.网络超时"];
        aError(error);
        
    }];
}
#pragma mark --17.加载所有的舌质信息
+(void)jiaZaiAllSheZhiMessagesuccess:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    
    NSString * urlStr =[NSString stringWithFormat:@"%@/api/report/queryTongueNatures",SERVICE];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    
    
    [manager POST:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"17.加载所有的舌质信息%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"17.加载所有的舌质信息%@",error);
        [LCProgressHUD showMessage:@"17.网络超时"];
        aError(error);
        
    }];
}
#pragma mark --19.加载所有的脉象信息
+(void)jiaZaiAllMaiXiangMessagesuccess:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    
    NSString * urlStr =[NSString stringWithFormat:@"%@/api/report/queryPulseConditions",SERVICE];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    
    [manager POST:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"19.加载所有的脉象信息%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"19.加载所有的脉象信息%@",error);
        [LCProgressHUD showMessage:@"19.网络超时"];
        aError(error);
        
    }];
}
#pragma mark --20.加载所有的病理信息
+(void)jiaZaiBingLiMessagesuccess:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    
    NSString * urlStr =[NSString stringWithFormat:@"%@/api/pathology/list",SERVICE];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    
    [manager POST:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"20.加载所有的病理信息%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"20.加载所有的病理信息%@",error);
        [LCProgressHUD showMessage:@"20.网络超时"];
        aError(error);
        
    }];
}
#pragma mark --21.加载所有的病种分类信息
+(void)jiaZaiBingMingAllMessageID:(NSString*)idd success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    NSString * urlStr =[NSString stringWithFormat:@"%@/api/disease/category/queryCategorys",SERVICE];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    NSMutableDictionary * dic =[NSMutableDictionary new];
    [dic setObject:[ToolClass isString:[NSString stringWithFormat:@"%@",idd]] forKey:@"parentId"];
    [manager POST:urlStr parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"21.加载所有的病种分类信息%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"21.加载所有的病种分类信息%@",error);
        [LCProgressHUD showMessage:@"21.网络超时"];
        aError(error);
        
    }];
}
#pragma mark --22.加载所有的主诉信息
+(void)jiaZaiZhuSuMessageID:(NSString*)idd success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    
    NSString * urlStr =[NSString stringWithFormat:@"%@/api/symptom/list",SERVICE];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    NSMutableDictionary * dic =[NSMutableDictionary new];
    [dic setObject:[ToolClass isString:[NSString stringWithFormat:@"%@",idd]] forKey:@"parentId"];
    [manager POST:urlStr parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"22.加载所有的主诉信息%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"22.加载所有的主诉信息%@",error);
        [LCProgressHUD showMessage:@"22.网络超时"];
        aError(error);
        
    }];
    
}

#pragma mark --23.加载所有的地区（省、市、区县）信息
+(void)shengShiXianDiQu:(NSString*)idd success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    
    NSString * urlStr =[NSString stringWithFormat:@"%@/api/nation/queryAllProOrDis",SERVICE];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    NSMutableDictionary * dic =[NSMutableDictionary new];
    [dic setObject:[ToolClass isString:[NSString stringWithFormat:@"%@",idd]] forKey:@"parentId"];
    [manager POST:urlStr parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"23.加载所有的地区（省、市、区县）信息%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"23.加载所有的地区（省、市、区县）信息%@",error);
        [LCProgressHUD showMessage:@"23.网络超时"];
        aError(error);
        
    }];
    
}
#pragma mark --加载市
+(void)CityID:(NSString*)idd success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    NSString * urlStr =[NSString stringWithFormat:@"%@/api/nation/queryCitiesByParentId",SERVICE];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    NSMutableDictionary * dic =[NSMutableDictionary new];
    [dic setObject:[ToolClass isString:[NSString stringWithFormat:@"%@",idd]] forKey:@"parentId"];
    [manager POST:urlStr parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"23.加载所有的地区（省、市、区县）信息%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"23.加载所有的地区（省、市、区县）信息%@",error);
        [LCProgressHUD showMessage:@"23.网络超时"];
        aError(error);
        
    }];
    
    
}



#pragma mark --24.分页加载所有我的报告单信息
+(void)baoGaiDanPage:(NSString*)page  success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    
    NSString * urlStr =[NSString stringWithFormat:@"%@/api/report/list",SERVICE];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    NSString * token =[NSUSE_DEFO objectForKey:@"token"];
    if (token==nil) {
        [LCProgressHUD showMessage:@"33请登录"];
        return;
    }
    
    
    NSMutableDictionary * dic =[NSMutableDictionary new];
    [dic setObject:[ToolClass isString:[NSString stringWithFormat:@"%@",page]] forKey:@"pageIndex"];
    [dic setObject:[ToolClass isString:[NSString stringWithFormat:@"%@",@"10"]] forKey:@"pageSize"];
    [dic setObject:token forKey:@"phone"];
    
    [manager POST:urlStr parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"24.分页加载所有我的报告单信息%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"24.分页加载所有我的报告单信息%@",error);
        [LCProgressHUD showMessage:@"24.网络超时"];
        aError(error);
        
    }];
    
}
#pragma mark --25.加载我的报告单详情信息
+(void)baoGaiDanXiangQingMessageID:(NSString*)idd success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    
    NSString * urlStr =[NSString stringWithFormat:@"%@/api/report/view",SERVICE];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    NSMutableDictionary * dic =[NSMutableDictionary new];
    [dic setObject:[ToolClass isString:[NSString stringWithFormat:@"%@",idd]] forKey:@"id"];
   
    
    [manager POST:urlStr parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"25.加载我的报告单详情信息%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"25.加载我的报告单详情信息%@",error);
        [LCProgressHUD showMessage:@"25.网络超时"];
        aError(error);
        
    }];
    
}
#pragma mark --26.编辑我的报告单信息
+(void)bianJiMyBaoGaoDanMessage:(NSString*)idd success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    NSString * urlStr =[NSString stringWithFormat:@"%@/api/report/edit",SERVICE];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    NSMutableDictionary * dic =[NSMutableDictionary new];
    [dic setObject:[ToolClass isString:[NSString stringWithFormat:@"%@",idd]] forKey:@"id"];
    
    
    [manager POST:urlStr parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"26.编辑我的报告单信息%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"26.编辑我的报告单信息%@",error);
        [LCProgressHUD showMessage:@"26.网络超时"];
        aError(error);
        
    }];
    
}
#pragma mark --27.新增我的报告单信息
+(void)saveBaoGaoDanID:(NSString*)idd Type:(NSString*)leiXing XingMing:(NSString*)name Sex:(NSString*)sex Age:(NSString*)age BingMingID:(NSString*)bingMing ZhuSuID:(NSString*)zhusu BingLiID:(NSString*)bingli MaiXiangID:(NSString*)maixiang SheZhiID:(NSString*)shezhi SheTaiID:(NSString*)shetai YouWuFangYN:(NSString*)yn FangZhouQi:(NSString*)zhouqi HuaYN:(NSString*)ynn HuaZhouQi:(NSString*)zhouq ShouShuID:(NSString*)shoushu TNMfen:(NSString*)tnm Pro:(NSString*)pro success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    
    NSString * urlStr =[NSString stringWithFormat:@"%@/api/report/save",SERVICE];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    
    NSString * token= [NSUSE_DEFO objectForKey:@"token"];
    if (token==nil) {
        [LCProgressHUD showMessage:@"27请登录"];
        return;
    }
    
    
    NSMutableDictionary * dic =[NSMutableDictionary new];
     [dic setObject:[ToolClass isString:[NSString stringWithFormat:@"%@",idd]] forKey:@"id"];//1.idd
     [dic setObject:[ToolClass isString:[NSString stringWithFormat:@"%@",leiXing]] forKey:@"type"];//2.报告单类型
     [dic setObject:[ToolClass isString:[NSString stringWithFormat:@"%@",name]] forKey:@"name"];//3.姓名
     [dic setObject:[ToolClass isString:[NSString stringWithFormat:@"%@",sex]] forKey:@"sex"];//4.性别
     [dic setObject:[ToolClass isString:[NSString stringWithFormat:@"%@",age]] forKey:@"age"];//5.年龄
     [dic setObject:[ToolClass isString:[NSString stringWithFormat:@"%@",bingMing]] forKey:@"categoryId"];//6.病名
     [dic setObject:[ToolClass isString:[NSString stringWithFormat:@"%@",zhusu]] forKey:@"symptomIds"];//7.主诉
     [dic setObject:[ToolClass isString:[NSString stringWithFormat:@"%@",bingli]] forKey:@"pathologyId"];//8.病理
     [dic setObject:[ToolClass isString:[NSString stringWithFormat:@"%@",maixiang]] forKey:@"pulseConditionId"];//9.脉象
     [dic setObject:[ToolClass isString:[NSString stringWithFormat:@"%@",shezhi]] forKey:@"tongueNatureId"];//10.舌质
     [dic setObject:[ToolClass isString:[NSString stringWithFormat:@"%@",shetai]] forKey:@"coatedTongueId"];//11.舌苔
     [dic setObject:[ToolClass isString:[NSString stringWithFormat:@"%@",yn]] forKey:@"isRadiotherapy"];//12.有无放疗
     [dic setObject:[ToolClass isString:[NSString stringWithFormat:@"%@",zhouqi]] forKey:@"radiotherapyCycle"];//13.放疗周期
     [dic setObject:[ToolClass isString:[NSString stringWithFormat:@"%@",ynn]] forKey:@"isChemotherapy"];//14.有无化疗
     [dic setObject:[ToolClass isString:[NSString stringWithFormat:@"%@",zhouq]] forKey:@"chemotherapyCycle"];//15.化疗周期
     [dic setObject:[ToolClass isString:[NSString stringWithFormat:@"%@",shoushu]] forKey:@"isOperation"];//16.手术
     [dic setObject:[ToolClass isString:[NSString stringWithFormat:@"%@",tnm]] forKey:@"TNM"];//17.TNM分期
     [dic setObject:[ToolClass isString:[NSString stringWithFormat:@"%@",pro]] forKey:@"problem"];//18.主要会诊问题
    
    
    
    [dic setObject:[ToolClass isString:[NSString stringWithFormat:@"%@",token]] forKey:@"phone"];
    [manager POST:urlStr parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"27.新增我的报告单信息%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"27.新增我的报告单信息%@",error);
        [LCProgressHUD showMessage:@"27.网络超时"];
        aError(error);
        
    }];
    
}
#pragma mark --28.更新报告单信息
+(void)saveGengXinBaoGaoDanMessageID:(NSString*)idd MessageName:(NSString*)name MessageSex:(NSString*)sex Age:(NSString*)age success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    
    NSString * urlStr =[NSString stringWithFormat:@"%@/api/report/editSave",SERVICE];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    NSMutableDictionary * dic =[NSMutableDictionary new];
    
    [dic setObject:[ToolClass isString:idd] forKey:@"id"];
    [dic setObject:[ToolClass isString:[NSString stringWithFormat:@"%@",name]] forKey:@"name"];
    [dic setObject:[ToolClass isString:[NSString stringWithFormat:@"%@",sex]] forKey:@"sex"];
    [dic setObject:[ToolClass isString:[NSString stringWithFormat:@"%@",age]] forKey:@"age"];
    
    [manager POST:urlStr parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"30.分页加载我的收藏信息%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"30.分页加载我的收藏信息%@",error);
        [LCProgressHUD showMessage:@"30.网络超时"];
        aError(error);
        
    }];

    
}
#pragma mark --30.分页加载我的收藏信息
+(void)shouCangPage:(NSString*)page  success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    
    NSString * urlStr =[NSString stringWithFormat:@"%@/api/collection/list",SERVICE];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    NSMutableDictionary * dic =[NSMutableDictionary new];
    NSString * token =[NSUSE_DEFO objectForKey:@"token"];
    if (token==nil) {
        [LCProgressHUD showMessage:@"30请登录"];
        return;
    }
    
    [dic setObject:token forKey:@"phone"];
    [dic setObject:[ToolClass isString:[NSString stringWithFormat:@"%@",@"10"]] forKey:@"pageSize"];
    [dic setObject:[ToolClass isString:[NSString stringWithFormat:@"%@",page]] forKey:@"pageIndex"];
    
    [manager POST:urlStr parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"30.分页加载我的收藏信息%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"30.分页加载我的收藏信息%@",error);
        [LCProgressHUD showMessage:@"30.网络超时"];
        aError(error);
        
    }];
    
}

#pragma mark --31.保存我的收藏信息
+(void)shouCangSaveStype:(NSString*)type MessageID:(NSString*)messageid uccess:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    NSString * urlStr =[NSString stringWithFormat:@"%@/api/collection/save",SERVICE];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    NSMutableDictionary * dic =[NSMutableDictionary new];
    NSString * token =[NSUSE_DEFO objectForKey:@"token"];
    if (token==nil) {
        [LCProgressHUD showMessage:@"31.保存我的收藏信息请登录"];
        return;
    }
    
    [dic setObject:token forKey:@"phone"];
    [dic setObject:[ToolClass isString:[NSString stringWithFormat:@"%@",type]] forKey:@"type"];
    [dic setObject:[ToolClass isString:[NSString stringWithFormat:@"%@",messageid]] forKey:@"targetId"];
    
    [manager POST:urlStr parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"31.保存我的收藏信息%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"31.保存我的收藏信息%@",error);
        [LCProgressHUD showMessage:@"31.网络超时"];
        aError(error);
        
    }];
}
#pragma mark --验证我的收藏信息
+(void)YanZhengMyShouCangMessageID:(NSString*)messageID Type:(NSString*)type success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    
    NSString * urlStr =[NSString stringWithFormat:@"%@/api/collection/validate",SERVICE];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    NSMutableDictionary * dic =[NSMutableDictionary new];
    NSString * token =[NSUSE_DEFO objectForKey:@"token"];
    if (token==nil) {
        [LCProgressHUD showMessage:@"验证我的收藏信息"];
        return;
    }
    
    [dic setObject:token forKey:@"phone"];
    [dic setObject:[ToolClass isString:[NSString stringWithFormat:@"%@",type]] forKey:@"type"];
    [dic setObject:[ToolClass isString:[NSString stringWithFormat:@"%@",messageID]] forKey:@"targetId"];
    
    [manager POST:urlStr parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"验证我的收藏信息%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"验证我的收藏信息%@",error);
        [LCProgressHUD showMessage:@"验证我的收藏信息"];
        aError(error);
        
    }];
    
}
#pragma mark --32加载我的推广信息
+(void)jiaZaiTuiGuangMessagesuccess:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    
    NSString * urlStr =[NSString stringWithFormat:@"%@/api/member/myExtension",SERVICE];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    NSMutableDictionary * dic =[NSMutableDictionary new];
    NSString * token =[NSUSE_DEFO objectForKey:@"token"];
    if (token==nil) {
        [LCProgressHUD showMessage:@"32请登录"];
        return;
    }
    [dic setObject:token forKey:@"phone"];
    
    [manager POST:urlStr parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"32加载我的推广信息%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"32加载我的推广信息%@",error);
        [LCProgressHUD showMessage:@"32.网络超时"];
        aError(error);
        
    }];
    
}
#pragma mark --33.加载个人主页
+(void)chaXunMyZhuYesuccess:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    
    NSString * urlStr =[NSString stringWithFormat:@"%@/api/member/index",SERVICE];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    NSMutableDictionary * dic =[NSMutableDictionary new];
    
    NSString * token =[NSUSE_DEFO objectForKey:@"token"];
    if (token==nil) {
        [LCProgressHUD showMessage:@"33请登录"];
        return;
    }
    [dic setObject:token forKey:@"phone"];
    
    [manager POST:urlStr parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"33.加载个人主页%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"33.加载个人主页%@",error);
        [LCProgressHUD showMessage:@"33.网络超时"];
        aError(error);
        
    }];
    
}
#pragma mark --34.注册会员信息
+(void)registerMessagePhone:(NSString*)phone Password:(NSString*)psw  ResPassword:(NSString*)pswTwo  YaoQingMa:(NSString*)yaoqing YanZhengMa:(NSString*)code success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    
    NSString * urlStr =[NSString stringWithFormat:@"%@/api/member/register",SERVICE];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    NSMutableDictionary * dic =[NSMutableDictionary new];
    [dic setObject:[ToolClass isString:[NSString stringWithFormat:@"%@",phone]] forKey:@"phone"];
    [dic setObject:[ToolClass isString:[NSString stringWithFormat:@"%@",psw]] forKey:@"password"];
    [dic setObject:[ToolClass isString:[NSString stringWithFormat:@"%@",pswTwo]] forKey:@"resPassword"];
    [dic setObject:[ToolClass isString:[NSString stringWithFormat:@"%@",yaoqing]] forKey:@"inviterSpreadCode"];
    [dic setObject:[ToolClass isString:[NSString stringWithFormat:@"%@",code]] forKey:@"verifyCode"];
    
    [manager POST:urlStr parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"34.注册会员信息%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"34.注册会员信息%@",error);
        [LCProgressHUD showMessage:@"34.网络超时"];
        aError(error);
        
    }];
    
    
}

#pragma mark-- 35.会员登录
+(void)loginAppPhone:(NSString*)phone Password:(NSString*)psw success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    
    NSString * urlStr =[NSString stringWithFormat:@"%@/api/member/login",SERVICE];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    NSMutableDictionary * dic =[NSMutableDictionary new];
    [dic setObject:[ToolClass isString:[NSString stringWithFormat:@"%@",phone]] forKey:@"phone"];
    [dic setObject:[ToolClass isString:[NSString stringWithFormat:@"%@",psw]] forKey:@"password"];
    
    
    [manager POST:urlStr parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"35.会员登录%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"35.会员登录%@",error);
        [LCProgressHUD showMessage:@"35.网络超时"];
        aError(error);
        
    }];
}





#pragma mark --36.个人主页保存信息
+(void)myZhuYeSaveMessageCanShuName:(NSString*)name ValueName:(NSString*)value  success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    
    NSString * urlStr =[NSString stringWithFormat:@"%@/api/member/save",SERVICE];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
   
    NSString * token =[NSUSE_DEFO objectForKey:@"token"];
    if (token==nil) {
        [LCProgressHUD showMessage:@"36请登录"];
        return;
    }
   
    
    NSMutableDictionary * dic =[NSMutableDictionary new];
    [dic setObject:[ToolClass isString:[NSString stringWithFormat:@"%@",value]] forKey:name];
    [dic setObject:token forKey:@"phone"];
    
    [manager POST:urlStr parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"36.个人主页保存信息%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"36.个人主页保存信息%@",error);
        [LCProgressHUD showMessage:@"36.网络超时"];
        aError(error);
        
    }];
    
    
}
#pragma mark --37.会员头像修改
+(void)headImage:(UIImage*)image success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    NSString * urlStr =[NSString stringWithFormat:@"%@/api/member/changeHead",SERVICE];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    NSString * token =[NSUSE_DEFO objectForKey:@"token"];
    if (token==nil) {
        [LCProgressHUD showMessage:@"37请登录"];
        return;
    }

    
    NSData *data = UIImageJPEGRepresentation(image, 0);
    NSMutableDictionary * dic =[NSMutableDictionary new];
    [dic setObject:token forKey:@"phone"];
    
    [manager POST:urlStr parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        NSDateFormatter *formmettrt = [[NSDateFormatter alloc]init];
        [formmettrt setDateFormat:@"yyyyMMddHHmmss"];
         NSString *imagetype=@"jpg";
        [formData appendPartWithFileData:data name:@"head" fileName:[NSString stringWithFormat:@"%@.%@", [formmettrt stringFromDate:[NSDate date]], imagetype] mimeType:[NSString stringWithFormat:@"image/%@", imagetype]];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"37.会员头像修改%@",str);
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"上传失败%@>>>",error);
         aError(error);
    }];
    
    
}
#pragma mark --38.会员修改密码
+(void)XiuGaiPassWordYuan:(NSString*)oldWord NewWord:(NSString*)newword success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    
    NSString * urlStr =[NSString stringWithFormat:@"%@/api/member/changePass",SERVICE];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    
    NSString * token =[NSUSE_DEFO objectForKey:@"token"];
    if (token==nil) {
        [LCProgressHUD showMessage:@"38请登录"];
        return;
    }
    
    
    NSMutableDictionary * dic =[NSMutableDictionary new];
    [dic setObject:[ToolClass isString:[NSString stringWithFormat:@"%@",oldWord]] forKey:@"old_password"];
    [dic setObject:[ToolClass isString:[NSString stringWithFormat:@"%@",newword]] forKey:@"new_password"];
    [dic setObject:token forKey:@"phone"];
    
    [manager POST:urlStr parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"38.会员修改密码%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"38.会员修改密码%@",error);
        [LCProgressHUD showMessage:@"38.网络超时"];
        aError(error);
        
    }];
}
#pragma mark --40.加载所有的病种分类信息（适用于药方页加载病种分类的接口）
+(void)yaoFangClassFenLeisuccess:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    NSString * urlStr =[NSString stringWithFormat:@"%@/api/disease/category/queryPreCategorys",SERVICE];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    
    [manager POST:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"40.加载所有的病种分类信息%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"40.加载所有的病种分类信息%@",error);
        [LCProgressHUD showMessage:@"40.网络超时"];
        aError(error);
        
    }];

}
#pragma mark --41.加载所有的病种分类信息（适用于病名页加载病种分类的接口）
+(void)bingMingFenLeisuccess:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    
    NSString * urlStr =[NSString stringWithFormat:@"%@/api/disease/category/queryDisCategorys",SERVICE];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    
    [manager POST:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"41.加载所有的病种分类信息%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"41.加载所有的病种分类信息%@",error);
        [LCProgressHUD showMessage:@"41.网络超时"];
        aError(error);
        
    }];
}
#pragma mark--42.加载首页轮播图
+(void)shouYiFirstLunBosuccess:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    NSString * urlStr =[NSString stringWithFormat:@"%@/api/changeimg/list",SERVICE];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    
    [manager POST:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"42.加载首页轮播图%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"42.加载首页轮播图%@",error);
        [LCProgressHUD showMessage:@"42.网络超时"];
        aError(error);
        
    }];

}
#pragma mark --43.首页全局搜索
+(void)searchFirstKeyWord:(NSString*)name success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    NSString * urlStr =[NSString stringWithFormat:@"%@/api/changeimg/queryAll",SERVICE];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    NSMutableDictionary * dic =[NSMutableDictionary new];
    [dic setObject:name forKey:@"name"];
    
    [manager POST:urlStr parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"43.首页全局搜索%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"43.首页全局搜索%@",error);
        [LCProgressHUD showMessage:@"43.网络超时"];
        aError(error);
        
    }];
}
@end
