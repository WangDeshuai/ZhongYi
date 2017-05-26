//
//  SheZhiViewController.m
//  DistributionQuery
//
//  Created by Macx on 17/5/25.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import "SheZhiViewController.h"
#import "XiuGaiPasswordVC.h"//修改密码
@interface SheZhiViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSArray * dataArray;
@end

@implementation SheZhiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"设置";
    _dataArray=@[@"修改密码"];
    [self CreatTabelView];
}
#pragma mark --创建表格
-(void)CreatTabelView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64) style:UITableViewStylePlain];
    }
    _tableView.tableFooterView=[UIView new];
    _tableView.backgroundColor=[UIColor whiteColor];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.keyboardDismissMode=UIScrollViewKeyboardDismissModeOnDrag;
    _tableView.rowHeight=50;
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
    }
    cell.textLabel.font=[UIFont systemFontOfSize:15];
    cell.textLabel.alpha=.6;
    cell.textLabel.text=_dataArray[indexPath.row];
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}


-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView * footView =[UIView new];
    footView.backgroundColor=[UIColor whiteColor];
    
    UIButton * tuiChuBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [tuiChuBtn setTitle:@"退出登录" forState:0];
    [tuiChuBtn addTarget:self action:@selector(tuiChuBtnClink) forControlEvents:UIControlEventTouchUpInside];
    [tuiChuBtn setTitleColor:MAIN_COLOR forState:0];
    tuiChuBtn.titleLabel.font=[UIFont systemFontOfSize:15];
    tuiChuBtn.backgroundColor=BG_COLOR;
    tuiChuBtn.sd_cornerRadius=@(20);
    [footView sd_addSubviews:@[tuiChuBtn]];
    tuiChuBtn.sd_layout
    .leftSpaceToView(footView,20)
    .rightSpaceToView(footView,20)
    .centerYEqualToView(footView)
    .heightIs(40);
    
    return footView;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath

{
    XiuGaiPasswordVC * vc =[XiuGaiPasswordVC new];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark --退出
-(void)tuiChuBtnClink{
    UIAlertController * actionview=[UIAlertController alertControllerWithTitle:@"" message:@"是否退出" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * action =[UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        //退出登录
        //1.清空token
        [NSUSE_DEFO removeObjectForKey:@"token"];
        [NSUSE_DEFO synchronize];
        //2.清空登录的.plist
        [ToolClass deleagtePlistName:@"Login"];
        [self.navigationController popViewControllerAnimated:YES];
    }];
    UIAlertAction * action2 =[UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [actionview addAction:action2];
    [actionview addAction:action];
    [self presentViewController:actionview animated:YES completion:nil];
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 100;
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
