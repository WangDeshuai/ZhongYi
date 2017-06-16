//
//  ShengJiVIPVC.m
//  DistributionQuery
//
//  Created by Macx on 17/6/15.
//  Copyright © 2017年 Macx.  All rights reserved.
//

#import "ShengJiVIPVC.h"

@interface ShengJiVIPVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSArray * imageArray;
@property(nonatomic,strong)NSArray * nameArray;
@property(nonatomic,assign)NSInteger  seleRow;
@end

@implementation ShengJiVIPVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"我要升级";
    [self CreatDataArray];
    [self CreatTabelView];
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
    vcontent0.text=@"无需注册 开放内容：讲座和病案";
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
    vcontent1.text=@"需要注册 开放内容：包括V0所有开发内容及疾病诊";
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
    vcontent2.text=@"需要注册 开放内容：包括所有可视内容但不可以使用三辩会诊";
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
    vcontent3.text=@"需要注册 开放所有权限";
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
    .heightIs(120);
    
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
    
    int kj =20;
    int k =(ScreenWidth-kj*3)/2;
    int g =43+20;
    NSArray * imageArr =@[@"sj_bt_v2",@"sj_btt_v33"];
    NSArray * topArr =@[@"sj_btt_v2",@"sj_btt_v3"];
    for (int i =0; i<imageArr.count; i++) {
        UIButton * btn =[UIButton buttonWithType:UIButtonTypeCustom];
        btn.sd_cornerRadius=@(10);
        btn.backgroundColor=[UIColor whiteColor];
        [view3 sd_addSubviews:@[btn]];
        btn.sd_layout
        .leftSpaceToView(view3,kj+(kj+k)*i)
        .topSpaceToView(namelabel2,20)
        .widthIs(k)
        .heightIs(g);
        
        UIImageView * MleftImage =[UIImageView new];
        MleftImage.image=[UIImage imageNamed:imageArr[i]];
        [btn sd_addSubviews:@[MleftImage]];
        MleftImage.sd_layout
        .leftSpaceToView(btn,5)
        .centerYEqualToView(btn)
        .widthIs(75)
        .heightIs(47);
        
        UIImageView * topImage =[UIImageView new];
        topImage.image=[UIImage imageNamed:topArr[i]];
        [btn sd_addSubviews:@[topImage]];
        topImage.sd_layout
        .rightSpaceToView(btn,5)
        .topSpaceToView(btn,5)
        .widthIs(16)
        .heightIs(9);
        
        
    }
    
    
    
    
    return headView;
    
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
