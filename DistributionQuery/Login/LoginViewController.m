//
//  LoginViewController.m
//  DistributionQuery
//
//  Created by Macx on 17/4/20.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterVC.h"
#import "ForGetPassWordVC.h"
@interface LoginViewController ()
@property(nonatomic,strong)UITextField * phoneText;
@property(nonatomic,strong)UITextField * passwordText;
@end

@implementation LoginViewController
-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden=YES;
}
-(void)viewWillDisappear:(BOOL)animated
{
    self.navigationController.navigationBarHidden=NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    UIImageView * bgImage =[UIImageView new];
    bgImage.userInteractionEnabled=YES;
    bgImage.image=[UIImage imageNamed:@"login_pic"];
    [self.view sd_addSubviews:@[bgImage]];
    bgImage.sd_layout
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .topSpaceToView(self.view,0)
    .heightIs(250);
    
    UILabel * namelabel =[UILabel new];
    namelabel.textColor=[UIColor whiteColor];
    namelabel.text=@"登录";
    namelabel.textAlignment=1;
    namelabel.font=[UIFont systemFontOfSize:18];
    [bgImage sd_addSubviews:@[namelabel]];
    namelabel.sd_layout
    .centerXEqualToView(bgImage)
    .topSpaceToView(bgImage,25)
    .widthIs(50)
    .heightIs(20);
    
    UIButton * backBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn addTarget:self action:@selector(dissMiss) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImage:[UIImage imageNamed:@"login_arrow_left"] forState:0];
    [bgImage sd_addSubviews:@[backBtn]];
    backBtn.sd_layout
    .leftSpaceToView(bgImage,10)
    .centerYEqualToView(namelabel)
    .widthIs(30)
    .heightIs(46);
    
    
    if ([ToolClass isiPad]) {
        bgImage.sd_layout
        .heightIs(901/2);
        namelabel.sd_layout
         .topSpaceToView(bgImage,40)
        .widthIs(100)
        .heightIs(40);
      namelabel.font=[UIFont systemFontOfSize:25];
    }
    
    //创建文本框(手机号)
    _phoneText=[UITextField new];
//    _phoneText.backgroundColor=[UIColor redColor];
    _phoneText.placeholder=@"请输入手机号";
    _phoneText.leftView =[self imageViewNameStr:@"login_phone"];
     _phoneText.leftViewMode = UITextFieldViewModeAlways;
    _phoneText.font=[UIFont systemFontOfSize:16];
    [self.view sd_addSubviews:@[_phoneText]];
    _phoneText.sd_layout
    .leftSpaceToView(self.view,15)
    .rightSpaceToView(self.view,15)
    .topSpaceToView(bgImage,30)
    .heightIs(40);
    
    UIView * linView1 =[UIView new];
    linView1.backgroundColor=BG_COLOR;
    [self.view sd_addSubviews:@[linView1]];
    linView1.sd_layout
    .leftSpaceToView(self.view,15)
    .rightSpaceToView(self.view,15)
    .topSpaceToView(_phoneText,0)
    .heightIs(1);
    
    //密码框
    _passwordText=[UITextField new];
    _passwordText.leftView =[self imageViewNameStr:@"login_ys"];
    _passwordText.leftViewMode = UITextFieldViewModeAlways;
