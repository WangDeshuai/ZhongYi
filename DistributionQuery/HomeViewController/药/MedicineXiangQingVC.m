//
//  MedicineXiangQingVC.m
//  DistributionQuery
//
//  Created by Macx on 17/4/28.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import "MedicineXiangQingVC.h"
#import "MedicineXiangQingCell.h"
#import "MedicineModel.h"
@interface MedicineXiangQingVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSArray * titleArr;
@property(nonatomic,strong)NSMutableArray * dataArray;
@end

@implementation MedicineXiangQingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"药品详情";
    [self CreatRightBtn];
    _dataArray=[NSMutableArray new];
    [self dataArrayJieXi];
    [self CreatTabelView];
}

-(void)CreatRightBtn{
    UIButton*  backHomeBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [backHomeBtn setImage:[UIImage imageNamed:@"xq_sc"] forState:0];
    [backHomeBtn setImage:[UIImage imageNamed:@"xq_sc_click"] forState:UIControlStateSelected];
    [Engine YanZhengMyShouCangMessageID:_yaoID Type:@"1" success:^(NSDictionary *dic) {
        NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
        if ([code isEqualToString:@"200"]) {
            //收藏
            backHomeBtn.selected=YES;
        }else{
            //未收藏
            backHomeBtn.selected=NO;
        }
    } error:^(NSError *error) {
        
    }];
    
    
    [backHomeBtn setTitleColor:MAIN_COLOR forState:0];
    backHomeBtn.frame=CGRectMake(0, 0, 100, 30);
    backHomeBtn.titleLabel.font=[UIFont systemFontOfSize:15];
    backHomeBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentRight;
    [backHomeBtn addTarget:self action:@selector(rightBtnClink:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftBtn2 =[[UIBarButtonItem alloc]initWithCustomView:backHomeBtn];
    self.navigationItem.rightBarButtonItems=@[leftBtn2];
}
-(void)rightBtnClink:(UIButton*)btn{
    btn.selected=!btn.selected;
    if (btn.selected==NO) {
        //取消
        NSLog(@"取消");
        [Engine shouCangSaveStype:@"1" MessageID:_yaoID uccess:^(NSDictionary *dic) {
            [LCProgressHUD showMessage:[dic objectForKey:@"msg"]];
        } error:^(NSError *error) {
            
        }];
    }else{
        //选中（药=1，病=2，讲座=3，医案=4）
        NSLog(@"收藏");
        [Engine shouCangSaveStype:@"1" MessageID:_yaoID uccess:^(NSDictionary *dic) {
             [LCProgressHUD showMessage:[dic objectForKey:@"msg"]];
        } error:^(NSError *error) {
            
        }];
    }
    
}


-(void)dataArrayJieXi{
    [LCProgressHUD showMessage:@"请稍后..."];
    [Engine yaoPinXiangQingMessageYaoID:_yaoID success:^(NSDictionary *dic)
    {
        NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
        if ([code isEqualToString:@"200"]) {
            
            NSDictionary * dataDic =[dic objectForKey:@"data"];
            MedicineModel * model =[[MedicineModel alloc]initWithYaoXiangQingDic:dataDic];
            [_dataArray addObject:model.xqYaoName];
            [_dataArray addObject:model.xqYaoBieName];
            [_dataArray addObject:model.xqXingWei];
            [_dataArray addObject:model.xqGuiJing];
            [_dataArray addObject:model.xqGongXiao];
            [_dataArray addObject:model.xqZhuZhi];
            [_dataArray addObject:model.xqChengFen];
            [_dataArray addObject:model.xqJinJi];
            [_dataArray addObject:model.xqDuXing];
            [_dataArray addObject:model.xqKangLiPu];
            [_dataArray addObject:model.xqYongFa];
            [_dataArray addObject:model.xqPeiWuXiaoYong];
            [_dataArray addObject:model.xqxianDaiYaoLi];
             self.title=model.xqYaoName;
            [LCProgressHUD hide];
            [_tableView reloadData];
        }else{
            [LCProgressHUD showMessage:[dic objectForKey:@"msg"]];
        }
    } error:^(NSError *error) {
        
    }];
    _titleArr=@[@"【药名】",@"【别名】",@"【性味】",@"【归经】",@"【功效】",@"【主治】",@"【成份】",@"【禁忌】",@"【毒性】",@"【抗瘤谱】",@"【用法用量】",@"【配伍效用】",@"【现代药理研究】"];
}


-(UIView*)tableviewHeadView{
    UIView * headView =[UIView new];
    headView.backgroundColor=[UIColor whiteColor];
    headView.sd_layout
    .leftSpaceToView(_tableView,0)
    .rightSpaceToView(_tableView,0)
    .topSpaceToView(_tableView,0)
    .heightIs(220*(ScreenWidth-30)/346+30);
   
    UIImageView * imageview =[UIImageView new];
    imageview.image=[UIImage imageNamed:@"yao_xq_banner"];
    [headView sd_addSubviews:@[imageview]];
    imageview.sd_layout
    .leftSpaceToView(headView,15)
    .rightSpaceToView(headView,15)
    .topSpaceToView(headView,15)
    .heightIs(220*(ScreenWidth-30)/346);//
   
    
    
    
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
    _tableView.tableHeaderView=[self tableviewHeadView];
    [self.view sd_addSubviews:@[_tableView]];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MedicineXiangQingCell * cell =[MedicineXiangQingCell cellWithTableView:tableView IndexPath:indexPath];
    cell.namelabel.text=_titleArr[indexPath.row];
    
   
   
    if (indexPath.row<9) {
        cell.text=[NSString stringWithFormat:@"               %@",_dataArray[indexPath.row]];
    }else if (indexPath.row<10){
         cell.text=[NSString stringWithFormat:@"                   %@",_dataArray[indexPath.row]];
    }else if (indexPath.row<12){
        cell.text=[NSString stringWithFormat:@"                      %@",_dataArray[indexPath.row]];
    }else{
        cell.text=[NSString stringWithFormat:@"                             %@",_dataArray[indexPath.row]];
    }
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    //如果排列不整齐，就换成高度自适应
    NSString * str;
    
    if (indexPath.row<9) {
        str=[NSString stringWithFormat:@"               %@",_dataArray[indexPath.row]];
    }else if (indexPath.row<10){
        str=[NSString stringWithFormat:@"                   %@",_dataArray[indexPath.row]];
    }else if (indexPath.row<12){
        str=[NSString stringWithFormat:@"                      %@",_dataArray[indexPath.row]];
    }else{
        str=[NSString stringWithFormat:@"                             %@",_dataArray[indexPath.row]];
    }
    
    return  [_tableView cellHeightForIndexPath:indexPath model:str keyPath:@"text" cellClass:[MedicineXiangQingCell class] contentViewWidth:[ToolClass  cellContentViewWith]];
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
