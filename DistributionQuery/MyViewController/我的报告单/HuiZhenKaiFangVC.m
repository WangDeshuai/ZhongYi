//
//  HuiZhenKaiFangVC.m
//  DistributionQuery
//
//  Created by Macx on 17/5/16.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import "HuiZhenKaiFangVC.h"
#import "BaoGaiDanModel.h"
@interface HuiZhenKaiFangVC ()<UIWebViewDelegate>

@end

@implementation HuiZhenKaiFangVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"会诊开方";
    
    UIWebView * webview =[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64)];
        webview.backgroundColor=[UIColor redColor];
        webview.delegate=self;
         [self.view addSubview:webview];
    
    
        [Engine baoGaiDanXiangQingMessageID:_messageID success:^(NSDictionary *dic) {
            NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
            if ([code isEqualToString:@"200"]) {
                [LCProgressHUD hide];
    
                NSDictionary * dicc =[dic objectForKey:@"data"];
                BaoGaiDanModel * md =[[BaoGaiDanModel alloc]initWithBaoGaoDanXiangQingDic:dicc];
                //会诊开方
                [webview loadHTMLString:[NSString stringWithFormat:@"会诊开方：%@",md.xqhuikaifang] baseURL:nil];
            }
            else{
                [LCProgressHUD showMessage:[dic objectForKey:@"msg"]];
            }
        } error:^(NSError *error) {
            
        }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
