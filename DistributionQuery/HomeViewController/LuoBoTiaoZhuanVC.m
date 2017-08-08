//
//  LuoBoTiaoZhuanVC.m
//  DistributionQuery
//
//  Created by Macx on 17/7/28.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import "LuoBoTiaoZhuanVC.h"

@interface LuoBoTiaoZhuanVC ()<UIWebViewDelegate>
@property(nonatomic,strong)UIWebView * webView;
@end

@implementation LuoBoTiaoZhuanVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
    UIWebView* webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64)];
//    webView.scalesPageToFit = YES;
    webView.delegate=self;
    _webView=webView;
    [self.view addSubview:webView];
    
//    NSURL* url = [NSURL URLWithString:_urlStr];//创建URL
//    NSURLRequest* request = [NSURLRequest requestWithURL:url];//创建NSURLRequest
//    [webView loadRequest:request];//加载
    
    [self xiangQingYe];
}
-(void)xiangQingYe{
    [LCProgressHUD showLoading:@"请稍后..."];
    [Engine1 lunBoTuTiaoZhuanID:_idd success:^(NSDictionary *dic) {
        NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
        if ([code isEqualToString:@"200"]) {
            [LCProgressHUD hide];
            NSDictionary * dataDic=[dic objectForKey:@"data"];
             self.title=[dataDic objectForKey:@"title"];
            NSString * content =[dataDic objectForKey:@"content"];
            [_webView loadHTMLString:content baseURL:nil];
        }else{
            [LCProgressHUD showMessage:[dic objectForKey:@"msg"]];
        }
    } error:^(NSError *error) {
        
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    
    
    for (int i =0; i<20; i++) {
        NSString *meta = [NSString stringWithFormat:@"document.getElementsByTagName('img')[%d].style.width = '100%%'", i];
        [webView stringByEvaluatingJavaScriptFromString:meta];
    }
    
    
    
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
