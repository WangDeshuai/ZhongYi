//
//  ShengJiVIPVC.m
//  DistributionQuery
//
//  Created by Macx on 17/6/15.
//  Copyright © 2017年 Macx.  All rights reserved.
//

#import "ShengJiVIPVC.h"
#import "Order.h"
#import "APAuthV2Info.h"
#import "RSADataSigner.h"
#import <AlipaySDK/AlipaySDK.h>
#import "WeiXinModel.h"
#import "WXApi.h"
#import "WXApiObject.h"
#define ALI_DEMO_BUTTON_WIDTH  (([UIScreen mainScreen].bounds.size.width) - 40.0f)
#define ALI_DEMO_BUTTON_HEIGHT (60.0f)
#define ALI_DEMO_BUTTON_GAP    (30.0f)


#define ALI_DEMO_INFO_HEIGHT (200.0f)
@interface ShengJiVIPVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSArray * imageArray;
@property(nonatomic,strong)NSArray * nameArray;
@property(nonatomic,assign)NSInteger  seleRow;
@property(nonatomic,copy)NSString * price;
@property(nonatomic,assign)float priceNum;
@property(nonatomic,copy)NSString * miaoShu;
@property(nonatomic,assign)NSInteger seletetag;
@property(nonatomic,strong)UIButton * lastBtn;
@end

@implementation ShengJiVIPVC
-(void)viewWillAppear:(BOOL)animated
{
   _tableView.tableHeaderView= [self CreatTableViewHead];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"我要升级";
    [self CreatDataArray];
    [self CreatTabelView];
    [self addFooterButton];
    NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(weiXin) name:@"WX_PaySuccess" object:nil];

}

