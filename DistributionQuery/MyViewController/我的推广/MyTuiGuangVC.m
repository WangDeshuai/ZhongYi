//
//  MyTuiGuangVC.m
//  DistributionQuery
//
//  Created by Macx on 17/4/29.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import "MyTuiGuangVC.h"
#import "MyTuiGuangCell.h"
#import "TuiGuangPeopleVC.h"//推广人数
#import "MyDuiHuanViewController.h"//我要兑换
#import "MyTuiGuangModel.h"
@interface MyTuiGuangVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSMutableArray * dataArray;
@end

@implementation MyTuiGuangVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"我的推广";
    _dataArray=[NSMutableArray new];
    [self CreatRightBtn];
    [self CreatTabelView];
}



-(void)DataArrayShuJu{
    
}


-(void)CreatRightBtn{
   UIButton*  backHomeBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [backHomeBtn setTitle:@"我要兑换" forState:0];
    [backHomeBtn setTitleColor:MAIN_COLOR forState:0];
    backHomeBtn.frame=CGRectMake(0, 0, 100, 30);
    backHomeBtn.titleLabel.font=[UIFont systemFontOfSize:15];
    backHomeBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentRight;
    [backHomeBtn addTarget:self action:@selector(rightBtnClink) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftBtn2 =[[UIBarButtonItem alloc]initWithCustomView:backHomeBtn];
    self.navigationItem.rightBarButtonItems=@[leftBtn2];
}
-(void)rightBtnClink{
    MyDuiHuanViewController * vc =[MyDuiHuanViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}
-(UIView*)headViewCreat{
    UIView * headView =[UIView new];
    headView.backgroundColor=BG_COLOR;
    headView.sd_layout
    .leftSpaceToView(_tableView,0)
    .rightSpaceToView(_tableView,0)
    .topSpaceToView(_tableView,0)
    .heightIs(117*ScreenWidth/375+10);
    
    UIImageView * imageview =[UIImageView new];
    imageview.image=[UIImage imageNamed:@"mytg_bg"];
    [headView sd_addSubviews:@[imageview]];
    imageview.sd_layout
    .leftSpaceToView(headView,0)
    .rightSpaceToView(headView,0)
    .topSpaceToView(headView,0)
    .heightIs(117*ScreenWidth/375);
    //num
    UILabel * numlab =[UILabel new];
    numlab.textAlignment=1;
    numlab.numberOfLines=2;
    numlab.font=[UIFont systemFontOfSize:18];
    numlab.textColor=[UIColor whiteColor];
    numlab.text=@"254129572";
    [imageview sd_addSubviews:@[numlab]];
    numlab.sd_layout
    .topSpaceToView(imageview,25)
    .centerXEqualToView(imageview)
    .heightIs(20);
    [numlab setSingleLineAutoResizeWithMaxWidth:ScreenWidth-100];
    
    
    //我的推广码
    UILabel * tuiGuangMalab =[UILabel new];
    tuiGuangMalab.textAlignment=1;
    tuiGuangMalab.numberOfLines=2;
    tuiGuangMalab.font=[UIFont systemFontOfSize:15];
    tuiGuangMalab.textColor=[UIColor whiteColor];
    tuiGuangMalab.text=@"我的推广码";
    [imageview sd_addSubviews:@[tuiGuangMalab]];
    tuiGuangMalab.sd_layout
    .topSpaceToView(numlab,10)
    .centerXEqualToView(imageview)
    .heightIs(20);
    
    [tuiGuangMalab setSingleLineAutoResizeWithMaxWidth:ScreenWidth-100];
    
    [LCProgressHUD showMessage:@"请稍后..."];
    [Engine jiaZaiTuiGuangMessagesuccess:^(NSDictionary *dic) {
        NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
        if ([code isEqualToString:@"200"]) {
            NSDictionary * dataDic =[dic objectForKey:@"data"];
            NSArray * memberArr =[dataDic objectForKey:@"members"];
            for (NSDictionary * dicc in memberArr) {
                MyTuiGuangModel * md =[[MyTuiGuangModel alloc]initWithTuiGuangDic:dicc];
                [_dataArray addObject:md];
            }
            
            numlab.text=[ToolClass isString:[NSString stringWithFormat:@"%@",[dataDic objectForKey:@"spreadCode"]]];
            [_tableView reloadData];
            [LCProgressHUD hide];
        }else if ([code isEqualToString:@"400"]){
            NSDictionary * dataDic =[dic objectForKey:@"data"];
             numlab.text=[ToolClass isString:[NSString stringWithFormat:@"%@",[dataDic objectForKey:@"spreadCode"]]];
        }else{
            [LCProgressHUD showMessage:[dic objectForKey:@"msg"]];
        }
        
    } error:^(NSError *error) {
        
    }];
    
    
    
    
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
    _tableView.rowHeight=70;
    _tableView.tableHeaderView=[self headViewCreat];
    [self.view sd_addSubviews:@[_tableView]];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyTuiGuangCell * cell =[MyTuiGuangCell cellWithTableView:tableView IndexPath:indexPath];
    cell.model=_dataArray[indexPath.row];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 61+5;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView * headview =[UIView new];
    headview.backgroundColor=BG_COLOR;
    
    
    UIButton * button =[UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(buttonClink) forControlEvents:UIControlEventTouchUpInside];
    button.backgroundColor=[UIColor whiteColor];
    [headview sd_addSubviews:@[button]];
    button.sd_layout
    .leftSpaceToView(headview,0)
    .rightSpaceToView(headview,0)
    .topSpaceToView(headview,0)
    .heightIs(61);
    
    //竖线
    UIImageView * image1 =[UIImageView new];
    image1.image=[UIImage imageNamed:@"mytg_line"];
    [button sd_addSubviews:@[image1]];
    image1.sd_layout
    .leftSpaceToView(button,0)
    .topSpaceToView(button,0)
    .bottomSpaceToView(button,0)
    .widthIs(4);
    //人数
    UIImageView * image2 =[UIImageView new];
    image2.image=[UIImage imageNamed:@"mytg_pl"];
    [button sd_addSubviews:@[image1]];
    image2.sd_layout
    .leftSpaceToView(image1,10)
    .centerYEqualToView(button)
    .heightIs(17)
    .widthIs(17);
    
    
    UILabel * numlab =[UILabel new];
    numlab.textAlignment=1;
    numlab.numberOfLines=2;
    numlab.font=[UIFont systemFontOfSize:16];
    numlab.textColor=MAIN_COLOR;
    numlab.text=@"推广人数";
    [button sd_addSubviews:@[numlab]];
    numlab.sd_layout
    .centerYEqualToView(button)
    .leftSpaceToView(image2,10)
    .heightIs(20);
    [numlab setSingleLineAutoResizeWithMaxWidth:ScreenWidth-100];
    
    
    
    
    //箭头
    UIImageView * image3 =[UIImageView new];
    image3.image=[UIImage imageNamed:@"mytg_arrow_right"];
    [button sd_addSubviews:@[image3]];
    image3.sd_layout
    .rightSpaceToView(button,15)
    .centerYEqualToView(button)
    .heightIs(13)
    .widthIs(8);

    
    
    return headview;
}
#pragma mark --推广人数
-(void)buttonClink{
//    TuiGuangPeopleVC * vc =[TuiGuangPeopleVC new];
//    [self.navigationController pushViewController:vc animated:YES];
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
