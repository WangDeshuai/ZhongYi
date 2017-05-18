//
//  MyShouCangVC.m
//  DistributionQuery
//
//  Created by Macx on 17/4/25.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import "MyShouCangVC.h"
#import "MyShouCangCell.h"
#import "MyShouCangModel.h"
#import "MedicineXiangQingVC.h"//药详情
#import "BingMingXiangQingVC.h"//病名详情
#import "YiAnXiangQingVC.h"//医案详情
#import "JiangZuoXiangQingVC.h"//讲座详情
@interface MyShouCangVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSArray * imageArr;
@property(nonatomic,strong)NSMutableArray * dataArray;
@property(nonatomic,assign)int AAA;
@property (nonatomic,strong) MJRefreshComponent *myRefreshView;

@end

@implementation MyShouCangVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"我的收藏";
//    [self CreatArr];
    [self CreatTabelView];
}

-(void)jieXieDataPage:(int)page{
    
    [Engine shouCangPage:[NSString stringWithFormat:@"%d",page] VIP:@"1" success:^(NSDictionary *dic) {
        NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
        if ([code isEqualToString:@"200"]) {
            NSArray * dataArr =[dic objectForKey:@"data"];
            NSMutableArray * array2 =[NSMutableArray new];
            for (NSDictionary * dicc in dataArr) {
                MyShouCangModel * md =[[MyShouCangModel alloc]initWithShangCangDic:dicc];
                [array2 addObject:md];
            }
            
            if (self.myRefreshView ==_tableView.header) {
                _dataArray=array2;
                _tableView.footer.hidden=_dataArray.count==0?YES:NO;
            }else if (self.myRefreshView == _tableView.footer){
                [_dataArray addObjectsFromArray:array2];
            }
            [_tableView reloadData];
            [_myRefreshView  endRefreshing];
            
        }else{
            [LCProgressHUD showMessage:[dic objectForKey:@"msg"]];
        }
        
        
    } error:^(NSError *error) {
        [LCProgressHUD showMessage:@"网络超时，请重试!"];
    }];
    
}


//-(void)CreatArr{
//    _imageArr=@[@"sc_bing",@"sc_jz",@"sc_ya",@"sc_yao"];
//}

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
    [self.view sd_addSubviews:@[_tableView]];
    
    
    __weak typeof (self) weakSelf =self;
    _tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.myRefreshView = weakSelf.tableView.header;
        _AAA=1;
        [self jieXieDataPage:_AAA];
    }];
    
    [_tableView.header beginRefreshing];
    //..上拉刷新
    _tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        weakSelf.myRefreshView = weakSelf.tableView.footer;
        _AAA=_AAA+1;
          [self jieXieDataPage:_AAA];
    }];
    
    _tableView.footer.hidden = YES;
    
    
    
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
      MyShouCangCell * cell =[MyShouCangCell cellWithTableView:tableView CellID:[NSString stringWithFormat:@"%lu%lu",indexPath.row,indexPath.section]];
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    cell.model=_dataArray[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    MyShouCangModel * md =_dataArray[indexPath.row];
    if ([md.type isEqualToString:@"1"]) {
        //药
        MedicineXiangQingVC * vc =[MedicineXiangQingVC new];
        vc.yaoID=md.targetID;
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if ([md.type isEqualToString:@"2"]){
        //病
        BingMingXiangQingVC * vc =[BingMingXiangQingVC new];
        vc.bingID=md.targetID;
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([md.type isEqualToString:@"3"]){
        //讲座
        JiangZuoXiangQingVC * vc =[JiangZuoXiangQingVC new];
        vc.messageid=md.targetID;
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([md.type isEqualToString:@"4"]){
        //中医医案
        YiAnXiangQingVC * vc =[YiAnXiangQingVC new];
        vc.messageID=md.targetID;
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
