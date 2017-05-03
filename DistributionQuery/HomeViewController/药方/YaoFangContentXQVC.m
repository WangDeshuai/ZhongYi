//
//  YaoFangContentXQVC.m
//  DistributionQuery
//
//  Created by Macx on 17/4/27.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import "YaoFangContentXQVC.h"
#import "YaoFangContentXQCell.h"
#import "YaoFangModel.h"
@interface YaoFangContentXQVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSArray * leftArray;
@property(nonatomic,strong)NSMutableArray * dataArray;
@end

@implementation YaoFangContentXQVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"药方详情";
    [self CreatArray];
    [self CreatTabelView];
}
#pragma mark --创建数据源
-(void)CreatArray{
    _dataArray=[NSMutableArray new];
    [LCProgressHUD showLoading:@"请稍后..."];
    [Engine jiaZaiYaoFangXiangQingYaoID:_yaoID success:^(NSDictionary *dic)
    {
        NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
        if ([code isEqualToString:@"200"]) {
            [LCProgressHUD hide];
            NSDictionary * dicc =[dic objectForKey:@"data"];
            YaoFangModel * md =[[YaoFangModel alloc]initWithYaoFangXiangQingDic:dicc];
             self.title=md.xqfangMing;
             [_dataArray addObject:md.xqfangMing];
             [_dataArray addObject:md.xqzuCheng];
             [_dataArray addObject:md.xqgongXiao];
             [_dataArray addObject:md.xqzhuZhi];
             [_dataArray addObject:md.xqfangJie];
             [_dataArray addObject:md.xqyongFa];
             [_dataArray addObject:md.xqjinJi];
             [_dataArray addObject:md.xqzhuYiShiXiang];
            [_tableView reloadData];
            
        }else{
            [LCProgressHUD showMessage:[dic objectForKey:@"msg"]];
        }
    } error:^(NSError *error) {
        
    }];
    
    _leftArray=@[@"【方名】",@"【组成】",@"【功效】",@"【主治】",@"【方解】",@"【用法】",@"【禁忌】",@"【注意事项】"];
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
    YaoFangContentXQCell * cell =[YaoFangContentXQCell cellWithTableView:tableView IndexPath:indexPath];
    cell.namelabel.text=_leftArray[indexPath.row];
    if (indexPath.row==7) {
       cell.text=[NSString stringWithFormat:@"                        %@",_dataArray[indexPath.row]];
    }else{
       cell.text=[NSString stringWithFormat:@"                 %@",_dataArray[indexPath.row]];
    }
   
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * str ;
    if (indexPath.row==7) {
        str=[NSString stringWithFormat:@"                        %@",_dataArray[indexPath.row]];
    }else{
        str=[NSString stringWithFormat:@"                 %@",_dataArray[indexPath.row]];
    }
    
    
    
    
    return  [_tableView cellHeightForIndexPath:indexPath model:str keyPath:@"text" cellClass:[YaoFangContentXQCell class] contentViewWidth:[ToolClass  cellContentViewWith]];
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
