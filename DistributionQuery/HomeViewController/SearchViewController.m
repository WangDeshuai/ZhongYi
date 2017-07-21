//
//  SearchViewController.m
//  DistributionQuery
//
//  Created by Macx on 17/6/9.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import "SearchViewController.h"
#import "searchModel.h"
#import "MyShouCangCell.h"
#import "MedicineXiangQingVC.h"//药详情
#import "BingMingXiangQingVC.h"//病名详情
#import "YaoFangContentXQVC.h"//方剂详情
#import "YiAnXiangQingVC.h"//医案详情
#import "JiangZuoXiangQingVC.h"//讲座详情
@interface SearchViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSMutableArray * dataArray;
@property(nonatomic,strong)UITableView * tableView;
@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=_keyWord;
    
    _dataArray=[NSMutableArray new];
    [self shuJuData];
    [self CreatTabelView];
}
-(void)shuJuData{
    [LCProgressHUD showLoading:@"请稍后..."];
    [Engine1 searchFirstKeyWord:_keyWord success:^(NSDictionary *dic) {
        NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
        if ([code isEqualToString:@"200"]) {
          
            NSArray * dataArr =[dic objectForKey:@"data"];
            
            if (dataArr.count==0) {
                 self.title=[NSString stringWithFormat:@"%@(没有找到相关数据)",_keyWord];
                [LCProgressHUD showFailure:@"没有搜索到相关数据"];
                return ;
            }
            self.title=[NSString stringWithFormat:@"%@(找到%lu条相关数据)",_keyWord,dataArr.count];
              [LCProgressHUD hide];
            for (NSDictionary * dicc in dataArr) {
                 searchModel * md =[[searchModel alloc]initWithSearchDic:dicc];
                [_dataArray addObject:md];
            }
            [_tableView reloadData];
        }else{
            [LCProgressHUD showMessage:[dic objectForKey:@"msg"]];
        }
    } error:^(NSError *error) {
        
    }];
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
    
    [self.view sd_addSubviews:@[_tableView]];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyShouCangCell * cell =[MyShouCangCell cellWithTableView:tableView CellID:[NSString stringWithFormat:@"%lu%lu",indexPath.row,indexPath.section]];
    cell.searMd=_dataArray[indexPath.row];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    searchModel * md =_dataArray[indexPath.row];
      NSString * vip =[NSUSE_DEFO objectForKey:@"vip"];
    int vipNum =[vip intValue];
    if ([md.type isEqualToString:@"1"]) {
        //药
        if (vipNum>=2) {
            MedicineXiangQingVC * vc =[MedicineXiangQingVC new];
            vc.yaoID=md.idd;
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            NSString * str =[NSString stringWithFormat:@"您当前的等级是VIP%d,并无此权限!",vipNum];
            TanKuangView * vc =[[TanKuangView alloc]initWithTitle:@"温馨提示" contentName:str achiveBtn:@"确定"];
            vc.buttonClinkBlock=^(UIButton*btn){
                
            };
            [vc show];
        }
        
       
        
    }else if ([md.type isEqualToString:@"2"]){
        //方剂
        
        if (vipNum>=2) {
            YaoFangContentXQVC * vc =[YaoFangContentXQVC new];
            vc.yaoID=md.idd;
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            NSString * str =[NSString stringWithFormat:@"您当前的等级是VIP%d,并无此权限!",vipNum];
            TanKuangView * vc =[[TanKuangView alloc]initWithTitle:@"温馨提示" contentName:str achiveBtn:@"确定"];
            vc.buttonClinkBlock=^(UIButton*btn){
                
            };
            [vc show];
        }
        

        
        
        
        
    }
    else if ([md.type isEqualToString:@"3"]){
        //病
        if (vipNum>=2) {
            BingMingXiangQingVC * vc =[BingMingXiangQingVC new];
            vc.bingID=md.idd;
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            NSString * str =[NSString stringWithFormat:@"您当前的等级是VIP%d,并无此权限!",vipNum];
            TanKuangView * vc =[[TanKuangView alloc]initWithTitle:@"温馨提示" contentName:str achiveBtn:@"确定"];
            vc.buttonClinkBlock=^(UIButton*btn){
                
            };
            [vc show];
        }
    }else if ([md.type isEqualToString:@"5"]){
        //讲座
        JiangZuoXiangQingVC * vc =[JiangZuoXiangQingVC new];
        vc.messageid=md.idd;
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([md.type isEqualToString:@"4"]){
        //中医医案
        YiAnXiangQingVC * vc =[YiAnXiangQingVC new];
        vc.messageID=md.idd;
        vc.titlename=md.contentName;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    
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
