//
//  RegisterVC.m
//  DistributionQuery
//
//  Created by Macx on 17/4/21.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import "RegisterVC.h"

@interface RegisterVC ()
@property(nonatomic,strong)UITextField * phoneText;//手机号
@property(nonatomic,strong)UITextField * codeText;//验证码
@property(nonatomic,strong)UITextField * pswText;//密码
@property(nonatomic,strong)UITextField * pswTwoText;//密码2
@property(nonatomic,strong)UITextField * tuiGuangCode;//推广码
@end

@implementation RegisterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"注册";
    self.view.backgroundColor=[UIColor whiteColor];
    [self CreatKongJian];
    
}




-(void)CreatKongJian{
    
    UIView * bgImage =self.view;
    
    
    //创建文本框(手机号)
    _phoneText=[UITextField new];
    _phoneText.backgroundColor=[UIColor whiteColor];
    _phoneText.placeholder=@"请输入手机号";
    _phoneText.leftView =[self imageViewNameStr:@"login_phone"];
    _phoneText.leftViewMode = UITextFieldViewModeAlways;
    _phoneText.font=[UIFont systemFontOfSize:16];
    [bgImage sd_addSubviews:@[_phoneText]];
    _phoneText.sd_layout
    .leftSpaceToView(bgImage,15)
    .rightSpaceToView(bgImage,15)
    .topSpaceToView(bgImage,15)
    .heightIs(40);
    
    UIView * linView1 =[UIView new];
    linView1.backgroundColor=BG_COLOR;
    [bgImage sd_addSubviews:@[linView1]];
    linView1.sd_layout
    .leftSpaceToView(bgImage,15)
    .rightSpaceToView(bgImage,15)
    .topSpaceToView(_phoneText,0)
    .heightIs(1);
    
    //验证码框
    _codeText=[UITextField new];
    _codeText.leftView =[self imageViewNameStr:@"login_pwd"];
    _codeText.leftViewMode = UITextFieldViewModeAlways;
    _codeText.backgroundColor=[UIColor whiteColor];
    _codeText.placeholder=@"请输入验证码";
    _codeText.font=[UIFont systemFontOfSize:16];
    [bgImage sd_addSubviews:@[_codeText]];
    _codeText.sd_layout
    .leftSpaceToView(bgImage,15)
    .rightSpaceToView(bgImage,15)
    .topSpaceToView(linView1,10)
    .heightIs(40);
    
    UIView * linView2 =[UIView new];
    linView2.backgroundColor=BG_COLOR;
    [bgImage sd_addSubviews:@[linView2]];
    linView2.sd_layout
    .leftSpaceToView(bgImage,15)
    .rightSpaceToView(bgImage,15)
    .topSpaceToView(_codeText,0)
    .heightIs(1);

    //获取验证码
    UIButton * huoQuBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    huoQuBtn.backgroundColor=JXColor(255, 148, 112, 1);
    huoQuBtn.sd_cornerRadius=@(5);
    [huoQuBtn setTitle:@"获取验证码" forState:0];
    [huoQuBtn addTarget:self action:@selector(codeBtnClink:) forControlEvents:UIControlEventTouchUpInside];
    huoQuBtn.titleLabel.font=[UIFont systemFontOfSize:15];
    [_codeText sd_addSubviews:@[huoQuBtn]];
    huoQuBtn.sd_layout
    .rightSpaceToView(_codeText,10)
    .centerYEqualToView(_codeText)
    .widthIs(100)
    .heightIs(35);
    
    
    //请输入登录密码
    _pswText=[UITextField new];
    _pswText.backgroundColor=[UIColor whiteColor];
    _pswText.placeholder=@"请输入登录密码";
    _pswText.leftView =[self imageViewNameStr:@"login_ys"];
    _pswText.leftViewMode = UITextFieldViewModeAlways;
    _pswText.font=[UIFont systemFontOfSize:16];
    [bgImage sd_addSubviews:@[_pswText]];
    _pswText.sd_layout
    .leftSpaceToView(bgImage,15)
    .rightSpaceToView(bgImage,15)
    .topSpaceToView(linView2,10)
    .heightIs(40);
    
    UIView * linView3 =[UIView new];
    linView3.backgroundColor=BG_COLOR;
    [bgImage sd_addSubviews:@[linView3]];
    linView3.sd_layout
    .leftSpaceToView(bgImage,15)
    .rightSpaceToView(bgImage,15)
    .topSpaceToView(_pswText,0)
    .heightIs(1);
    
    //请再次输入密码
    _pswTwoText=[UITextField new];
    _pswTwoText.leftView =[self imageViewNameStr:@"login_ys"];
    _pswTwoText.leftViewMode = UITextFieldViewModeAlways;
    _pswTwoText.backgroundColor=[UIColor whiteColor];
    _pswTwoText.placeholder=@"请再次输入密码";
    _pswTwoText.font=[UIFont systemFontOfSize:16];
    [bgImage sd_addSubviews:@[_pswTwoText]];
    _pswTwoText.sd_layout
    .leftSpaceToView(bgImage,15)
    .rightSpaceToView(bgImage,15)
    .topSpaceToView(linView3,10)
    .heightIs(40);
    
    UIView * linView4 =[UIView new];
    linView4.backgroundColor=BG_COLOR;
    [bgImage sd_addSubviews:@[linView4]];
    linView4.sd_layout
    .leftSpaceToView(bgImage,15)
    .rightSpaceToView(bgImage,15)
    .topSpaceToView(_pswTwoText,0)
    .heightIs(1);
    
    
    //请输入推广码
    _tuiGuangCode=[UITextField new];
    _tuiGuangCode.leftView =[self imageViewNameStr:@"tgm"];
    _tuiGuangCode.leftViewMode = UITextFieldViewModeAlways;
    _tuiGuangCode.backgroundColor=[UIColor whiteColor];
    _tuiGuangCode.placeholder=@"请输入推广码(选填)";
    _tuiGuangCode.font=[UIFont systemFontOfSize:16];
    [bgImage sd_addSubviews:@[_tuiGuangCode]];
    _tuiGuangCode.sd_layout
    .leftSpaceToView(bgImage,15)
    .rightSpaceToView(bgImage,15)
    .topSpaceToView(linView4,10)
    .heightIs(40);
    
    UIView * linView5 =[UIView new];
    linView5.backgroundColor=BG_COLOR;
    [bgImage sd_addSubviews:@[linView5]];
    linView5.sd_layout
    .leftSpaceToView(bgImage,15)
    .rightSpaceToView(bgImage,15)
    .topSpaceToView(_tuiGuangCode,0)
    .heightIs(1);
    
    
    
    
    
    //注册按钮
    UIButton * registBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [registBtn setTitle:@"注册" forState:0];
    registBtn.sd_cornerRadius=@(5);
    [registBtn addTarget:self action:@selector(registBtnClick) forControlEvents:UIControlEventTouchUpInside];
    registBtn.backgroundColor=JXColor(254, 81, 15, 1);
    [bgImage sd_addSubviews:@[registBtn]];
    registBtn.sd_layout
    .leftSpaceToView(bgImage,15)
    .rightSpaceToView(bgImage,15)
    .topSpaceToView(linView5,30)
    .heightIs(45);
    
    
    if ([ToolClass isiPad]) {
        //手机号
         _phoneText.font=[UIFont systemFontOfSize:18];
        _phoneText.sd_layout
        .leftSpaceToView(bgImage,15)
        .rightSpaceToView(bgImage,15)
        .topSpaceToView(bgImage,15)
        .heightIs(55);
        
        //验证码框
         _codeText.font=[UIFont systemFontOfSize:18];
        _codeText.sd_layout
        .leftSpaceToView(bgImage,15)
        .rightSpaceToView(bgImage,15)
        .topSpaceToView(linView1,10)
        .heightIs(55);
        //请输入登录密码
         _pswText.font=[UIFont systemFontOfSize:18];
        _pswText.sd_layout
        .leftSpaceToView(bgImage,15)
        .rightSpaceToView(bgImage,15)
        .topSpaceToView(linView2,10)
        .heightIs(55);
        
        //请再次输入密码
        _pswTwoText.font=[UIFont systemFontOfSize:18];
        _pswTwoText.sd_layout
        .leftSpaceToView(bgImage,15)
        .rightSpaceToView(bgImage,15)
        .topSpaceToView(linView3,10)
        .heightIs(55);
        
        
        //请输入推广码
        _tuiGuangCode.sd_layout
        .leftSpaceToView(bgImage,15)
        .rightSpaceToView(bgImage,15)
        .topSpaceToView(linView4,10)
        .heightIs(55);
        
        
        //注册按钮
        registBtn.sd_layout
        .leftSpaceToView(bgImage,15)
        .rightSpaceToView(bgImage,15)
        .topSpaceToView(linView5,60)
        .heightIs(55);
    }
    
    
    
    
}

