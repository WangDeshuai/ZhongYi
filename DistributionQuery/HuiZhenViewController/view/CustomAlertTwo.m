//
//  CustomAlertTwo.m
//  DistributionQuery
//
//  Created by Macx on 17/4/27.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import "CustomAlertTwo.h"
#import "LeftMyAdressCell.h"
#import "RightMyAddressCell.h"
@interface CustomAlertTwo()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * rightTableView;
@property(nonatomic,strong)UITableView * leftTableView;
@property(nonatomic,strong)UIView * titlable;
@property(nonatomic,strong)UILabel * jiLuLabel;//记录label
@property(nonatomic,assign)NSInteger tagg;//第一级菜单
//@property(nonatomic,strong)NSArray * dataArray;
@property(nonatomic,strong)NSMutableArray * dataArr;
@property(nonatomic,strong)NSMutableArray * dataArr2;
@property(nonatomic,strong)ScanCodeModel * md;
@property(nonatomic,strong)ScanCodeModel * mdd;//判断1级病名
@property(nonatomic,strong)ScanCodeModel * md2;//tagg=2的时候 分别记录舌苔 舌质的
@end

@implementation CustomAlertTwo
- (id)initWithTitle:(NSString*)title  canCleBtn:(NSString*)btnName1 achiveBtn:(NSString*)btnName2  Tag:(NSInteger)tag{
    self=[super init];
    if (self) {
        _tagg=tag;
        _dataArr=[NSMutableArray new];
        _dataArr2=[NSMutableArray new];
        //设置中心点
        self.frame=CGRectMake(0, 1000, ScreenWidth, ScreenHeight/2);
        self.backgroundColor=BG_COLOR;//[UIColor whiteColor];
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
        linView.backgroundColor=MAIN_COLOR;
          _titlable=linView;
        [self sd_addSubviews:@[linView]];
        
        linView.sd_layout
        .leftSpaceToView(self,0)
        .rightSpaceToView(self,0)
        .topSpaceToView(titlable,15)
        .heightIs(2);
        
        
        if ([ToolClass isiPad]) {
            titlable.font=[UIFont systemFontOfSize:20];
            canBtn.titleLabel.font=[UIFont systemFontOfSize:20];
            achiveBtn.titleLabel.font=[UIFont systemFontOfSize:20];
        }
        
        
       
        if (tag==1) {
            //病名
            [self huoQuBingMingMessageDataID:@""];
        }else if(tag==2){
            //舌苔 舌质
            NSArray * titleAr=@[@"舌质",@"舌苔"];
            for (int i =0; i<titleAr.count; i++) {
                UILabel * namelabel =[UILabel new];
                namelabel.text=titleAr[i];
                namelabel.textAlignment=1;
                namelabel.font=[UIFont systemFontOfSize:16];
                namelabel.alpha=.6;
                [self sd_addSubviews:@[namelabel]];
                namelabel.sd_layout
                .leftSpaceToView(self,ScreenWidth/2*i)
                .topSpaceToView(linView,15)
                .heightIs(20)
                .widthIs(ScreenWidth/2);
                
            }
            
            //线条
            UIView * linView2 =[UIView new];
            _titlable=linView2;
            linView2.backgroundColor=MAIN_COLOR;
            [self sd_addSubviews:@[linView2]];
            
            linView2.sd_layout
            .leftSpaceToView(self,0)
            .rightSpaceToView(self,0)
            .topSpaceToView(linView,50)
            .heightIs(2);
           
            [self sheZhiData];//舌质
             [self sheTaiData];//舌苔
        }
    }
    //二级分类
    [self CreatLeftTabelView];
    [self CreatTabelView];
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
    if ([ToolClass isiPad]) {
        _leftTableView.rowHeight=60;
    }else{
        _leftTableView.rowHeight=44;
    }
    [self sd_addSubviews:@[_leftTableView]];
    _leftTableView.sd_layout
    .leftSpaceToView(self,0)
    .widthIs(ScreenWidth/2)
    .topSpaceToView(_titlable,0)
    .bottomSpaceToView(self,0);
    
}

//tag==1 (病名接口)
-(void)huoQuBingMingMessageDataID:(NSString*)idd{
    [Engine1 jiaZaiBingMingAllMessageID:idd success:^(NSDictionary *dic) {
        NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
        if ([code isEqualToString:@"200"]) {
            NSArray * dataArr =[dic objectForKey:@"data"];
            for (NSDictionary * dicc in dataArr) {
                ScanCodeModel * model =[[ScanCodeModel alloc]initWithBingMingDic:dicc];
                [_dataArr addObject:model];
            }
            [_leftTableView reloadData];
        }else{
            [LCProgressHUD showMessage:[dic objectForKey:@"msg"]];
        }
    } error:^(NSError *error) {
         [LCProgressHUD showMessage:@"失败"];
    } ];
}
//二级病名
-(void)huoQuBingMingMessageTwoDataID:(NSString*)idd{
    [_dataArr2 removeAllObjects];
    
    [Engine1 jiaZaiBingMingAllMessageID:idd success:^(NSDictionary *dic) {
        NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
        if ([code isEqualToString:@"200"]) {
            NSArray * dataArr =[dic objectForKey:@"data"];
            for (NSDictionary * dicc in dataArr) {
                ScanCodeModel * model =[[ScanCodeModel alloc]initWithBingMingDic:dicc];
                [_dataArr2 addObject:model];
            }
            [_rightTableView reloadData];
        }else{
            [LCProgressHUD showMessage:[dic objectForKey:@"msg"]];
        }
    } error:^(NSError *error) {
        [LCProgressHUD showMessage:@"失败"];
    } ];
}