#pragma mark --微信支付结果
-(void)weiXin{
    //支付成功(重新登录)
    UIAlertController * actionview=[UIAlertController alertControllerWithTitle:@"支付成功" message:@"请重新登录!" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * action =[UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [NSUSE_DEFO removeObjectForKey:@"token"];
        [NSUSE_DEFO removeObjectForKey:@"phone"];
        [NSUSE_DEFO removeObjectForKey:@"vip"];
        [NSUSE_DEFO synchronize];
        //2.清空登录的.plist
        [ToolClass deleagtePlistName:@"Login"];
        LoginViewController * vc =[LoginViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
    [actionview addAction:action];
    [self presentViewController:actionview animated:YES completion:nil];
}


-(void)CreatDataArray{
    _imageArray=@[@"sj_zf",@"sj_wx"];
    _nameArray=@[@"支付宝支付",@"微信支付"];
}


#pragma mark --表头
-(UIView*)CreatTableViewHead{
    UIView * headView =[UIView new];
    headView.backgroundColor=BG_COLOR;
    headView.sd_layout
    .topSpaceToView(_tableView,0)
    .leftSpaceToView(_tableView,0)
    .rightSpaceToView(_tableView,0)
    .heightIs(500);
    
    //
    UIView * view1 =[UIView new];
    view1.backgroundColor=[UIColor whiteColor];
    [headView sd_addSubviews:@[view1]];
    view1.sd_layout
    .leftSpaceToView(headView,0)
    .rightSpaceToView(headView,0)
    .topSpaceToView(headView,5)
    .heightIs(80);
    //头像
    UIImageView * lineView =[UIImageView new];
    lineView.sd_cornerRadius=@(30);
    lineView.image=[UIImage imageNamed:@"homepage_pic"];
    [view1 sd_addSubviews:@[lineView]];
    lineView.sd_layout
    .leftSpaceToView(view1,10)
    .topSpaceToView(view1,10)
    .widthIs(60)
    .heightIs(60);
    //账号
    UILabel * accountLab=[UILabel new];
    accountLab.text=@"15032735032";
    accountLab.font=[UIFont systemFontOfSize:15];
    accountLab.alpha=.6;
    [view1 sd_addSubviews:@[accountLab]];
    accountLab.sd_layout
    .leftSpaceToView(lineView,15)
    .rightSpaceToView(view1,15)
    .topSpaceToView(view1,15)
    .heightIs(20);
    //当前等级
    UILabel * dengJiLab=[UILabel new];
    dengJiLab.text=@"当前等级";
    dengJiLab.font=[UIFont systemFontOfSize:15];
    dengJiLab.alpha=.6;
    dengJiLab.textColor=MAIN_COLOR;
    [view1 sd_addSubviews:@[dengJiLab]];
    dengJiLab.sd_layout
    .leftEqualToView(accountLab)
    .topSpaceToView(accountLab,5)
    .heightIs(20);
    [dengJiLab setSingleLineAutoResizeWithMaxWidth:200];
   
    
    
    //vipImage
    UIImageView * vipImage =[UIImageView new];
    vipImage.image=[UIImage imageNamed:@"sj_v0"];
    [view1 sd_addSubviews:@[vipImage]];
    vipImage.sd_layout
    .leftSpaceToView(dengJiLab,10)
    .centerYEqualToView(dengJiLab)
    .widthIs(52/2)
    .heightIs(24/2);

    [Engine1 chaXunVipShengJiLoginPhonesuccess:^(NSDictionary *dic) {
        NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
        if ([code isEqualToString:@"200"]) {
            NSDictionary * dataDic =[dic objectForKey:@"data"];
            NSString * dengJi =[NSString stringWithFormat:@"%@",[dataDic objectForKey:@"level"]];
            int dengJI =[dengJi intValue]-1;
            dengJi=[NSString stringWithFormat:@"%d",dengJI];
            
            //VIP1游客 VIP2刚注册  VIP3   VIP4
            if ([dengJi isEqualToString:@"1"]) {
                vipImage.image=[UIImage imageNamed:@"sj_v1"];
            }else if ([dengJi isEqualToString:@"2"]){
                vipImage.image=[UIImage imageNamed:@"sj_v2"];
            }else if ([dengJi isEqualToString:@"3"]){
                vipImage.image=[UIImage imageNamed:@"sj_v3"];
            }else{
                NSString * string =[NSString stringWithFormat:@"您当前的等级是VIP%@,此等级是不对外开放的！此界面是升级来用，您不需要升级等级",dengJi];
                UIAlertController * actionview=[UIAlertController alertControllerWithTitle:@"温馨提示" message:string preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction * action =[UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [self.navigationController popViewControllerAnimated:YES];
                }];
                [actionview addAction:action];
                [self presentViewController:actionview animated:YES completion:nil];
                
                
            }
            
            
            
            
            
        }
    } error:^(NSError *error) {
        
    }];
    
    
    //VIEW2(会员特权)
    UIView * view2 =[UIView new];
    view2.backgroundColor=[UIColor whiteColor];
    [headView sd_addSubviews:@[view2]];
    view2.sd_layout
    .leftSpaceToView(headView,0)
    .rightSpaceToView(headView,0)
    .topSpaceToView(view1,15)
    .heightIs(320);
    
    UILabel * namelabel =[UILabel new];
    namelabel.text=@"会员特权";
    namelabel.font=[UIFont systemFontOfSize:15];
    namelabel.alpha=.7;
    [view2 sd_addSubviews:@[namelabel]];
    namelabel.sd_layout
    .leftSpaceToView(view2,15)
    .topSpaceToView(view2,15)
    .heightIs(20);
    [namelabel setSingleLineAutoResizeWithMaxWidth:120];
    
    //v0
    UIImageView * vImage0 =[UIImageView new];
    vImage0.image=[UIImage imageNamed:@"sj_vv0"];
    [view2 sd_addSubviews:@[vImage0]];
    vImage0.sd_layout
    .leftSpaceToView(view2,15)
    .topSpaceToView(namelabel,20)
    .widthIs(66/2)
    .heightIs(66/2);
    UILabel * vlab0 =[UILabel new];
    vlab0.text=@"V0";
    vlab0.alpha=.6;
    vlab0.font=[UIFont systemFontOfSize:16];
    [view2 sd_addSubviews:@[vlab0]];
    vlab0.sd_layout
    .leftSpaceToView(vImage0,10)
    .topSpaceToView(namelabel,10)
    .widthIs(50)
    .heightIs(20);
    
    UILabel * vcontent0=[UILabel new];
    vcontent0.text=@"无需注册 开放：中医医案、讲座";
    vcontent0.font=[UIFont systemFontOfSize:12];
    vcontent0.alpha=.4;
    [view2 sd_addSubviews:@[vcontent0]];
    vcontent0.sd_layout
    .leftEqualToView(vlab0)
    .widthIs(ScreenWidth/2-30-33)
    .topSpaceToView(vlab0,5)
    .autoHeightRatio(0);
    
    //v1
    UIImageView * vImage1 =[UIImageView new];
    vImage1.image=[UIImage imageNamed:@"sj_vv1"];
    [view2 sd_addSubviews:@[vImage1]];
    vImage1.sd_layout
    .leftSpaceToView(view2,ScreenWidth/2)
    .topSpaceToView(namelabel,20)
    .widthIs(66/2)
    .heightIs(66/2);
    UILabel * vlab1 =[UILabel new];
    vlab1.text=@"V1";
    vlab1.alpha=.6;
    vlab1.font=[UIFont systemFontOfSize:16];
    [view2 sd_addSubviews:@[vlab1]];
    vlab1.sd_layout
    .leftSpaceToView(vImage1,10)
    .centerYEqualToView(vlab0)
    .widthIs(50)
    .heightIs(20);
    
    UILabel * vcontent1=[UILabel new];
    vcontent1.text=@"需要注册 开放：中医医案、讲座、名医名方";
    vcontent1.font=[UIFont systemFontOfSize:12];
    vcontent1.alpha=.4;
    [view2 sd_addSubviews:@[vcontent1]];
    vcontent1.sd_layout
    .leftEqualToView(vlab1)
    .widthIs(ScreenWidth/2-33-15)
    .topSpaceToView(vlab1,5)
    .autoHeightRatio(0);
    
    
    //v2
    UIImageView * vImage2 =[UIImageView new];
    vImage2.image=[UIImage imageNamed:@"sj_vv2"];
    [view2 sd_addSubviews:@[vImage2]];
    vImage2.sd_layout
    .leftSpaceToView(view2,15)
    .topSpaceToView(vImage0,60)
    .widthIs(66/2)
    .heightIs(66/2);
    UILabel * vlab2 =[UILabel new];
    vlab2.text=@"V2";
    vlab2.alpha=.6;
    vlab2.font=[UIFont systemFontOfSize:16];
    [view2 sd_addSubviews:@[vlab2]];
    vlab2.sd_layout
    .leftSpaceToView(vImage2,10)
    .topSpaceToView(vcontent0,40)
    .widthIs(50)
    .heightIs(20);
    
    UILabel * vcontent2=[UILabel new];
    vcontent2.text=@"需要注册 开放：中药(除现代药理研究)、方剂(除方解)、病种、中医医案、讲座";
    vcontent2.font=[UIFont systemFontOfSize:12];
    vcontent2.alpha=.4;
    [view2 sd_addSubviews:@[vcontent2]];
    vcontent2.sd_layout
    .leftEqualToView(vlab2)
    .widthIs(ScreenWidth/2-33-30)
    .topSpaceToView(vlab2,5)
    .autoHeightRatio(0);
    
    //v3
    UIImageView * vImage3 =[UIImageView new];
    vImage3.image=[UIImage imageNamed:@"sj_vv3"];
    [view2 sd_addSubviews:@[vImage3]];
    vImage3.sd_layout
    .leftSpaceToView(view2,ScreenWidth/2)
    .centerYEqualToView(vImage2)
    .widthIs(66/2)
    .heightIs(66/2);
    UILabel * vlab3 =[UILabel new];
    vlab3.text=@"V3";
    vlab3.alpha=.6;
    vlab3.font=[UIFont systemFontOfSize:16];
    [view2 sd_addSubviews:@[vlab3]];
    vlab3.sd_layout
    .leftSpaceToView(vImage3,10)
    .centerYEqualToView(vlab2)
    .widthIs(50)
    .heightIs(20);
    
    UILabel * vcontent3=[UILabel new];
    vcontent3.text=@"需要注册 开放：中药、方剂、病种、中医医案、讲座、三辨会诊";
    vcontent3.font=[UIFont systemFontOfSize:12];
    vcontent3.alpha=.4;
    [view2 sd_addSubviews:@[vcontent3]];
    vcontent3.sd_layout
    .leftEqualToView(vlab3)
    .widthIs(ScreenWidth/2-33-15)
    .topSpaceToView(vlab3,5)
    .autoHeightRatio(0);
    [view2 setupAutoHeightWithBottomView:vcontent2 bottomMargin:15];
    
    //VIEW3
    UIView * view3 =[UIView new];
    view3.backgroundColor=[UIColor whiteColor];
    [headView sd_addSubviews:@[view3]];
    view3.sd_layout
    .leftSpaceToView(headView,0)
    .rightSpaceToView(headView,0)
    .topSpaceToView(view2,15)
    .heightIs(140);
    
    UILabel * namelabel2 =[UILabel new];
    namelabel2.text=@"我要升级";
    namelabel2.font=[UIFont systemFontOfSize:15];
    namelabel2.alpha=.7;
    [view3 sd_addSubviews:@[namelabel2]];
    namelabel2.sd_layout
    .leftSpaceToView(view3,15)
    .topSpaceToView(view3,15)
    .heightIs(20);
    [namelabel2 setSingleLineAutoResizeWithMaxWidth:120];
    
  
   
   
   
    [Engine1 chaXunVipShengJiLoginPhonesuccess:^(NSDictionary *dic) {
        NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
        if ([code isEqualToString:@"200"]) {
            NSDictionary * dataDic =[dic objectForKey:@"data"];
            NSString * dengJi =[NSString stringWithFormat:@"%@",[dataDic objectForKey:@"level"]];
            NSArray * imageArr =@[@"sj_bt_v2",@"sj_btt_v33"];;//钱image
            NSMutableArray * priceArr=[NSMutableArray new];//价格
            NSMutableArray * topArray =[NSMutableArray new];//顶头v1iamge
            int dengJI =[dengJi intValue]-1;
            dengJi=[NSString stringWithFormat:@"%d",dengJI];
            
            if ([dengJi isEqualToString:@"1"]) {
//
                [topArray addObject:@"sj_btt_v2"];
                [topArray addObject:@"sj_btt_v3"];
                [priceArr addObject:[NSString stringWithFormat:@"%@",[dataDic objectForKey:@"V2"]]];
                [priceArr addObject:[NSString stringWithFormat:@"%@",[dataDic objectForKey:@"V3"]]];
                _price=[NSString stringWithFormat:@"%@",[dataDic objectForKey:@"V2"]];
                _priceNum=[[dataDic objectForKey:@"V2"]  floatValue];
                _miaoShu=@"世舜中医升级VIP2";
            }else if ([dengJi isEqualToString:@"2"]){
                [topArray addObject:@"sj_bt_v2whf"];
                [topArray addObject:@"sj_btt_v3"];
                [priceArr addObject:[NSString stringWithFormat:@"%@",[dataDic objectForKey:@"V2Up"]]];
                _price=[NSString stringWithFormat:@"%@",[dataDic objectForKey:@"V2Up"]];
                [priceArr addObject:[NSString stringWithFormat:@"%@",[dataDic objectForKey:@"V3Up"]]];
                _priceNum=[[dataDic objectForKey:@"V2Up"]  floatValue];
                _miaoShu=@"世舜中医VIP2维护费用";
            }else if ([dengJi isEqualToString:@"3"]){
                [topArray addObject:@"sj_bt_whf"];
                [priceArr addObject:[NSString stringWithFormat:@"%@",[dataDic objectForKey:@"V3Up"]]];
            }else if([dengJi isEqualToString:@"0"]){
                [LCProgressHUD showMessage:@"VIP0是不能进入该界面的"];
                [self.navigationController popViewControllerAnimated:YES];
            }
            
            
            [self CreatImageView:view3 NameLable:namelabel2 Btn:imageArr TopArr:topArray Price:priceArr];
            
            
            
            
        }
    } error:^(NSError *error) {
        
    }];
    
    
    
    
    
    
    
    return headView;
    
}


-(void)CreatImageView:(UIView*)view3 NameLable:(UILabel*)namelabel2 Btn:(NSArray*)imageArr TopArr:(NSMutableArray*)topArr Price:(NSMutableArray*)priceArr{
    
    if (priceArr.count==1) {
        
        
        UIButton * btn =[UIButton buttonWithType:UIButtonTypeCustom];
        btn.sd_cornerRadius=@(10);
    
        //        btn.backgroundColor=[UIColor redColor];
        btn.layer.borderWidth=.5;
        btn.layer.borderColor=MAIN_COLOR.CGColor;
        
        
        [view3 sd_addSubviews:@[btn]];
        btn.sd_layout
        .centerXEqualToView(view3)
        .topSpaceToView(namelabel2,20)
        .widthIs(ScreenWidth-180)
        .heightIs(75);
        
        if ([ToolClass isiPad]) {
            btn.sd_layout
            .centerXEqualToView(view3)
            .topSpaceToView(namelabel2,20)
            .widthIs((ScreenWidth-180)*75/ScreenWidth)
            .heightIs(75);
        }
        
        
        
        //钱袋
        UIImageView * MleftImage =[UIImageView new];
        MleftImage.image=[UIImage imageNamed:imageArr[0]];
        [btn sd_addSubviews:@[MleftImage]];
        MleftImage.sd_layout
        .leftSpaceToView(btn,5)
        .centerYEqualToView(btn)
        .widthIs(75)
        .heightIs(47);
        //v2 v3图片
        UIButton * topImage =[UIButton new];
        //        topImage.image=[UIImage imageNamed:topArr[i]];
        topImage.adjustsImageWhenHighlighted=NO;
        [topImage setImage:[UIImage imageNamed:topArr[0]] forState:0];
        [btn sd_addSubviews:@[topImage]];
        topImage.sd_layout
        .rightSpaceToView(btn,10)
        .topSpaceToView(btn,15)
        .widthIs(87)
        .heightIs(12);
        
        //价格
        UILabel * pricelabel =[UILabel new];
        pricelabel.alpha=.6;
        pricelabel.font=[UIFont systemFontOfSize:15];
        pricelabel.text=[NSString stringWithFormat:@"%@元/1年",priceArr[0]];
        [btn sd_addSubviews:@[pricelabel]];
        pricelabel.sd_layout
        .rightSpaceToView(btn,10)
        .topSpaceToView(topImage,15)
        .heightIs(15);
        [pricelabel setSingleLineAutoResizeWithMaxWidth:100];
        
        [view3 setupAutoHeightWithBottomView:btn bottomMargin:20];
        return;
    }
    
    int kj =10;
    int k =(ScreenWidth-kj*3)/2;
    int g =43+30;
    for (int i =0; i<priceArr.count; i++) {
        UIButton * btn =[UIButton buttonWithType:UIButtonTypeCustom];
        btn.sd_cornerRadius=@(10);
        //        btn.backgroundColor=[UIColor redColor];
        btn.layer.borderWidth=.5;
        if (i==0) {
            btn.layer.borderColor=MAIN_COLOR.CGColor;//MAIN_COLOR.CGColor;
            _lastBtn=btn;
        }else{
             btn.layer.borderColor=BG_COLOR.CGColor;
        }
       //MAIN_COLOR.CGColor;
        btn.tag=i;
       
        [btn addTarget:self action:@selector(btnClink:) forControlEvents:UIControlEventTouchUpInside];
        [view3 sd_addSubviews:@[btn]];
        btn.sd_layout
        .leftSpaceToView(view3,kj+(kj+k)*i)
        .topSpaceToView(namelabel2,20)
        .widthIs(k)
        .heightIs(g);
        //钱袋
        UIImageView * MleftImage =[UIImageView new];
        MleftImage.image=[UIImage imageNamed:imageArr[i]];
        [btn sd_addSubviews:@[MleftImage]];
        MleftImage.sd_layout
        .leftSpaceToView(btn,5)
        .centerYEqualToView(btn)
        .widthIs(75)
        .heightIs(47);
        //v2 v3图片
        UIButton * topImage =[UIButton new];
//        topImage.image=[UIImage imageNamed:topArr[i]];
        topImage.adjustsImageWhenHighlighted=NO;
        [topImage setImage:[UIImage imageNamed:topArr[i]] forState:0];
        [btn sd_addSubviews:@[topImage]];
        topImage.sd_layout
        .rightSpaceToView(btn,10)
        .topSpaceToView(btn,15)
        .widthIs(87)
        .heightIs(12);
        
        //价格
        UILabel * pricelabel =[UILabel new];
        pricelabel.alpha=.6;
        pricelabel.font=[UIFont systemFontOfSize:15];
        pricelabel.text=[NSString stringWithFormat:@"%@元/1年",priceArr[i]];
        [btn sd_addSubviews:@[pricelabel]];
        pricelabel.sd_layout
        .rightSpaceToView(btn,10)
        .topSpaceToView(topImage,15)
        .heightIs(15);
        [pricelabel setSingleLineAutoResizeWithMaxWidth:100];
        
        [view3 setupAutoHeightWithBottomView:btn bottomMargin:20];
        
    }

    
}
#pragma mark --2个按钮点击
-(void)btnClink:(UIButton*)btn{
    _lastBtn.layer.borderColor=BG_COLOR.CGColor;
    btn.layer.borderColor=MAIN_COLOR.CGColor;
    _lastBtn=btn;
    if (btn.tag==1) {
        //点击的V3
        UIAlertController * actionview=[UIAlertController alertControllerWithTitle:@"温馨提示" message:@"升级V3请进行人工联系" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * action =[UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [ToolClass tellPhone:@"4000311039"];
            
            
            
        }];
        UIAlertAction * action2 =[UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [actionview addAction:action];
        [actionview addAction:action2];
        [self presentViewController:actionview animated:YES completion:nil];
    }else{
        //v1
    }
}
#pragma mark --创建表格
-(void)CreatTabelView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64) style:UITableViewStylePlain];
    }
    _tableView.tableFooterView=[UIView new];
    _tableView.backgroundColor=BG_COLOR;
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.keyboardDismissMode=UIScrollViewKeyboardDismissModeOnDrag;
    _tableView.tableHeaderView=[self CreatTableViewHead];
    [self.view sd_addSubviews:@[_tableView]];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _nameArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        UIImageView * imageview =[UIImageView new];
        imageview.tag=1;
        UILabel * namelabel =[UILabel new];
        namelabel.tag=2;
        UIImageView * rightImage =[UIImageView new];
        rightImage.tag=3;
        [cell sd_addSubviews:@[imageview,namelabel,rightImage]];
        
    }
    
    //最左边图片
    UIImageView * leftImage =[cell viewWithTag:1];
    leftImage.sd_layout
    .leftSpaceToView(cell,15)
    .centerYEqualToView(cell)
    .widthIs(39/2)
    .heightIs(39/2);
    leftImage.image=[UIImage imageNamed:_imageArray[indexPath.row]];
    //文字
    UILabel * namelable =[cell viewWithTag:2];
    namelable.sd_layout
    .leftSpaceToView(leftImage,10)
    .centerYEqualToView(cell)
    .heightIs(30);
    [namelable setSingleLineAutoResizeWithMaxWidth:300];
    namelable.text=_nameArray[indexPath.row];
    namelable.font=[UIFont systemFontOfSize:15];
    namelable.alpha=.7;
    
    
    //最右边图片
    UIImageView * rightImage =[cell viewWithTag:3];
    rightImage.sd_layout
    .rightSpaceToView(cell,15)
    .centerYEqualToView(cell)
    .widthIs(39/2)
    .heightIs(39/2);
    if (_seleRow==indexPath.row) {
        rightImage.image=[UIImage imageNamed:@"sj_choose"];
    }else{
        rightImage.image=[UIImage imageNamed:@"sj_cho"];
    }
    
    
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _seleRow=indexPath.row;
    [_tableView reloadData];
}



