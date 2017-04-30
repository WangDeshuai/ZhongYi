//
//  AbountMyVC.m
//  DistributionQuery
//
//  Created by Macx on 17/4/21.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import "AbountMyVC.h"

@interface AbountMyVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSArray * titleArr;
@property(nonatomic,strong)NSArray * dexArr;
@end

@implementation AbountMyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"关于我们";
    _titleArr=@[@"联系电话",@"QQ邮箱",@"版本号"];
    _dexArr=@[@"400-1254-893",@"254129572@qq.com",@"v1.0"];
    [self CreatTabelView];
}

#pragma mark --表头
-(UIView *)CreatHeadView{
    UIView * headView =[UIView new];
    headView.backgroundColor=BG_COLOR;
    headView.sd_layout
    .leftSpaceToView(_tableView,0)
    .rightSpaceToView(_tableView,0)
    .topSpaceToView(_tableView,0)
    .heightIs(220);
    //logo
    UIImageView * logoImage =[UIImageView new];
    logoImage.image=[UIImage imageNamed:@"about_logo"];
    [headView sd_addSubviews:@[logoImage]];
    logoImage.sd_layout
    .centerXEqualToView(headView)
    .topSpaceToView(headView,30)
    .widthIs(70)
    .heightIs(70);
    //label
    UILabel * nameLabel =[UILabel new];
    nameLabel.text=@"世舜中医";
    nameLabel.alpha=.7;
    [headView sd_addSubviews:@[nameLabel]];
    nameLabel.sd_layout
    .leftEqualToView(logoImage)
    .rightEqualToView(logoImage)
    .topSpaceToView(logoImage,15)
    .heightIs(20);
   
    if ([ToolClass isiPad]) {
        headView.sd_layout
        .heightIs(320);
        
        logoImage.sd_layout
        .topSpaceToView(headView,80);
    }
    
    
    return headView;
    
}


#pragma mark --创建表格
-(void)CreatTabelView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64) style:UITableViewStylePlain];
    }
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.tableFooterView=[UIView new];
    _tableView.backgroundColor=BG_COLOR;
    _tableView.rowHeight=50;
    _tableView.tableHeaderView=[self CreatHeadView];
    [self.view sd_addSubviews:@[_tableView]];
    if ([ToolClass isiPad]) {
        _tableView.rowHeight=60;
    }
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _titleArr.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Cell"];
    }
    cell.textLabel.font=[UIFont systemFontOfSize:16];
    cell.textLabel.text=_titleArr[indexPath.row];
    cell.detailTextLabel.text=_dexArr[indexPath.row];
    cell.detailTextLabel.alpha=.6;
    cell.detailTextLabel.font=[UIFont systemFontOfSize:16];
     cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
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
