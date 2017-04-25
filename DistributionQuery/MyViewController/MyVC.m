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
@interface MyVC ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSArray * titleArray;
@property(nonatomic,strong)NSArray * imageArray;
@end

@implementation MyVC
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
    self.automaticallyAdjustsScrollViewInsets=NO;
   
    [self CreatData];
    [self CreatTabelView];
}
-(void)CreatData{
    NSArray * ar1 =@[@"我的主页",@"我生成的报告单",@"我的收藏",@"我的推广"];
    NSArray * ar2 =@[@"关于我们",@"意见反馈",@"检测更新"];
     _titleArray=@[ar1,ar2];
    NSArray * imageArr1=@[@"my_home",@"my_bgd",@"my_sc",@"my_tg"];
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
    
    //头像
    UIButton * headBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [headBtn setBackgroundImage:[UIImage imageNamed:@"my_head"] forState:0];
    headBtn.sd_cornerRadius=@(71/2);
    [bgImage sd_addSubviews:@[headBtn]];
    headBtn.sd_layout
    .centerXEqualToView(bgImage)
    .topSpaceToView(bgImage,50)
    .widthIs(71)
    .heightIs(71);
    //姓名
    UILabel * namelabel =[UILabel new];
    namelabel.text=@"刘医生";
    namelabel.font=[UIFont systemFontOfSize:16];
    namelabel.textAlignment=1;
    namelabel.textColor=[UIColor whiteColor];
    [bgImage sd_addSubviews:@[namelabel]];
    namelabel.sd_layout
    .centerXEqualToView(headBtn)
    .topSpaceToView(headBtn,10)
    .widthIs(70)
    .heightIs(20);
    //设置
    UIButton * setBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [setBtn setImage:[UIImage imageNamed:@"my_set"] forState:0];
    [bgImage sd_addSubviews:@[setBtn]];
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
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            //我的主页
            LoginViewController * vc =[LoginViewController new];
            vc.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:vc animated:YES];

        }else if (indexPath.row==1){
            //我生成的报告单
        }else if (indexPath.row==2){
            //我的收藏
            MyShouCangVC * vc =[MyShouCangVC new];
            vc.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:vc animated:YES];
        }else if (indexPath.row==3){
            //我的推广
        }
    }else{
        if (indexPath.row==0) {
            //关于我们
            AbountMyVC * vc =[AbountMyVC new];
            vc.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:vc animated:YES];
        }else if (indexPath.row==1){
            //意见反馈
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
