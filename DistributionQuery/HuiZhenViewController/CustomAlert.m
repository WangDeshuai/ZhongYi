//
//  CustomAlert.m
//  DistributionQuery
//
//  Created by Macx on 17/4/22.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import "CustomAlert.h"

@interface CustomAlert ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong) UILabel * titlable;
@property(nonatomic,strong)UILabel * jiLuLabel;//记录label
@property(nonatomic,assign)NSInteger tagg;
@end


@implementation CustomAlert

- (id)initWithTitle:(NSString*)title  canCleBtn:(NSString*)btnName1 achiveBtn:(NSString*)btnName2{
    self=[super init];
    if (self) {
        _tagg=1000;
        //标题
        UILabel * titlable =[UILabel new];
        _titlable=titlable;
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
        [achiveBtn addTarget:self action:@selector(achiveBtnClink:) forControlEvents:UIControlEventTouchUpInside];
        
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
        linView.backgroundColor=JXColor(255, 143, 127, 1);
        [self sd_addSubviews:@[linView]];
       
        linView.sd_layout
        .leftSpaceToView(self,0)
        .rightSpaceToView(self,0)
        .topSpaceToView(titlable,15)
        .heightIs(2);
        
        [self CreatTabelView];
    }
    
    return self;
}


#pragma mark --创建表格
-(void)CreatTabelView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]init];
    }
    _tableView.tableFooterView=[UIView new];
    _tableView.backgroundColor=BG_COLOR;
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.keyboardDismissMode=UIScrollViewKeyboardDismissModeOnDrag;
    
    [self sd_addSubviews:@[_tableView]];
    _tableView.sd_layout
    .leftSpaceToView(self,0)
    .rightSpaceToView(self,0)
    .topSpaceToView(_titlable,17)
    .bottomSpaceToView(self,0);
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
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
    .bottomSpaceToView(cell,15);
    nameLable.text=@"脊椎病";
     cell.accessoryType=UITableViewCellAccessoryNone;
    if (_tagg==indexPath.row) {
        nameLable.textColor=JXColor(237, 93, 43, 1);
        cell.accessoryType=UITableViewCellAccessoryCheckmark;
        _jiLuLabel=nameLable;
    }
    
    
    
    
    return cell;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _jiLuLabel.textColor=[UIColor blackColor];
    _tagg=indexPath.row;
    [_tableView reloadData];
}










//完成点击事件
-(void)achiveBtnClink:(UIButton*)btn{
    self.clickBlock(btn);
}

- (void)show{
    //获取window对象
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    //设置中心点
    self.frame=CGRectMake(0, 1000, ScreenWidth, ScreenHeight/2);
    self.backgroundColor=[UIColor whiteColor];
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