-(void)addFooterButton
{
    
    UIView * footView =[UIView new];
    footView.backgroundColor=BG_COLOR;
    footView.frame=CGRectMake(0, 10, ScreenWidth, 100);
    
    // 1.初始化Button
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    //    //2.设置文字和文字颜色
    [button setTitle:@"立即充值" forState:UIControlStateNormal];
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
#pragma mark --立即充值
-(void)buttonClink{
    
    
    NSLog(@"输出价格%f",_priceNum);
    NSLog(@"描述>>>%@",_miaoShu);
    if (_seleRow==0) {
        //支付宝支付
        [LCProgressHUD showLoading:@"请稍后..."];//
        [Engine1 huoQuDingDanHaoName:_miaoShu Price:[NSString stringWithFormat:@"%.2f",_priceNum] Type:@"level"  success:^(NSDictionary *dic) {
            NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
            if ([code isEqualToString:@"200"]) {
                NSDictionary * dataDic =[dic objectForKey:@"data"];
                NSString * dingDan =[ToolClass isString:[NSString stringWithFormat:@"%@",[dataDic objectForKey:@"order_no"]]];//_priceNum
                [self doAlipayPayDingDanHao:dingDan ];
                [LCProgressHUD hide];
            }else{
                [LCProgressHUD showMessage:[dic objectForKey:@"msg"]];
            }
            
        } error:^(NSError *error) {
            
        }];

        
       
    }else{
        //微信支付
        int price =(int)_priceNum;
        [Engine1 weiXinYuZhiFuPrice:[NSString stringWithFormat:@"%d",price*100] Type:@"level" MiaoShu:_miaoShu success:^(NSDictionary *dic) {
            NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
            if ([code isEqualToString:@"200"]) {
                NSDictionary * dataDic =[dic objectForKey:@"data"];
                WeiXinModel * md =[[WeiXinModel alloc]initWithWeiXinModelDic:dataDic];
                PayReq *request = [[PayReq alloc] init];
                request.partnerId = md.weiXinPartnerid;
                request.prepayId=  md.weiXinPrepayid;
                request.package = md.weiPackage;
                request.nonceStr=  md.weiNoncestr;
                request.timeStamp= md.weiXinTimestamp.intValue;
                request.sign= md.weiXinSign;
                [WXApi sendReq:request];
            }else{
                [LCProgressHUD showMessage:[dic objectForKey:@"msg"]];
            }
        } error:^(NSError *error) {
            
        }];
    }
    
    
}


#pragma mark --支付宝支付
- (void)doAlipayPayDingDanHao:(NSString*)dingDan
{
    //17733871852
    NSString *appScheme = @"zhongyi";
    [[AlipaySDK defaultService] payOrder:dingDan fromScheme:appScheme callback:^(NSDictionary *resultDic) {
        ;
        NSLog(@"支付结果 = %@>>>%@",resultDic,[resultDic objectForKey:@"memo"]);
        NSString * str =[NSString stringWithFormat:@"%@",[resultDic objectForKey:@"resultStatus"]];
        if ([str isEqualToString:@"9000"]) {
            //支付成功(重新登录)
            UIAlertController * actionview=[UIAlertController alertControllerWithTitle:@"支付成功" message:@"请重新登录!" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction * action =[UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [NSUSE_DEFO removeObjectForKey:@"token"];
                [NSUSE_DEFO removeObjectForKey:@"phone"];
                [NSUSE_DEFO removeObjectForKey:@"vip"];
                [NSUSE_DEFO synchronize];
                //2.清空登录的.plist
                [ToolClass deleagtePlistName:@"Login"];
                LoginViewController * vc =[LoginViewController new];
                [self.navigationController pushViewController:vc animated:YES];
            }];
           
            [actionview addAction:action];
            [self presentViewController:actionview animated:YES completion:nil];
            
            
        }else{
            [LCProgressHUD showFailure:@"支付失败"];
        }
        
    }];
    
}



#pragma mark --微信支付
-(void)weiXinZhiFu:(NSString*)price {
    
   
    
}

/*
 
 #pragma mark --微信支付
 -(void)WeiXinPayVipModel:(VIPModel*)model {
 [Engine weiXinPayAccount:[NSUSE_DEFO objectForKey:@"username"] YanXinNum:@"" VIPID:model.vipID Price:[NSString stringWithFormat:@"%d",[model.vipPrice intValue]*100] Body:[NSString stringWithFormat:@"充值vip%@",model.vipDengJi] success:^(NSDictionary *dic) {
 NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
 if ([code isEqualToString:@"1"]) {
 NSDictionary * contentDic =[dic objectForKey:@"content"];
 
 }else
 {
 [LCProgressHUD showMessage:[dic objectForKey:@"msg"]];
 }
 
 } error:^(NSError *error) {
 
 }];
 }

 
 
 */





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
