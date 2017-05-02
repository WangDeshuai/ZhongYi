//
//  MoreZhongYiVC.m
//  DistributionQuery
//
//  Created by Macx on 17/5/2.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import "MoreZhongYiVC.h"
#import "ZhongYiYiAnCell.h"
@interface MoreZhongYiVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tableView;
@end

@implementation MoreZhongYiVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"中医医案";
    [self CreatTabelView];
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
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZhongYiYiAnCell * cell =[ZhongYiYiAnCell cellWithTableView:tableView IndexPath:indexPath];
    return cell;
}


-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * headview =[UIView new];
    headview.backgroundColor=[UIColor whiteColor];
    UIView * linView =[UIView new];
    linView.backgroundColor=MAIN_COLOR;
    [headview sd_addSubviews:@[linView]];
    linView.sd_layout
    .leftSpaceToView(headview,15)
    .heightIs(15)
    .centerYEqualToView(headview)
    .widthIs(2);
    UILabel * namelabel =[UILabel new];
    namelabel.font=[UIFont systemFontOfSize:17];
    namelabel.textAlignment=0;
    namelabel.textColor=MAIN_COLOR;
    namelabel.text=@"更多医案";
    [headview sd_addSubviews:@[namelabel]];
    namelabel.sd_layout
    .leftSpaceToView(linView,10)
    .centerYEqualToView(headview)
    .heightIs(20);
    [namelabel setSingleLineAutoResizeWithMaxWidth:200];
    
 
    
    
    UIView * linview2 =[UIView new];
    linview2.backgroundColor=BG_COLOR;
    [headview sd_addSubviews:@[linview2]];
    linview2.sd_layout
    .leftSpaceToView(headview,5)
    .rightSpaceToView(headview,5)
    .bottomSpaceToView(headview,1)
    .heightIs(1);
    
    
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
