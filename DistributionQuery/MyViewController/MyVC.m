//
//  MyVC.m
//  DistributionQuery
//
//  Created by Macx on 16/10/8.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "MyVC.h"
#import "MyTableViewCell.h"
#import "AbountMyVC.h"//关于我们
#import "MyShouCangVC.h"//我的收藏
#import "BaoGaoDanVC.h"//我生成的报告单
#import "MyTuiGuangVC.h"//我的推广
#import "YiJianFanKuiVC.h"//意见反馈
#import "MyZhuYeVC.h"//我的主页
#import "SheZhiViewController.h"//设置
#import "ShengJiVIPVC.h"//升级会员
@interface MyVC ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSArray * titleArray;
@property(nonatomic,strong)NSArray * imageArray;
@end

@implementation MyVC
-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden=YES;
     _tableView.tableHeaderView=[self CreatTabeleViewHead];
    
    if ([ToolClass isLogin]) {
        [Engine1 chaXunVipShengJiLoginPhonesuccess:^(NSDictionary *dic) {
            NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
            if ([code isEqualToString:@"200"]) {
                NSDictionary * dataDic =[dic objectForKey:@"data"];
                NSString * dengJi =[NSString stringWithFormat:@"%@",[dataDic objectForKey:@"level"]];
                int dengJI =[dengJi intValue]-1;
                dengJi=[NSString stringWithFormat:@"%d",dengJI];
                NSString * str =[NSUSE_DEFO objectForKey:@"vip"];
                if ([dengJi isEqualToString:str]) {
                }else{
                    [NSUSE_DEFO setObject:dengJi forKey:@"vip"];
                    [NSUSE_DEFO synchronize];
                    NSString * strDj =[NSString stringWithFormat:@"您的VIP状态发生了更改\n当前您是VIP%@",dengJi];
                    TanKuangView * vc =[[TanKuangView alloc]initWithTitle:@"温馨提示" contentName:strDj achiveBtn:@"确定"];
                    vc.buttonClinkBlock=^(UIButton*btn){
                        
                    };
                    [vc show];
                }
            }
        } error:^(NSError *error) {
            
        }];

    }
}
-(void)viewWillDisappear:(BOOL)animated
{
    self.navigationController.navigationBarHidden=NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets=NO;
   
    [self CreatData];
    [self CreatTabelView];
}
-(void)CreatData{
    NSArray * ar1 =@[@"我的主页",@"我生成的报告单",@"我的收藏",@"我的推广",@"我要升级"];
    NSArray * ar2 =@[@"关于我们",@"意见反馈",@"检测更新"];
     _titleArray=@[ar1,ar2];
    NSArray * imageArr1=@[@"my_home",@"my_bgd",@"my_sc",@"my_tg",@"my_sj"];
    NSArray * imageArr2=@[@"my_us",@"my_fk",@"my_gx"];
    _imageArray=@[imageArr1,imageArr2];
    
}
-(UIView*)CreatTabeleViewHead{
    UIView * headView =[UIView new];
    headView.backgroundColor=BG_COLOR;
    headView.sd_layout
    .leftSpaceToView(self.view,0)
    .topSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .heightIs(182+20);
    //背景图
    UIImageView * bgImage =[UIImageView new];
    bgImage.userInteractionEnabled=YES;
    bgImage.image=[UIImage imageNamed:@"my_bg"];
    [headView sd_addSubviews:@[bgImage]];
    bgImage.sd_layout
    .leftSpaceToView(headView,0)
    .rightSpaceToView(headView,0)
    .topSpaceToView(headView,0)
    .heightIs(182+20);
    
    //头像zz123321
    UIButton * headBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [headBtn setBackgroundImage:[UIImage imageNamed:@"my_head"] forState:0];
    [headBtn addTarget:self action:@selector(loginBtnClink) forControlEvents:UIControlEventTouchUpInside];
    headBtn.sd_cornerRadius=@(71/2);
    [bgImage sd_addSubviews:@[headBtn]];
    headBtn.sd_layout
    .centerXEqualToView(bgImage)
    .topSpaceToView(bgImage,50)
    .widthIs(71)
    .heightIs(71);
    
    [Engine1 chaXunMyZhuYesuccess:^(NSDictionary *dic) {
        NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
        if ([code isEqualToString:@"200"]) {
            NSDictionary * dataDic =[dic objectForKey:@"data"];
            
            [headBtn setBackgroundImageForState:0 withURL:[NSURL URLWithString:[ToolClass isString:[dataDic objectForKey:@"filePath"]]] placeholderImage:[UIImage imageNamed:@"my_head"]];
        }else{
            [LCProgressHUD showMessage:[dic objectForKey:@"msg"]];
        }
    } error:^(NSError *error) {
        
    }];
    
    
    
    //姓名
    UILabel * namelabel =[UILabel new];
    if ([ToolClass isLogin]) {
       namelabel.text=[NSUSE_DEFO objectForKey:@"token"];
    }else{
         namelabel.text=@"未登录";
    }
   
    namelabel.font=[UIFont systemFontOfSize:16];
    namelabel.textAlignment=1;
    namelabel.textColor=[UIColor whiteColor];
    [bgImage sd_addSubviews:@[namelabel]];
    namelabel.sd_layout
    .centerXEqualToView(headBtn)
    .topSpaceToView(headBtn,10)
    .heightIs(20);
    [namelabel setSingleLineAutoResizeWithMaxWidth:200];
    //设置
    UIButton * setBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [setBtn setImage:[UIImage imageNamed:@"my_set"] forState:0];
    [bgImage sd_addSubviews:@[setBtn]];
    [setBtn addTarget:self action:@selector(sheZhiBtnClink) forControlEvents:UIControlEventTouchUpInside];
    setBtn.sd_layout
    .rightSpaceToView(bgImage,10)
    .topEqualToView(headBtn)
    .widthIs(50)
    .heightIs(47);
    
    if ([ToolClass isiPad]) {
        headView.sd_layout
        .heightIs(559/2);
        
        bgImage.sd_layout
        .heightIs(559/2);
        //头像
        headBtn.sd_cornerRadius=@(219/4);
        headBtn.sd_layout
        .centerXEqualToView(bgImage)
        .topSpaceToView(bgImage,50)
        .widthIs(219/2)
        .heightIs(219/2);
        //姓名
        namelabel.font=[UIFont systemFontOfSize:20];
        namelabel.sd_layout
        .widthIs(219/2)
        .heightIs(40);
    }
    
    
    
    
    return headView;
}

