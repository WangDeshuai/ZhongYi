//
//  BingMingXiangQingVC.m
//  DistributionQuery
//
//  Created by Macx on 17/5/3.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import "BingMingXiangQingVC.h"
#import "BingMingXiangQingCell.h"
@interface BingMingXiangQingVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSArray * titleArray;
@end

@implementation BingMingXiangQingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self CreatData];
    [self CreatTabelView];
}
#pragma mark --数据源
-(void)CreatData{
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
    return _titleArray.count;;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BingMingXiangQingCell * cell =[BingMingXiangQingCell cellWithTableView:tableView IndexPath:indexPath];
    cell.titleLabel.text=_titleArray[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
//    return  80;
//    return  [_tableView cellHeightForIndexPath:indexPath model:str keyPath:@"text" cellClass:[BingMingXiangQingCell class] contentViewWidth:[ToolClass  cellContentViewWith]];
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
