//
//  ScanCodeVC.m
//  DistributionQuery
//
//  Created by Macx on 16/10/8.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "ScanCodeVC.h"
#import "ScanCodeCell.h"
#import "CustomAlert.h"
@interface ScanCodeVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSArray * imageArray;
@property(nonatomic,strong)UITableView * tableView;
@end

@implementation ScanCodeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self imageData];
    [self CreatTabelView];
    [self publicButton];
}

-(void)imageData{
    NSArray * imageArr1=@[@"sbhz_lx",@"sbhz_admin"];
    NSArray * imageArr2=@[@"sbhz_bm",@"sbhz_bl",@"sbhz_zs",@"sbhz_st",@"sbhz_mx"];
    NSArray * imageArr3=@[@"sbhz_fl",@"sbhz_fq"];
    NSArray * imageArr4=@[@"sbhz_question"];
     _imageArray=@[imageArr1,imageArr2,imageArr3,imageArr4];
}


#pragma mark --创建发布按钮
-(void)publicButton{
    
    UIButton * button =[UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"发布" forState:0];
    button.frame=CGRectMake(15, 510+30+125, ScreenWidth-30, 40);
    button.backgroundColor=JXColor(254, 81, 15, 1);
    button.layer.cornerRadius=5;
    button.clipsToBounds=YES;
    [_tableView addSubview:button];
    [_tableView setContentInset:UIEdgeInsetsMake(0, 0, 70+30+50, 0)];
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
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _imageArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_imageArray[section] count];
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   ScanCodeCell * cell =[ScanCodeCell cellWithTableView:tableView CellID:[NSString stringWithFormat:@"%lu%lu",indexPath.row,indexPath.section]];
    [self tableviewCellNeiBu:cell NSIndex:indexPath];
    return cell;
}

#pragma mark --表的点击
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CustomAlert * alertView =[[CustomAlert alloc]initWithTitle:@"病名" canCleBtn:@"取消" achiveBtn:@"完成"];
    alertView.clickBlock=^(UIButton*btn){
        
    };
    [alertView show];
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5;
}
#pragma mark --区尾
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView * headView =[UIView new];
    headView.backgroundColor=[UIColor whiteColor];
    
    if (section==0) {
        int k= (ScreenWidth-2)/3;
        //姓名
        UITextField * nameText =[UITextField new];
        nameText.textAlignment=1;
        //    nameText.backgroundColor=[UIColor yellowColor];
        nameText.placeholder=@"姓名";
        nameText.font=[UIFont systemFontOfSize:15];
        [headView sd_addSubviews:@[nameText]];
        nameText.sd_layout
        .leftSpaceToView(headView,0)
        .topSpaceToView(headView,0)
        .bottomSpaceToView(headView,0)
        .widthIs(k);
        
        UIView * linView1 =[UIView new];
        linView1.backgroundColor=BG_COLOR;
        [headView sd_addSubviews:@[linView1]];
        linView1.sd_layout
        .leftSpaceToView(nameText,0)
        .widthIs(1)
        .topSpaceToView(headView,0)
        .bottomSpaceToView(headView,0);
        
        //性别
        UIButton * sexBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        [sexBtn setTitle:@"性别" forState:0];
        //    sexBtn.backgroundColor=[UIColor magentaColor];
        sexBtn.titleLabel.font=[UIFont systemFontOfSize:15];
        [headView sd_addSubviews:@[sexBtn]];
        [sexBtn setTitleColor:[UIColor lightGrayColor] forState:0];
        sexBtn.sd_layout
        .leftSpaceToView(nameText,0)
        .bottomSpaceToView(headView,0)
        .widthIs(k)
        .topSpaceToView(headView,0);
        
        UIView * linView2 =[UIView new];
        linView2.backgroundColor=BG_COLOR;
        [headView sd_addSubviews:@[linView2]];
        linView2.sd_layout
        .leftSpaceToView(sexBtn,0)
        .widthIs(1)
        .topSpaceToView(headView,0)
        .bottomSpaceToView(headView,0);
        
        
        //年龄
        UITextField * nianLingText =[UITextField new];
        //  nianLingText.backgroundColor=[UIColor greenColor];
        nianLingText.textAlignment=1;
        nianLingText.placeholder=@"年龄";
        nianLingText.font=[UIFont systemFontOfSize:15];
        [headView sd_addSubviews:@[nianLingText]];
        nianLingText.sd_layout
        .rightSpaceToView(headView,0)
        .topSpaceToView(headView,0)
        .bottomSpaceToView(headView,0)
        .widthIs(k);
    }
    
   
    
    
    
    return headView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section==0) {
        return 50;
    }else{
        return 0;
    }
}
#pragma mark --Cell内部
-(void)tableviewCellNeiBu:(ScanCodeCell*)cell NSIndex:(NSIndexPath*)indexPath{
    cell.imageview.image=[UIImage imageNamed:_imageArray[indexPath.section][indexPath.row]];
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            cell.textfield.placeholder=@"选择类型";
        }else if (indexPath.row==1){
            cell.textfield.text=@"患者信息";
            cell.accessoryType=UITableViewCellAccessoryNone;
        }
        
    }else if (indexPath.section==1){
        if (indexPath.row==0) {
            cell.textfield.placeholder=@"病名";
        }else if (indexPath.row==1){
            cell.textfield.placeholder=@"病理";
        }else if (indexPath.row==2){
            cell.textfield.placeholder=@"主诉";
        }else if (indexPath.row==3){
            cell.textfield.placeholder=@"舌苔";
        }else if (indexPath.row==4){
            cell.textfield.placeholder=@"脉象";
        }
    }else if (indexPath.section==2){
        if (indexPath.row==0) {
             cell.textfield.placeholder=@"有无放化疗";
        }else{
             cell.textfield.placeholder=@"TNM分期";
             cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        }
    }else if (indexPath.section==3){
         cell.accessoryType=UITableViewCellAccessoryNone;
        cell.textfield.placeholder=@"主要会诊问题描述";
        [cell sd_addSubviews:@[cell.imageview]];
        cell.imageview.sd_layout
        .leftSpaceToView(cell,15)
        .topSpaceToView(cell,15)
        .widthIs(16)
        .heightIs(16);
        cell.textview.hidden=NO;
        
    }
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==3) {
        return 120;
    }else{
//        if ([ToolClass isiPad]) {
//            return 65;
//        }
        return 50;
    }
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