#pragma mark --获取验证码
-(void)codeBtnClink:(UIButton*)sender{
//    [LCProgressHUD showMessage:@"获取验证码成功"];
//
    [LCProgressHUD showLoading:@"请稍后..."];
    [Engine sendCodePhone:_phoneText.text Type:@"register" success:^(NSDictionary *dic) {
        NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
        if ([code isEqualToString:@"200"]) {
            [LCProgressHUD hide];
            //实现倒计时
            __block int timeout=60; //倒计时时间
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
            dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
            dispatch_source_set_event_handler(_timer, ^{
                if(timeout<=0){ //倒计时结束，关闭
                    dispatch_source_cancel(_timer);
                    dispatch_async(dispatch_get_main_queue(), ^{
                        //设置界面的按钮显示 根据自己需求设置
                        [sender setTitle:@"发送验证码" forState:UIControlStateNormal];
                        sender.userInteractionEnabled = YES;
                    });
                }
                else{
                    int seconds = timeout % 60;
                    NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        //设置界面的按钮显示 根据自己需求设置
                        //NSLog(@"____%@",strTime);
                        [UIView beginAnimations:nil context:nil];
                        [UIView setAnimationDuration:1];
                        [sender setTitle:[NSString stringWithFormat:@"重新发送(%@)",strTime] forState:UIControlStateNormal];
                        [UIView commitAnimations];
                        sender.userInteractionEnabled = NO;
                    });
                    timeout--;
                }
            });
            dispatch_resume(_timer);
        }else{
            [LCProgressHUD showMessage:[dic objectForKey:@"msg"]];
        }
    } error:^(NSError *error) {
        
    }];
    
   
    
}








