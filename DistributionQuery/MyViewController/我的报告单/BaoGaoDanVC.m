//
//  BaoGaoDanVC.m
//  DistributionQuery
//
//  Created by Macx on 17/4/29.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import "BaoGaoDanVC.h"
#import "BaoGaoDanCell.h"
#import "BaoGaiDanModel.h"
#import "BaoGaoDanXiangQing.h"
@interface BaoGaoDanVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSMutableArray * dataArray;
@property(nonatomic,assign)int AAA;
@property (nonatomic,strong) MJRefreshComponent *myRefreshView;
@end

@implementation BaoGaoDanVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"我生成的报告单";
    [self CreatTabelView];
}





-(void)CreatBaoGaiDanDataPage:(int)page{
    //18514232635
    [Engine baoGaiDanPage:[NSString stringWithFormat:@"%d",page]  success:^(NSDictionary *dic) {
        NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
        if ([code isEqualToString:@"200"]) {
            NSMutableArray * array2 =[NSMutableArray new];
            NSArray * dataArr =[dic objectForKey:@"data"];
            
            for (NSDictionary * dicc in dataArr) {
                BaoGaiDanModel * md =[[BaoGaiDanModel alloc]initWithBaoGaoDanDic:dicc];
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
    _tableView.rowHeight=70;
    [self.view sd_addSubviews:@[_tableView]];
    
    
    
    __weak typeof (self) weakSelf =self;
    _tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.myRefreshView = weakSelf.tableView.header;
        _AAA=1;
        [self CreatBaoGaiDanDataPage:_AAA];
    }];
    
    [_tableView.header beginRefreshing];
    //..上拉刷新
    _tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        weakSelf.myRefreshView = weakSelf.tableView.footer;
        _AAA=_AAA+1;
         [self CreatBaoGaiDanDataPage:_AAA];
    }];
    
    _tableView.footer.hidden = YES;
    
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BaoGaoDanCell * cell =[BaoGaoDanCell cellWithTableView:tableView IndexPath:indexPath];
    cell.model=_dataArray[indexPath.row];
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BaoGaiDanModel * md =_dataArray[indexPath.row];
    BaoGaoDanXiangQing * vc =[[BaoGaoDanXiangQing alloc]init];
    vc.messageID=md.bgid;
    [self.navigationController pushViewController:vc animated:YES];
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