//    _passwordText.backgroundColor=[UIColor redColor];
    _passwordText.placeholder=@"请输入密码";
    _passwordText.font=[UIFont systemFontOfSize:16];
    [self.view sd_addSubviews:@[_passwordText]];
    _passwordText.sd_layout
    .leftSpaceToView(self.view,15)
    .rightSpaceToView(self.view,15)
    .topSpaceToView(linView1,10)
    .heightIs(40);
    
    UIView * linView2 =[UIView new];
    linView2.backgroundColor=BG_COLOR;
    [self.view sd_addSubviews:@[linView2]];
    linView2.sd_layout
    .leftSpaceToView(self.view,15)
    .rightSpaceToView(self.view,15)
    .topSpaceToView(_passwordText,0)
    .heightIs(1);
    
    //创建登录按钮
    UIButton * loginBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    loginBtn.backgroundColor=JXColor(254, 81, 15, 1);
    [loginBtn addTarget:self action:@selector(loginBtnn) forControlEvents:UIControlEventTouchUpInside];
    loginBtn.sd_cornerRadius=@(5);
    [loginBtn setTitle:@"登录" forState:0];
    [self.view sd_addSubviews:@[loginBtn]];
    loginBtn.sd_layout
    .leftSpaceToView(self.view,15)
    .rightSpaceToView(self.view,15)
    .topSpaceToView(linView2,30)
    .heightIs(45);
    //忘记密码
    UIButton * forgetBtn =[UIButton buttonWithType:UIButtonTypeCustom];
     forgetBtn.titleLabel.font=[UIFont systemFontOfSize:15];
    forgetBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    forgetBtn.alpha=.7;
    [forgetBtn addTarget:self action:@selector(forgetBtnClink) forControlEvents:UIControlEventTouchUpInside];
    forgetBtn.sd_cornerRadius=@(5);
    [forgetBtn setTitle:@"忘记密码?" forState:0];
    [forgetBtn setTitleColor:[UIColor blackColor] forState:0];
    [self.view sd_addSubviews:@[forgetBtn]];
    forgetBtn.sd_layout
    .leftSpaceToView(self.view,15)
    .widthIs(120)
    .topSpaceToView(loginBtn,25)
    .heightIs(45);
    //手机号注册
    UIButton * zhuCeBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    zhuCeBtn.titleLabel.font=[UIFont systemFontOfSize:15];
    zhuCeBtn.titleLabel.textAlignment=2;
     zhuCeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
     zhuCeBtn.alpha=.7;
    [zhuCeBtn addTarget:self action:@selector(zhuCeBtnClink) forControlEvents:UIControlEventTouchUpInside];
    zhuCeBtn.sd_cornerRadius=@(5);
     [zhuCeBtn setTitleColor:JXColor(254, 81, 15, 1) forState:0];
    [zhuCeBtn setTitle:@"手机号注册" forState:0];
    [self.view sd_addSubviews:@[zhuCeBtn]];
    zhuCeBtn.sd_layout
    .rightSpaceToView(self.view,15)
    .widthIs(120)
    .centerYEqualToView(forgetBtn)
    .heightIs(45);

    if ([ToolClass isiPad]) {
        //手机号框
        _phoneText.font=[UIFont systemFontOfSize:18];
        _phoneText.sd_layout
        .leftSpaceToView(self.view,15)
        .rightSpaceToView(self.view,15)
        .topSpaceToView(bgImage,30)
        .heightIs(50);
       //线条1
        linView1.sd_layout
        .leftSpaceToView(self.view,15)
        .rightSpaceToView(self.view,15)
        .topSpaceToView(_phoneText,0)
        .heightIs(1);
        
        //密码框
        _passwordText.font=[UIFont systemFontOfSize:20];
        _passwordText.sd_layout
        .leftSpaceToView(self.view,15)
        .rightSpaceToView(self.view,15)
        .topSpaceToView(linView1,10)
        .heightIs(50);
        //登录按钮
        loginBtn.titleLabel.font=[UIFont systemFontOfSize:20];
        loginBtn.sd_layout
        .leftSpaceToView(self.view,15)
        .rightSpaceToView(self.view,15)
        .topSpaceToView(linView2,50)
        .heightIs(55);
        forgetBtn.titleLabel.font=[UIFont systemFontOfSize:18];
        zhuCeBtn.titleLabel.font=[UIFont systemFontOfSize:18];
        
    }
    
    
    
    
}

-(void)dissMiss{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark --登录点击状态
-(void)loginBtnn{
    [LCProgressHUD showLoading:@"正在登陆..."];
    [Engine loginAppPhone:_phoneText.text Password:_passwordText.text success:^(NSDictionary *dic) {
        NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
        if ([code isEqualToString:@"200"]) {
            [LCProgressHUD hide];
            NSDictionary * dataDic =[dic objectForKey:@"data"];
            //存储手机号,用来判断登录状态
            [NSUSE_DEFO setObject:[dataDic objectForKey:@"phone"] forKey:@"token"];
            [NSUSE_DEFO synchronize];
            
            //存储登录的plist文件
            [ToolClass savePlist:[ToolClass isDictionary:dataDic] name:@"Login"];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [LCProgressHUD showMessage:[dic objectForKey:@"msg"]];
        }
    } error:^(NSError *error) {
        
    }];
    
}
#pragma mark --忘记密码
-(void)forgetBtnClink{
    ForGetPassWordVC * vc =[ForGetPassWordVC new];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark --手机号注册
-(void)zhuCeBtnClink{
    RegisterVC * vc =[RegisterVC new];
    vc.PhonePswBlock=^(NSString*phone,NSString*psw){
        _phoneText.text=phone;
        _passwordText.text=psw;
    };
    [self.navigationController pushViewController:vc animated:YES];
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
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
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