#pragma mark --注册按钮
-(void)registBtnClick{
     [LCProgressHUD showMessage:@"注册成功"];
    //    phoneText;//手机号
    //    codeText;//验证码
    //    pswText;//密码
    //    tuiGuangCode;//推广码

//    NSLog(@"手机号>>>%@",_phoneText.text);
//    NSLog(@"验证码>>>%@",_codeText.text);
//    NSLog(@"密码>>>%@",_pswText.text);
//    NSLog(@"推广码>>>%@",_tuiGuangCode.text);
    [LCProgressHUD showLoading:@"请稍后..."];
    [Engine registerMessagePhone:_phoneText.text Password:_pswText.text ResPassword:_pswTwoText.text YaoQingMa:_tuiGuangCode.text YanZhengMa:_codeText.text success:^(NSDictionary *dic) {
        NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
        if ([code isEqualToString:@"200"]) {
            [LCProgressHUD hide];
            self.PhonePswBlock(_phoneText.text,_pswText.text );
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [LCProgressHUD showMessage:[dic objectForKey:@"msg"]];
        }
    } error:^(NSError *error) {
        
    }];
    
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(UIButton*)imageViewNameStr:(NSString*)imageName{
    UIButton * btn =[UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:imageName] forState:0];
    btn.adjustsImageWhenHighlighted=NO;
    btn.frame=CGRectMake(0, 0, 30, 30);
    if ([ToolClass isiPad]) {
        btn.frame=CGRectMake(0, 0, 50, 30);
    }
    
    return btn;
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
