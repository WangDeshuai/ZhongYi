//
//  CustomAlertFive.m
//  DistributionQuery
//
//  Created by Macx on 17/5/10.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import "CustomAlertFive.h"

@interface CustomAlertFive()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView * leftTableView;
@property(nonatomic,strong)UITableView * centerTableView;
@property(nonatomic,strong)UITableView * rightTableView;
@property(nonatomic,strong)UIView * titlable;
@property(nonatomic,strong)NSMutableArray * dataArray1;
@property(nonatomic,strong)NSMutableArray * dataArray2;
@property(nonatomic,strong)NSMutableArray * dataArray3;
@property(nonatomic,copy)NSString * str1;
@property(nonatomic,copy)NSString * str2;
@property(nonatomic,copy)NSString * str3;
@property(nonatomic,strong)ScanCodeModel * md1;
@property(nonatomic,strong)ScanCodeModel * md2;
@property(nonatomic,strong)ScanCodeModel * md3;
@end
@implementation CustomAlertFive

-(id)initWithTitle:(NSString*)title  canCleBtn:(NSString*)btnName1 achiveBtn:(NSString*)btnName2 {
    self=[super init];
    if (self) {
        //设置中心点
        self.frame=CGRectMake(0, 1000, ScreenWidth, ScreenHeight/2);
        self.backgroundColor=[UIColor whiteColor];
        _dataArray1=[NSMutableArray new];
        _dataArray2=[NSMutableArray new];
        _dataArray3=[NSMutableArray new];
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
        [self CreatCenterTableview];
        [self CreatTabelView];
        [self CreatDataID:@""];
        
    }
    
    return self;
}


#pragma mark --创建左边表格
-(void)CreatLeftTabelView{
    if (!_leftTableView) {
        _leftTableView=[[UITableView alloc]init];
    }
    _leftTableView.tableFooterView=[UIView new];
    _leftTableView.backgroundColor=[UIColor whiteColor];
    _leftTableView.delegate=self;
    _leftTableView.dataSource=self;
    _leftTableView.keyboardDismissMode=UIScrollViewKeyboardDismissModeOnDrag;
    
    [self sd_addSubviews:@[_leftTableView]];
    _leftTableView.sd_layout
    .leftSpaceToView(self,0)
    .widthIs(ScreenWidth/3)
    .topSpaceToView(_titlable,17)
    .bottomSpaceToView(self,0);
    
}
#pragma mark --创建中间表格
-(void)CreatCenterTableview{
    if (!_centerTableView) {
        _centerTableView=[[UITableView alloc]init];
    }
    _centerTableView.tableFooterView=[UIView new];
    _centerTableView.backgroundColor=[UIColor whiteColor];
    _centerTableView.delegate=self;
    _centerTableView.dataSource=self;
    _centerTableView.keyboardDismissMode=UIScrollViewKeyboardDismissModeOnDrag;
    
    [self sd_addSubviews:@[_centerTableView]];
    _centerTableView.sd_layout
    .leftSpaceToView(self,ScreenWidth/3)
    .widthIs(ScreenWidth/3)
    .topSpaceToView(_titlable,17)
    .bottomSpaceToView(self,0);
}
//左边表格内容
-(void)CreatDataID:(NSString*)idd{
    [Engine jiaZaiZhuSuMessageID:idd success:^(NSDictionary *dic) {
        NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
        if ([code isEqualToString:@"200"]) {
            NSArray * dataArr =[dic objectForKey:@"data"];
            for (NSDictionary * dicc in dataArr) {
                 ScanCodeModel * md =[[ScanCodeModel alloc]initWithZhuSuDic:dicc];
                [_dataArray1 addObject:md];
            }
            [_leftTableView reloadData];
           
        }else{
            [LCProgressHUD showMessage:[dic objectForKey:@"msg"]];
        }
    } error:^(NSError *error) {
        
    }];
}
//中间边表格内容
-(void)CreatCenterDataID:(NSString*)idd{
    [_dataArray2 removeAllObjects];
    [_dataArray3 removeAllObjects];
    [Engine jiaZaiZhuSuMessageID:idd success:^(NSDictionary *dic) {
        NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
        if ([code isEqualToString:@"200"]) {
            NSArray * dataArr =[dic objectForKey:@"data"];
            for (NSDictionary * dicc in dataArr) {
                ScanCodeModel * md =[[ScanCodeModel alloc]initWithZhuSuDic:dicc];
                [_dataArray2 addObject:md];
            }
            [_centerTableView reloadData];
            
        }else{
            [LCProgressHUD showMessage:[dic objectForKey:@"msg"]];
        }
    } error:^(NSError *error) {
        
    }];
}
//右边边表格内容
-(void)CreatRighrDataID:(NSString*)idd{
    [_dataArray3 removeAllObjects];
    [Engine jiaZaiZhuSuMessageID:idd success:^(NSDictionary *dic) {
        NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
        if ([code isEqualToString:@"200"]) {
            NSArray * dataArr =[dic objectForKey:@"data"];
            for (NSDictionary * dicc in dataArr) {
                ScanCodeModel * md =[[ScanCodeModel alloc]initWithZhuSuDic:dicc];
                [_dataArray3 addObject:md];
            }
            [_rightTableView reloadData];
            
        }else{
            [LCProgressHUD showMessage:[dic objectForKey:@"msg"]];
        }
    } error:^(NSError *error) {
        
    }];
}


