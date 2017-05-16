//
//  CustomAlertThree.m
//  DistributionQuery
//
//  Created by Macx on 17/5/10.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import "CustomAlertThree.h"
@interface CustomAlertThree()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * rightTableView;
@property(nonatomic,strong)UITableView * leftTableView;
@property(nonatomic,strong)UIView * titlable;
@property(nonatomic,strong)NSArray * dataArray1;
@property(nonatomic,strong)NSArray * dataArray2;
@property(nonatomic,copy)NSString * string;

@end

@implementation CustomAlertThree

-(id)initWithTitle:(NSString*)title  canCleBtn:(NSString*)btnName1 achiveBtn:(NSString*)btnName2 {
    self=[super init];
    if (self) {
        //设置中心点
        self.frame=CGRectMake(0, 1000, ScreenWidth, ScreenHeight/2);
        self.backgroundColor=[UIColor whiteColor];
        _dataArray1=@[@"有",@"无"];
       
        //标题
        UILabel * titlable =[UILabel new];
        
        UIButton * canBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        UIButton * achiveBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        [self sd_addSubviews:@[titlable,canBtn,achiveBtn]];
        
        titlable.font=[UIFont systemFontOfSize:16];
        titlable.alpha=.7;
        titlable.textAlignment=1;
        titlable.text=title;
        
        canBtn.titleLabel.font=[UIFont systemFontOfSize:16];
        canBtn.alpha=.7;
        [canBtn setTitle:btnName1 forState:0];
        [canBtn addTarget:self action:@selector(dissmiss) forControlEvents:UIControlEventTouchUpInside];
        [canBtn setTitleColor:[UIColor blackColor] forState:0];
        achiveBtn.titleLabel.font=[UIFont systemFontOfSize:16];
        achiveBtn.alpha=.7;
        [achiveBtn setTitleColor:[UIColor blackColor] forState:0];
        [achiveBtn setTitle:btnName2 forState:0];
        [achiveBtn addTarget:self action:@selector(achiveBtnClink) forControlEvents:UIControlEventTouchUpInside];
        
        titlable.sd_layout
        .centerXEqualToView(self)
        .topSpaceToView(self,15)
        .heightIs(20);
        [titlable setSingleLineAutoResizeWithMaxWidth:200];
        
        canBtn.sd_layout
        .leftSpaceToView(self,15)
        .centerYEqualToView(titlable)
        .widthIs(70)
        .heightIs(20);
        
        achiveBtn.sd_layout
        .rightSpaceToView(self,15)
        .centerYEqualToView(titlable)
        .widthIs(70)
        .heightIs(20);
        //线条
        UIView * linView =[UIView new];
        linView.backgroundColor=MAIN_COLOR;
        _titlable=linView;
        [self sd_addSubviews:@[linView]];
        
        linView.sd_layout
        .leftSpaceToView(self,0)
        .rightSpaceToView(self,0)
        .topSpaceToView(titlable,15)
        .heightIs(2);
        [self CreatLeftTabelView];
        [self CreatTabelView];

    }
    
    return self;
}
#pragma mark --完成
-(void)achiveBtnClink{
    self.NameBlock([ToolClass isString:[NSString stringWithFormat:@"%@",_string]]);
}
#pragma mark --创建左边表格
-(void)CreatLeftTabelView{
    if (!_leftTableView) {
        _leftTableView=[[UITableView alloc]init];
    }
    _leftTableView.tableFooterView=[UIView new];
    _leftTableView.backgroundColor=BG_COLOR;
    _leftTableView.delegate=self;
    _leftTableView.dataSource=self;
    _leftTableView.keyboardDismissMode=UIScrollViewKeyboardDismissModeOnDrag;
    
    [self sd_addSubviews:@[_leftTableView]];
    _leftTableView.sd_layout
    .leftSpaceToView(self,0)
    .widthIs(ScreenWidth/2)
    .topSpaceToView(_titlable,17)
    .bottomSpaceToView(self,0);
    
}
#pragma mark --创建表格
-(void)CreatTabelView{
    if (!_rightTableView) {
        _rightTableView=[[UITableView alloc]init];
    }
    _rightTableView.tableFooterView=[UIView new];
    _rightTableView.backgroundColor=BG_COLOR;
    _rightTableView.delegate=self;
    _rightTableView.dataSource=self;
    _rightTableView.keyboardDismissMode=UIScrollViewKeyboardDismissModeOnDrag;
    
    [self sd_addSubviews:@[_rightTableView]];
    _rightTableView.sd_layout
    .leftSpaceToView(self,ScreenWidth/2)
    .widthIs(ScreenWidth/2)
    .topSpaceToView(_titlable,17)
    .bottomSpaceToView(self,0);
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==_leftTableView) {
        return _dataArray1.count;
    }else{
        return _dataArray2.count;
    }
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView==_leftTableView) {
        NSString * idd =[NSString stringWithFormat:@"%lu%lu",indexPath.row,indexPath.section];
        
        UITableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:idd];
        if (!cell) {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idd];
            UILabel * nameLable =[UILabel new];
            nameLable.textAlignment=1;
            nameLable.alpha=.6;
            nameLable.tag=1;
            nameLable.font=[UIFont systemFontOfSize:15];
            [cell sd_addSubviews:@[nameLable]];
        }
        UILabel * nameLable =(UILabel*)[cell viewWithTag:1];
        nameLable.sd_layout
        .leftSpaceToView(cell,15)
        .rightSpaceToView(cell,15)
        .centerYEqualToView(cell)
        .heightIs(20);
        nameLable.text=_dataArray1[indexPath.row];
        
        return cell;
    }else{
        NSString * idd =[NSString stringWithFormat:@"%lu%lu",indexPath.row,indexPath.section];
        
        UITableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:idd];
        if (!cell) {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idd];
            UILabel * nameLable2 =[UILabel new];
            nameLable2.textAlignment=1;
            nameLable2.alpha=.6;
            nameLable2.tag=2;
            nameLable2.font=[UIFont systemFontOfSize:15];
            [cell sd_addSubviews:@[nameLable2]];
        }
        //
        UILabel * nameLable =(UILabel*)[cell viewWithTag:2];
        nameLable.sd_layout
        .leftSpaceToView(cell,15)
        .rightSpaceToView(cell,15)
        .centerYEqualToView(cell)
        .heightIs(20);
        cell.accessoryType=UITableViewCellAccessoryNone;
        nameLable.text=_dataArray2[indexPath.row];
            return cell;
        
    }
    
    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==_leftTableView) {
        if (indexPath.row==0) {
             _dataArray2=@[@"一期",@"二期",@"三期",@"四期"];
            
        }else{
            _dataArray2=nil;
            _string=_dataArray1[indexPath.row];
        }
        
        [_rightTableView reloadData];
    }else{
        _string=_dataArray2[indexPath.row];
        
    }
}
- (void)show{
    //获取window对象
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    
    UIButton * view = [UIButton buttonWithType:UIButtonTypeCustom];//
    view.frame=CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    [view addTarget:self action:@selector(dissmiss) forControlEvents:UIControlEventTouchUpInside];
    view.backgroundColor = [UIColor blackColor];
    view.alpha = 0.5;
    view.tag=1000;
    [window addSubview:view];
    [window addSubview:self];
    
    [UIView animateWithDuration:1 animations:^{
        self.frame=CGRectMake(0, ScreenHeight-ScreenHeight/2, ScreenWidth, ScreenHeight/2);
        
    }];
    
    
}
-(void)dissmiss{
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    UIView * view =[window viewWithTag:1000];
    
    [view removeFromSuperview];
    [self removeFromSuperview];
}
@end
