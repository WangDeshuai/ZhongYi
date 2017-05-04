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
    
    NSString * urlStr =[NSString stringWithFormat:@"%@/api/disease/view",SERVICE];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    NSMutableDictionary * dic =[NSMutableDictionary new];
    [dic setObject:[ToolClass isString:[NSString stringWithFormat:@"%@",idd]] forKey:@"categoryId"];
   
    [manager POST:urlStr parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
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
//#pragma mark --首页医案管理
//+(void)shouYeYiAnLisetViewPage:(NSString*)page success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
//    NSString * urlStr =[NSString stringWithFormat:@"%@/api/consilia/list",SERVICE];
//    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
//    NSMutableDictionary * dic =[NSMutableDictionary new];
//    [dic setObject:page forKey:@""];
//    
//    [manager POST:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
//        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
//        NSLog(@"3首页医案管理%@",str);
//        
//        aSuccess(responseObject);
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"3首页医案管理%@",error);
//        [LCProgressHUD showMessage:@"3.网络超时"];
//        aError(error);
//        
//    }];
//
//    
//}
//



@end