#pragma mark --创建表格
-(void)CreatTabelView{
    if (!_rightTableView) {
        _rightTableView=[[UITableView alloc]init];
    }
    _rightTableView.tableFooterView=[UIView new];
    _rightTableView.backgroundColor=[UIColor whiteColor];
    _rightTableView.delegate=self;
    _rightTableView.dataSource=self;
    _rightTableView.keyboardDismissMode=UIScrollViewKeyboardDismissModeOnDrag;
    
    [self sd_addSubviews:@[_rightTableView]];
    _rightTableView.sd_layout
    .rightSpaceToView(self,0)
    .widthIs(ScreenWidth/3)
    .topSpaceToView(_titlable,17)
    .bottomSpaceToView(self,0);
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==_leftTableView) {
        return _dataArray1.count;
    }else if (tableView==_centerTableView){
        return _dataArray2.count;
    }else{
        return _dataArray3.count;
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
            nameLable.font=[UIFont systemFontOfSize:14];
            [cell sd_addSubviews:@[nameLable]];
        }
        ScanCodeModel * md =_dataArray1[indexPath.row];
        UILabel * nameLable =(UILabel*)[cell viewWithTag:1];
        nameLable.sd_layout
        .leftSpaceToView(cell,15)
        .rightSpaceToView(cell,15)
        .centerYEqualToView(cell)
        .autoHeightRatio(0);
        nameLable.text=md.zhuSuName;
        return cell;
    }else if (tableView==_centerTableView) {
        NSString * idd =[NSString stringWithFormat:@"%lu%lu",indexPath.row,indexPath.section];
        
        UITableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:idd];
        if (!cell) {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idd];
            UILabel * nameLable2 =[UILabel new];
            nameLable2.textAlignment=1;
            nameLable2.alpha=.6;
            nameLable2.tag=2;
            nameLable2.font=[UIFont systemFontOfSize:14];
            [cell sd_addSubviews:@[nameLable2]];
        }
        //
        UILabel * nameLable =(UILabel*)[cell viewWithTag:2];
        nameLable.sd_layout
        .leftSpaceToView(cell,15)
        .rightSpaceToView(cell,15)
        .centerYEqualToView(cell)
        .autoHeightRatio(0);
        cell.accessoryType=UITableViewCellAccessoryNone;
        ScanCodeModel * md =_dataArray2[indexPath.row];
        nameLable.text=md.zhuSuName;
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
            nameLable2.font=[UIFont systemFontOfSize:14];
            [cell sd_addSubviews:@[nameLable2]];
        }
        //
        UILabel * nameLable =(UILabel*)[cell viewWithTag:2];
        nameLable.sd_layout
        .leftSpaceToView(cell,15)
        .rightSpaceToView(cell,15)
        .centerYEqualToView(cell)
        .autoHeightRatio(0);
        cell.accessoryType=UITableViewCellAccessoryNone;
        ScanCodeModel * md =_dataArray3[indexPath.row];
        nameLable.text=md.zhuSuName;
        return cell;
        
    }
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==_leftTableView) {
          ScanCodeModel * md =_dataArray1[indexPath.row];
        _str1=md.zhuSuName;
        _md1=md;
        [self CreatCenterDataID:md.zhuSuID];
    }else if (tableView==_centerTableView){
        ScanCodeModel * md =_dataArray2[indexPath.row];
         _str2=md.zhuSuName;
        _md2=md;
        [self CreatRighrDataID:md.zhuSuID];
    }else{
         ScanCodeModel * md =_dataArray3[indexPath.row];
         _str3=md.zhuSuName;
        _md3=md;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_leftTableView==tableView) {
       ScanCodeModel * md = _dataArray1[indexPath.row];
      return   [ToolClass HeightForText:md.zhuSuName withSizeOfLabelFont:18 withWidthOfContent:ScreenWidth/3-20];
    }else if (_centerTableView==tableView){
         ScanCodeModel * md = _dataArray2[indexPath.row];
        return [ToolClass HeightForText:md.zhuSuName withSizeOfLabelFont:18 withWidthOfContent:ScreenWidth/3-20]+15;
    }else{
         ScanCodeModel * md = _dataArray3[indexPath.row];
         return [ToolClass HeightForText:md.zhuSuName withSizeOfLabelFont:18 withWidthOfContent:ScreenWidth/3-20]+15;
    }
}

#pragma mark --完成
-(void)achiveBtnClink{
    NSLog(@">>>>%@",_md1);
    self.NameBlock([self textString:_md1 Str:_md2 Str3:_md3]);
}


-(ScanCodeModel*)textString:(ScanCodeModel*)str1 Str:(ScanCodeModel*)str2 Str3:(ScanCodeModel*)str3{
    if (str3) {
        return str3;
    }else if (str2){
        return str2;
    }else if (str1){
        return str1;
    }else{
        return nil;
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
