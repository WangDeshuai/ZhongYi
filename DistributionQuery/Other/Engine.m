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
    
    NSString * urlStr =[NSString stringWithFormat:@"%@/api/nation/list",SERVICE];
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
+(void)baoGaiDanPage:(NSString*)page memBerID:(NSString*)idd success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    
    NSString * urlStr =[NSString stringWithFormat:@"%@/api/report/list",SERVICE];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    NSMutableDictionary * dic =[NSMutableDictionary new];
    [dic setObject:[ToolClass isString:[NSString stringWithFormat:@"%@",page]] forKey:@"pageIndex"];
    [dic setObject:[ToolClass isString:[NSString stringWithFormat:@"%@",@"10"]] forKey:@"pageSize"];
    [dic setObject:[ToolClass isString:[NSString stringWithFormat:@"%@",idd]] forKey:@"memberId"];
    
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
#pragma mark --27.新增我的报告单信息
+(void)saveBaoGaoDanID:(NSString*)idd Type:(NSString*)leiXing XingMing:(NSString*)name Sex:(NSString*)sex Age:(NSString*)age BingMingID:(NSString*)bingMing ZhuSuID:(NSString*)zhusu BingLiID:(NSString*)bingli MaiXiangID:(NSString*)maixiang SheZhiID:(NSString*)shezhi SheTaiID:(NSString*)shetai YouWuFangYN:(NSString*)yn FangZhouQi:(NSString*)zhouqi HuaYN:(NSString*)ynn HuaZhouQi:(NSString*)zhouq ShouShuID:(NSString*)shoushu TNMfen:(NSString*)tnm Pro:(NSString*)pro success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    
    NSString * urlStr =[NSString stringWithFormat:@"%@/api/report/save",SERVICE];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
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
    
    [dic setObject:[ToolClass isString:[NSString stringWithFormat:@"%@",@"1"]] forKey:@"memberId"];
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

#pragma mark --30.分页加载我的收藏信息
+(void)shouCangPage:(NSString*)page VIP:(NSString*)vipid success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    
    NSString * urlStr =[NSString stringWithFormat:@"%@/api/collection/list",SERVICE];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    NSMutableDictionary * dic =[NSMutableDictionary new];
    [dic setObject:[ToolClass isString:[NSString stringWithFormat:@"%@",vipid]] forKey:@"memberId"];
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
#pragma mark --32加载我的推广信息
+(void)jiaZaiTuiGuangMessageVIPID:(NSString*)vipID success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    
    NSString * urlStr =[NSString stringWithFormat:@"%@/api/member/myExtension",SERVICE];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    NSMutableDictionary * dic =[NSMutableDictionary new];
    [dic setObject:[ToolClass isString:[NSString stringWithFormat:@"%@",vipID]] forKey:@"memberId"];
    
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
@end