#pragma mark --设置点击
-(void)sheZhiBtnClink{
    
    if ([ToolClass isLogin]==NO) {
        LoginViewController * vc =[LoginViewController new];
        vc.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    
    
    SheZhiViewController * vc =[SheZhiViewController new];
    vc.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark --点击头像
-(void)loginBtnClink{
   
    if ([ToolClass isLogin]==NO) {
        LoginViewController * vc =[LoginViewController new];
        vc.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        MyZhuYeVC * vc =[MyZhuYeVC new];
        vc.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
   
}


#pragma mark --创建表格
-(void)CreatTabelView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-49) style:UITableViewStylePlain];
    }
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.tableHeaderView=[self CreatTabeleViewHead];
    _tableView.tableFooterView=[UIView new];
    _tableView.backgroundColor=BG_COLOR;
    _tableView.rowHeight=50;
    [self.view sd_addSubviews:@[_tableView]];
    if ([ToolClass isiPad]) {
        _tableView.rowHeight=70;
    }
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _imageArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  [_imageArray[section] count];
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    MyTableViewCell * cell =[MyTableViewCell cellWithTableView:tableView CellID:[NSString stringWithFormat:@"%lu%lu",indexPath.row,indexPath.section]];
    cell.namelabel.text=_titleArray[indexPath.section][indexPath.row];
    [cell.imageview setImage:[UIImage imageNamed:_imageArray[indexPath.section][indexPath.row]] forState:0];
    return cell;
}
#pragma mark --表格点击
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([ToolClass isLogin]==NO) {
        LoginViewController * vc =[LoginViewController new];
        vc.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:vc animated:YES];
        
        return;
    }
    
    
    
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            MyZhuYeVC * vc =[MyZhuYeVC new];
            vc.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:vc animated:YES];

        }else if (indexPath.row==1){
            //我生成的报告单
            BaoGaoDanVC * vc =[BaoGaoDanVC new];
            vc.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:vc animated:YES];

        }else if (indexPath.row==2){
            //我的收藏
            MyShouCangVC * vc =[MyShouCangVC new];
            vc.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:vc animated:YES];
        }else if (indexPath.row==3){
            //我的推广
            MyTuiGuangVC * vc =[MyTuiGuangVC new];
            vc.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:vc animated:YES];

        }else if (indexPath.row==4){
            //我要升级
            ShengJiVIPVC * vc =[ShengJiVIPVC new];
            vc.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }else{
        if (indexPath.row==0) {
            //关于我们
            AbountMyVC * vc =[AbountMyVC new];
            vc.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:vc animated:YES];
        }else if (indexPath.row==1){
            //意见反馈
            YiJianFanKuiVC * vc =[YiJianFanKuiVC new];
            vc.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            //检测更新
        }
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5;
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
