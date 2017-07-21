//
//  ForGetPassWordVC.m
//  DistributionQuery
//
//  Created by Macx on 17/6/13.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import "ForGetPassWordVC.h"

@interface ForGetPassWordVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSArray * imageArr;
@property(nonatomic,strong)NSArray * textArr;


@end

@implementation ForGetPassWordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"忘记密码";
    _imageArr=@[@"login_phone",@"login_pwd",@"login_ys",@"login_ys"];
    _textArr=@[@"请输入手机号",@"请输入验证码",@"请输入登录密码",@"请再次输入密码"];
    [self CreatTabelView];
    [self addFooterButton];
}
#pragma mark --创建表格
-(void)CreatTabelView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64) style:UITableViewStylePlain];
    }
    _tableView.tableFooterView=[UIView new];
    _tableView.backgroundColor=[UIColor whiteColor];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.keyboardDismissMode=UIScrollViewKeyboardDismissModeOnDrag;
    _tableView.rowHeight=50;
    [self.view addSubview:_tableView];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _imageArr.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * idd =[NSString stringWithFormat:@"%lu%lu",indexPath.row,indexPath.section];
    
    UITableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:idd];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idd];
        UIButton  * leftImage =[UIButton buttonWithType:UIButtonTypeCustom];
        leftImage.adjustsImageWhenHighlighted=NO;
        leftImage.tag=1;
        
        UITextField * textField =[UITextField new];
        textField.tag=2;
        UIButton * codeBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        codeBtn.hidden=YES;
        codeBtn.tag=3;
        
        [cell sd_addSubviews:@[leftImage,textField,codeBtn]];
    }
    UIButton * imageview =[cell viewWithTag:1];
    imageview.sd_layout
    .leftSpaceToView(cell,15)
    .centerYEqualToView(cell)
    .widthIs(36)
    .heightIs(36);
    [imageview setImage:[UIImage imageNamed:_imageArr[indexPath.row]] forState:0];
    
    UITextField * textField =[cell viewWithTag:2];
    textField.font=[UIFont systemFontOfSize:15];
    textField.placeholder=_textArr[indexPath.row];
    textField.sd_layout
    .leftSpaceToView(imageview,5)
    .centerYEqualToView(imageview)
    .rightSpaceToView(cell,15)
    .heightIs(30);
    
    if (indexPath.row==1) {
        UIButton * codeBtn =[cell viewWithTag:3];
        codeBtn.hidden=NO;
        codeBtn .sd_cornerRadius=@(5);
        codeBtn.backgroundColor=MAIN_COLOR;
        [codeBtn setTitle:@"获取验证码" forState:0];
        codeBtn.titleLabel.font=[UIFont systemFontOfSize:14];
        [codeBtn addTarget:self action:@selector(codeBtnClink:) forControlEvents:UIControlEventTouchUpInside];
        codeBtn.sd_layout
        .rightSpaceToView(cell,20)
        .centerYEqualToView(cell)
        .widthIs(100)
        .heightIs(30);
    }

    
    
    
    return cell;
}
-(void)addFooterButton
{
    
    UIView * footView =[UIView new];
    footView.backgroundColor=[UIColor whiteColor];
    footView.frame=CGRectMake(0, 10, ScreenWidth, 100);
    
    // 1.初始化Button
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    //    //2.设置文字和文字颜色
    [button setTitle:@"提交" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //    //3.设置圆角幅度
    button.layer.cornerRadius = 10.0;
    //
    [button addTarget:self action:@selector(buttonClink) forControlEvents:UIControlEventTouchUpInside];
    //    //4.设置frame
    button.frame =CGRectMake(30, 30, ScreenWidth-60, 40);;
    //
    //    //5.设置背景色
    button.backgroundColor = MAIN_COLOR;
    
    [footView addSubview:button];
    self.tableView.tableFooterView = footView;
}
#pragma mark --提交
-(void)buttonClink{
 
    
    UITableViewCell * cell0 =[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    UITableViewCell * cell1 =[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    UITableViewCell * cell2 =[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    UITableViewCell * cell3 =[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
    UITextField * text0 =[cell0 viewWithTag:2];
    UITextField * text1 =[cell1 viewWithTag:2];
    UITextField * text2 =[cell2 viewWithTag:2];
    UITextField * text3 =[cell3 viewWithTag:2];
    [LCProgressHUD showLoading:@"请稍后..."];
    [Engine1 forGetPassWordCode:text1.text Phone:text0.text Password:text2.text PassWordTwo:text3.text success:^(NSDictionary *dic) {
        NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
        if ([code isEqualToString:@"200"]) {
            [LCProgressHUD hide];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [LCProgressHUD showMessage:[dic objectForKey:@"msg"]];
        }
    } error:^(NSError *error) {
        
    }];
}
#pragma mark --获取验证码
-(void)codeBtnClink:(UIButton*)sender{
    [LCProgressHUD showLoading:@"请稍后..."];
    UITableViewCell * cell0 =[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    UITextField * text0 =[cell0 viewWithTag:2];
    NSLog(@"手机号》》》%@",text0.text);
    [Engine1 sendCodePhone:text0.text Type:@"reset" success:^(NSDictionary *dic) {
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