//tagg==2舌苔 舌质
-(void)sheTaiData{
    [Engine1 jiaZaiAllSheMessagesuccess:^(NSDictionary *dic) {
        NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
        if ([code isEqualToString:@"200"]) {
            NSArray * dataArr =[dic objectForKey:@"data"];
            for (NSDictionary * dicc in dataArr) {
                ScanCodeModel * md =[[ScanCodeModel alloc]initWithSheTaiDic:dicc];
                [_dataArr2 addObject:md];
            }
            [_rightTableView reloadData];
        }else{
            [LCProgressHUD showMessage:[dic objectForKey:@"msg"]];
        }
    } error:^(NSError *error) {
        
    }];
}
//舌质
-(void)sheZhiData{
    [Engine1 jiaZaiAllSheZhiMessagesuccess:^(NSDictionary *dic) {
        NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
        if ([code isEqualToString:@"200"]) {
            NSArray * dataArr =[dic objectForKey:@"data"];
            for (NSDictionary * dicc in dataArr) {
                ScanCodeModel * md =[[ScanCodeModel alloc]initWithSheZhiDic:dicc];
                 [_dataArr addObject:md];
            }
            [_leftTableView reloadData];
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
    if ([ToolClass isiPad]) {
        _rightTableView.rowHeight=60;
    }else{
        _rightTableView.rowHeight=44;
    }

    [self sd_addSubviews:@[_rightTableView]];
    _rightTableView.sd_layout
    .leftSpaceToView(self,ScreenWidth/2)
    .widthIs(ScreenWidth/2)
    .topSpaceToView(_titlable,0)
    .bottomSpaceToView(self,0);
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==_leftTableView) {
        if (_tagg==1) {
            return _dataArr.count;
        }else{
           return _dataArr.count;
        }
      
    }else{
        if (_tagg==1) {
            return _dataArr2.count;
        }else{
            return _dataArr2.count;
        }
    }
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView==_leftTableView) {
//        NSString * idd =[NSString stringWithFormat:@"%lu%lu",indexPath.row,indexPath.section];
//        
//        UITableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:idd];
//        if (!cell) {
//            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idd];
//            UILabel * nameLable =[UILabel new];
//            nameLable.textAlignment=1;
//            nameLable.alpha=.6;
//            nameLable.tag=1;
//            nameLable.font=[UIFont systemFontOfSize:15];
//            [cell sd_addSubviews:@[nameLable]];
//        }
//        UILabel * nameLable =(UILabel*)[cell viewWithTag:1];
//        nameLable.sd_layout
//        .leftSpaceToView(cell,15)
//        .rightSpaceToView(cell,15)
//        .centerYEqualToView(cell)
//        .heightIs(20);
        LeftMyAdressCell * cell =[LeftMyAdressCell cellWithTableView:tableView];
        if (_tagg==1) {
            ScanCodeModel * md =_dataArr[indexPath.row];
//            nameLable.text=md.bingMingName;
            cell.name=md.bingMingName;
        }else if(_tagg==2){
            ScanCodeModel * md =_dataArr[indexPath.row];
//            nameLable.text=md.sheZhiName;
            cell.name=md.sheZhiName;
        }
       

        return cell;
    }else{
        RightMyAddressCell * cell =[RightMyAddressCell cellWithTableView:tableView];
//        NSString * idd =[NSString stringWithFormat:@"%lu%lu",indexPath.row,indexPath.section];
//        
//        UITableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:idd];
//        if (!cell) {
//            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idd];
//            UILabel * nameLable2 =[UILabel new];
//            nameLable2.textAlignment=1;
//            nameLable2.alpha=.6;
//            nameLable2.tag=2;
//            nameLable2.font=[UIFont systemFontOfSize:15];
//            [cell sd_addSubviews:@[nameLable2]];
//        }
//        // 
//        UILabel * nameLable =(UILabel*)[cell viewWithTag:2];
//        nameLable.sd_layout
//        .leftSpaceToView(cell,15)
//        .rightSpaceToView(cell,15)
//        .centerYEqualToView(cell)
//        .heightIs(20);
//        cell.accessoryType=UITableViewCellAccessoryNone;
       //
        if (_tagg==1) {
            ScanCodeModel * md =_dataArr2[indexPath.row];
//            nameLable.text=md.bingMingName;
            cell.name=md.bingMingName;
        }else if(_tagg==2){
             ScanCodeModel * md =_dataArr2[indexPath.row];
//             nameLable.text=md.sheTaiName;
            cell.name=md.sheTaiName;
        }
        return cell;
        
    }
    
    
    
    
    
    
    
   
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==_leftTableView) {
        if (_tagg==1) {
            ScanCodeModel * md =_dataArr[indexPath.row];
            _mdd=md;
            [self huoQuBingMingMessageTwoDataID:md.bingMingID];
        }else if (_tagg==2){
             ScanCodeModel * md =_dataArr[indexPath.row];
            _md2=md;
        }
       
    }else{
        if (_tagg==1) {
            ScanCodeModel * md =_dataArr2[indexPath.row];
            _md=md;
        }else if (_tagg==2){
            ScanCodeModel * md =_dataArr2[indexPath.row];
            _md=md;
        }
        
    }
    
   
}






-(ScanCodeModel*)sss:(ScanCodeModel*)md1 aaa:(ScanCodeModel*)mdd{
    if (md1) {
        return md1;
    }else{
        return mdd;
    }
}



//完成点击事件
-(void)achiveBtnClink:(UIButton*)btn{
    if (_tagg==1) {
         self.clickBlock(btn,[self sss:_md aaa:_mdd],_md2);
    }else if (_tagg==2){
         self.clickBlock(btn,_md,_md2);
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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
