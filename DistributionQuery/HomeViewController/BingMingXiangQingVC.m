//
//  BingMingXiangQingVC.m
//  DistributionQuery
//
//  Created by Macx on 17/5/3.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import "BingMingXiangQingVC.h"
#import "BingMingXiangQingCell.h"
#import "BingMingModel.h"
@interface BingMingXiangQingVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSArray * titleArray;
@property(nonatomic,strong)NSMutableArray * dataArray;
@end

@implementation BingMingXiangQingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=_titleName;
    _dataArray=[NSMutableArray new];
    [self CreatData];
    [self CreatTabelView];
}
#pragma mark --数据源
-(void)CreatData{
    [LCProgressHUD showLoading:@"请稍后..."];
    [Engine BingZhongXiangQingClassID:_bingID success:^(NSDictionary *dic) {
        NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
        if ([code isEqualToString:@"200"]) {
            
            if ([dic objectForKey:@"data"]==[NSNull null] ) {
                [LCProgressHUD showFailure:@"数据为空"];
                [self.navigationController popViewControllerAnimated:YES];
                return ;
            }
            [LCProgressHUD hide];
            NSDictionary * dataDic =[dic objectForKey:@"data"];
            BingMingModel * md =[[BingMingModel alloc]initWithBingMingXiangQingDic:dataDic];
            [_dataArray addObject:md.xqBingName];
            [_dataArray addObject:md.xqzyBingName];
            [_dataArray addObject:md.xqDingYi];
            [_dataArray addObject:md.xqBingYin];
            [_dataArray addObject:md.xqLinChuang];
            [_dataArray addObject:md.xqZhenDuan];
            [_dataArray addObject:md.xqJianBie];
            [_dataArray addObject:md.xqChangGui];
            [_tableView reloadData];
        }else{
            [LCProgressHUD showMessage:[dic objectForKey:@"msg"]];
        }
    } error:^(NSError *error) {
         [LCProgressHUD showMessage:@"查询失败"];
    }];
    
    _titleArray=@[@"病名",@"中医病名",@"定义",@"病因病机",@"临床表现",@"诊断",@"鉴别诊断",@"常规治疗"];
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
    return _dataArray.count;;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BingMingXiangQingCell * cell =[BingMingXiangQingCell cellWithTableView:tableView IndexPath:indexPath];
    cell.titleLabel.text=_titleArray[indexPath.row];
    cell.text=_dataArray[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * str =_dataArray[indexPath.row];
    return  [_tableView cellHeightForIndexPath:indexPath model:str keyPath:@"text" cellClass:[BingMingXiangQingCell class] contentViewWidth:[ToolClass  cellContentViewWith]]+10;
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
