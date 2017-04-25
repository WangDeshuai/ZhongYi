//
//  YaoFangVC.m
//  DistributionQuery
//
//  Created by Macx on 17/4/25.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import "YaoFangVC.h"

@interface YaoFangVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSArray * dataArray;
@property(nonatomic,strong)UITableView * tableView;
@end

@implementation YaoFangVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"药方";
    [self CreatDataArray];
    [self CreatTabelView];
    
}
#pragma mark --创建数据源
-(void)CreatDataArray{
    _dataArray=@[@"神经病",@"精神病",@"桂之缘(肺癌)",@"桂枝汤(胃癌)"];
}

#pragma mark --表头
-(UIView*)CreatTableViewHead{
    UIView * bgHeadView =[UIView new];
    bgHeadView.backgroundColor=[UIColor yellowColor];
    bgHeadView.sd_layout
    .leftSpaceToView(_tableView,0)
    .rightSpaceToView(_tableView,0)
    .topSpaceToView(_tableView,0)
    .heightIs(200);
    
    return bgHeadView;
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
    _tableView.rowHeight=50;
    _tableView.tableHeaderView=[self CreatTableViewHead];
    [self.view sd_addSubviews:@[_tableView]];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        UILabel * namelabel =[UILabel new];
        namelabel.tag=1;
        [cell sd_addSubviews:@[namelabel]];
    }
    UILabel * namelable= (UILabel*)[cell viewWithTag:1];
    namelable.alpha=.7;
    namelable.font=[UIFont systemFontOfSize:16];
    namelable.sd_layout
    .leftSpaceToView(cell,15)
    .centerYEqualToView(cell)
    .rightSpaceToView(cell,15)
    .heightIs(25);
    namelable.text=_dataArray[indexPath.row];
    
    return cell;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * headview =[UIView new];
    headview.backgroundColor=[UIColor redColor];
    return headview;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
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
