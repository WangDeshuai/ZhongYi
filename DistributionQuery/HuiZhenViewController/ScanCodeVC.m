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
#import "CustomAlertTwo.h"
#import "ScanCodeModel.h"
#import "CustomAlertThree.h"
#import "CustomAlertFour.h"
#import "CustomAlertFive.h"
@interface ScanCodeVC ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UITextViewDelegate>
@property(nonatomic,strong)UIButton * sexBtn;
@property(nonatomic,strong)NSMutableArray * image2;
@property(nonatomic,strong)NSArray * imageArray;
@property(nonatomic,strong)UITableView * tableView;
@property (nonatomic, assign) BOOL isSelect;
@property(nonatomic,copy)NSString * name;//姓名
@property(nonatomic,copy)NSString * age;//年龄
@property(nonatomic,copy)NSString  * leiXing;//类型
@property(nonatomic,copy)NSString  * xingBie;//性别
@property(nonatomic,copy)NSString * bingMing;//病名
@property(nonatomic,copy)NSString * bingMingID;//病名IDddddddddd
@property(nonatomic,copy)NSString * bingLi;//病理
@property(nonatomic,copy)NSString * bingLiID;//病理IDdddddddd(没找到)
@property(nonatomic,copy)NSString * sheTaiZhi;//舌苔 舌质综合
@property(nonatomic,copy)NSString * sheZhi;//舌质
@property(nonatomic,copy)NSString * sheTai;//舌质
@property(nonatomic,copy)NSString * sheZhiID;//舌质iddddddd
@property(nonatomic,copy)NSString * sheTaiID;//舌质iddddddd
@property(nonatomic,copy)NSString * maiXiang;//脉象
@property(nonatomic,copy)NSString * maiXiangID;//脉象idddd(没找到)
@property(nonatomic,copy)NSString * youWuHuaLiao;//有无化疗
@property(nonatomic,copy)NSString * youWuFangLiao;//有无放疗
@property(nonatomic,copy)NSString * shouShu;//手术
@property(nonatomic,copy)NSString * tnmStr;//tNm分期(展示用)
@property(nonatomic,copy)NSString * tnmStrID;
@property(nonatomic,copy)NSString * zhuSuStr;//主诉
@property(nonatomic,copy)NSString * zhuSuStrID;//主诉ID
@property(nonatomic,copy)NSString * wenTiMiaoShu;//问题描述
@property(nonatomic,copy)NSString * zhuSuStr2;//主诉
@property(nonatomic,copy)NSString * zhuSuStrID2;//主诉ID
@property(nonatomic,copy)NSString * zhuSuStr3;//主诉
@property(nonatomic,copy)NSString * zhuSuStrID3;//主诉ID
@property(nonatomic,copy)NSString * zhuSuStr4;//主诉
@property(nonatomic,copy)NSString * zhuSuStrID4;//主诉ID
@end

@implementation ScanCodeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"三辩会诊";
    [self CreatRightBtn];
    [self imageData];
    [self CreatTabelView];
   // [self publicButton];
}

-(void)CreatRightBtn{
    UIButton*  backHomeBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [backHomeBtn setTitle:@"提交" forState:0];
    [backHomeBtn setTitleColor:MAIN_COLOR forState:0];
    backHomeBtn.frame=CGRectMake(0, 0, 100, 30);
    backHomeBtn.titleLabel.font=[UIFont systemFontOfSize:15];
    backHomeBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentRight;
    [backHomeBtn addTarget:self action:@selector(publicBtnClink) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftBtn2 =[[UIBarButtonItem alloc]initWithCustomView:backHomeBtn];
    self.navigationItem.rightBarButtonItems=@[leftBtn2];
}




-(void)imageData{
    NSArray * imageArr1=@[@"sbhz_lx",@"sbhz_admin"];//
   // NSArray * imageArr2=@[@"sbhz_bm",@"sbhz_bl",@"sbhz_mx",@"sbhz_st",@"sbhz_zs"];
    _image2=[[NSMutableArray alloc]initWithObjects:@"sbhz_bm",@"sbhz_bl",@"sbhz_mx",@"sbhz_st",@"sbhz_zs", nil];
    
    NSArray * imageArr3=@[@"sbhz_fl",@"sbhz_fl",@"sbhz_fq",@"sbhz_fl"];
    NSArray * imageArr4=@[@"sbhz_question"];
     _imageArray=@[imageArr1,_image2,imageArr3,imageArr4];
}


//#pragma mark --创建发布按钮
//-(void)publicButton{
//    
//    UIButton * button =[UIButton buttonWithType:UIButtonTypeCustom];
//    [button setTitle:@"发布" forState:0];
//    button.frame=CGRectMake(15, 665+50*3, ScreenWidth-30, 40);
//    button.backgroundColor=JXColor(254, 81, 15, 1);
//    [button addTarget:self action:@selector(publicBtnClink) forControlEvents:UIControlEventTouchUpInside];
//    button.layer.cornerRadius=5;
//    button.clipsToBounds=YES;
//    [_tableView addSubview:button];
//    [_tableView setContentInset:UIEdgeInsetsMake(0, 0, 70+30+50, 0)];
//}

#pragma mark --发布信息
-(void)publicBtnClink{
   //类型
    NSLog(@"选择类型>>>%@>>>id=%@",_leiXing, [ToolClass quChuLaiStr:_leiXing]);
    //姓名
    NSLog(@"姓名>>>%@",_name);
    //性别
     NSLog(@"姓名>>>%@>>>id=%@",_xingBie,[ToolClass quChuLaiStr:_xingBie]);
    //年龄
    NSLog(@"年龄>>>%@",_age);
    //病名
    NSLog(@"病名>>>%@>>>id=%@",_bingMing,_bingMingID);
    //病理
      NSLog(@"病理>>>%@>>>>ID=%@",_bingLi,_bingLiID);
    //脉象
      NSLog(@"脉象>>>%@>>>id=%@",_maiXiang,_maiXiangID);
    //舌苔
      NSLog(@"舌苔>>>%@>>>id=%@",_sheTai,_sheTaiID);
    //舌质
      NSLog(@"舌质>>>%@>>>id=%@",_sheZhi,_sheZhiID);
    //主诉
      NSLog(@"主诉>>>%@>>>>id=%@",_zhuSuStr,_zhuSuStrID);
     NSLog(@"主诉2>>>%@>>>>id2=%@",_zhuSuStr2,_zhuSuStrID2);
     NSLog(@"主诉3>>>%@>>>>id3=%@",_zhuSuStr3,_zhuSuStrID3);
     NSLog(@"主诉4>>>%@>>>>id4=%@",_zhuSuStr4,_zhuSuStrID4);
    
    NSMutableArray * array =[NSMutableArray new];
    if (![_zhuSuStrID isEqualToString:@""] && _zhuSuStrID!=nil) {
        [array addObject:_zhuSuStrID];
    }
    if (![_zhuSuStrID2 isEqualToString:@""] && _zhuSuStrID2!=nil) {
        [array addObject:_zhuSuStrID2];
    }
    if (![_zhuSuStrID3 isEqualToString:@""] && _zhuSuStrID3!=nil) {
        [array addObject:_zhuSuStrID3];
    }
    if (![_zhuSuStrID4 isEqualToString:@""] && _zhuSuStrID4!=nil) {
        [array addObject:_zhuSuStrID4];
    }
    
    
    
    
  
    NSLog(@">>>主诉%@",[array componentsJoinedByString:@","] );
    
    
    
    
    //有无放疗
    NSLog(@">>>%@",_youWuFangLiao);
    NSLog(@"有无放疗>>>%@>>>期数=%@",[self ShaiXuanYouWuFnagHuStr:_youWuFangLiao],[self ShaiXuanYouWuFnagHuQiShuStr:_youWuFangLiao]);
    //有无化疗
    NSLog(@">>>%@",_youWuHuaLiao);
    NSLog(@"有无化疗>>>%@>>>期数=%@",[self ShaiXuanYouWuFnagHuStr:_youWuHuaLiao],[self ShaiXuanYouWuFnagHuQiShuStr:_youWuHuaLiao]);
    //TNM分期
    NSLog(@"TNM分期>>>%@",_tnmStrID);
    //手术
     NSLog(@"手术>>>%@>>>id=%@",_shouShu,[ToolClass quChuLaiStr:_shouShu]);
    //主要问题描述
    NSLog(@"问题描述>>>%@",_wenTiMiaoShu);
    [LCProgressHUD showLoading:@"请稍后..."];
    [Engine saveBaoGaoDanID:@"" Type:[ToolClass quChuLaiStr:_leiXing] XingMing:_name Sex:[ToolClass quChuLaiStr:_xingBie] Age:_age BingMingID:_bingMingID ZhuSuID:[array componentsJoinedByString:@","] BingLiID:_bingLiID MaiXiangID:_maiXiangID SheZhiID:_sheZhiID SheTaiID:_sheTaiID YouWuFangYN:[self ShaiXuanYouWuFnagHuStr:_youWuFangLiao] FangZhouQi:[self ShaiXuanYouWuFnagHuQiShuStr:_youWuFangLiao] HuaYN:[self ShaiXuanYouWuFnagHuStr:_youWuHuaLiao] HuaZhouQi:[self ShaiXuanYouWuFnagHuQiShuStr:_youWuHuaLiao] ShouShuID:[ToolClass quChuLaiStr:_shouShu] TNMfen:_tnmStrID Pro:_wenTiMiaoShu success:^(NSDictionary *dic) {
        
        NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
        [LCProgressHUD showMessage:[dic objectForKey:@"msg"]];
        if ([code isEqualToString:@"200"]) {
            //清空信息
            [LCProgressHUD hide];
            [self dissMissContent];
        }else{
        }
        
        
    } error:^(NSError *error) {
        
    }];
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

//获取病名
-(void)huoQuBingMingMessageData{
//    [Engine jiaZaiBingMingAllMessagesuccess:^(NSDictionary *dic) {
//        
//    } error:^(NSError *error) {
//        
//    }];
}



#pragma mark --表的点击
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    [_tableView endEditing:YES];
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            //选择类型
            [self ShowAlerViewNSArray:@[@"肿瘤会诊",@"其它疑难杂症"] Title:@"选择类型" intt:0];
        }
    }else if(indexPath.section==1){
        if (indexPath.row==0) {
            //病名(2级)
            [self ShowAlerViewTwoTag:1];
        }else if (indexPath.row==1){
            //病理
            if (self.isSelect == false) {
                self.isSelect = true;
                [self performSelector:@selector(repeatDelay) withObject:nil afterDelay:1];
                // 在下面实现点击cell需要实现的逻辑就可以了
                 [self BingLiData];
            }

            
          
        }else if (indexPath.row==2){
            //脉象
            if (self.isSelect == false) {
                self.isSelect = true;
                [self performSelector:@selector(repeatDelay) withObject:nil afterDelay:1];
                // 在下面实现点击cell需要实现的逻辑就可以了
                 [self maiXiangData];
            }
            
            
            
        }else if (indexPath.row==3){
            //舌苔 舌质(2级)
             [self ShowAlerViewTwoTag:2];;
        }else if (indexPath.row==4){
            //主诉
            [self alevrViewZhuSuTag:1];
        }else if (indexPath.row==5){
            //主诉2
            [self alevrViewZhuSuTag:2];
        }else if (indexPath.row==6){
            //主诉3
            [self alevrViewZhuSuTag:3];
        }else if (indexPath.row==7){
            //主诉4
            [self alevrViewZhuSuTag:4];
        }
    }else if(indexPath.section==2){
        if (indexPath.row==0) {
            //有无放疗
            [self alevrViewThreeTitle:@"有无放疗" Tag:0];
        }else if (indexPath.row==1){
            //有无化疗
            [self alevrViewThreeTitle:@"有无化疗" Tag:1];
        }else if (indexPath.row==2){
            //TNM分期
            [self alevrViewTNMTitle:@"TNM分期"];
        }else if (indexPath.row==3){
            //手术
            [self ShowAlerViewNSArray:@[@"有",@"无"] Title:@"手术" intt:4];
        }
    }
    
    
   
}
- (void)repeatDelay{
    
    self.isSelect = false;
    
}
//病理数据解析
-(void)BingLiData{
    [Engine jiaZaiBingLiMessagesuccess:^(NSDictionary *dic) {
        NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
        NSMutableArray * dataTitle=[NSMutableArray new];
        if ([code isEqualToString:@"200"]) {
            NSArray * dataArr =[dic objectForKey:@"data"];
            for (NSDictionary * dicc in dataArr) {
                ScanCodeModel * md =[[ScanCodeModel alloc]initWithBingLiDic:dicc];
                [dataTitle addObject:md];
            }
            //2代表病理
             [self ShowAlerViewNSArray:dataTitle Title:@"病理" intt:2];
            
            
        }else{
            [LCProgressHUD showMessage:[dic objectForKey:@"msg"]];
        }
    } error:^(NSError *error) {
        
    }];
}
//脉象数据解析
-(void)maiXiangData{
    [Engine jiaZaiAllMaiXiangMessagesuccess:^(NSDictionary *dic) {
        NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
        NSMutableArray * dataTitle=[NSMutableArray new];
        if ([code isEqualToString:@"200"]) {
            NSArray * dataArr =[dic objectForKey:@"data"];
            for (NSDictionary * dicc in dataArr) {
                ScanCodeModel * md=[[ScanCodeModel alloc]initWithMaiXiangDic:dicc];
                [dataTitle addObject:md];
            }
            //3代表脉象
            [self ShowAlerViewNSArray:dataTitle Title:@"脉象"  intt:3];
            
        }else{
          [LCProgressHUD showMessage:[dic objectForKey:@"msg"]];
        }
    } error:^(NSError *error) {
        
    }];
}


#pragma mark --显示弹框1
-(void)ShowAlerViewNSArray:(NSArray*)contentArr Title:(NSString*)title intt:(int)tag{
    /*
     tagg==0  第一行其它疑难杂症
     tagg==1  性别
     tagg==2  病理
     tagg==3  脉象
     tagg==4  手术
     */
    CustomAlert * alertView=nil;
    [alertView dissmiss];
     alertView =[[CustomAlert alloc]initWithTitle:title canCleBtn:@"取消" achiveBtn:@"完成" contentArray:contentArr];
    __weak __typeof(alertView)weakSelf = alertView;
    alertView.clickBlock=^(ScanCodeModel*mdd,NSString*name){
        if (tag==0) {
            _leiXing=name;
        }else if (tag==1){
            _xingBie=name;
        }else if (tag==2){
            _bingLi=mdd.bingLiName;//(病理ID)
            _bingLiID=mdd.bingLiID;
        }else if(tag==3){
            _maiXiang=mdd.maiXiangName;//脉象(ID)
            _maiXiangID=mdd.maiXiangID;
        }else if (tag==4){
            _shouShu=name;
        }
        [_tableView reloadData];
        [weakSelf dissmiss];
    };
    [alertView show];
}
#pragma mark --显示弹框2(病名、舌苔)
-(void)ShowAlerViewTwoTag:(NSInteger)tag{
    /*
     tag==1 (病名)  tag==2(舌苔)
     contentArray 内容Array
     */
    CustomAlertTwo * alertView =[[CustomAlertTwo alloc]initWithTitle:@"病名" canCleBtn:@"取消" achiveBtn:@"完成" Tag:tag];
     __weak __typeof(alertView)weakSelf = alertView;
    alertView.clickBlock=^(UIButton*btn,ScanCodeModel*md,ScanCodeModel*md2){
        if(tag==1){
            _bingMing=md.bingMingName;
            _bingMingID=md.bingMingID;
        }else if (tag==2){
            //md2是舌苔 md是舌质
            NSLog(@">>>%@>>>>%@",md2.sheTaiName,md.sheZhiName);
            _sheTaiZhi=[NSString stringWithFormat:@"舌苔:%@ 舌质:%@",md2.sheTaiName,md.sheZhiName];
            _sheTai=md2.sheTaiName;
            _sheTaiID=md2.sheTaiID;
            _sheZhi=md.sheZhiName;
            _sheZhiID=md.sheZhiID;
            
        }
          [_tableView reloadData];
          [weakSelf dissmiss];
    };
    [alertView show];
}
#pragma mark --显示弹框3(有无放疗、有无化疗)
-(void)alevrViewThreeTitle:(NSString*)title Tag:(int)tag{
    //tag==0 有无放疗
    //tagg==1 有无化疗
    CustomAlertThree * vc =[[CustomAlertThree alloc]initWithTitle:title canCleBtn:@"取消" achiveBtn:@"完成" ];
    __weak __typeof(vc)weakSelf = vc;
    vc.NameBlock=^(NSString*name){
        if (tag==0) {
            _youWuFangLiao=name;
        }else{
            _youWuHuaLiao=name;
        }
         [_tableView reloadData];
         [weakSelf dissmiss];
    };
    [vc show];
}


#pragma mark --显示弹框4(TNM分期)
-(void)alevrViewTNMTitle:(NSString*)title{
    
    CustomAlertFour * vc =[[CustomAlertFour alloc]initWithTitle:title canCleBtn:@"取消" achiveBtn:@"完成" ];
    __weak __typeof(vc)weakSelf = vc;
    vc.NameBlock=^(NSString*name1,NSString*name2,NSString*name3){
        _tnmStr=[NSString stringWithFormat:@"T:%@ N:%@ M:%@",name1,name2,name3];
        _tnmStrID=[NSString stringWithFormat:@"T%@N%@M%@",name1,name2,name3];
        [_tableView reloadData];
        [weakSelf dissmiss];
    };
    [vc show];

}
#pragma mark --显示弹框5(主诉)
-(void)alevrViewZhuSuTag:(int)tag{
    
    CustomAlertFive * vc =[[CustomAlertFive alloc]initWithTitle:@"主诉" canCleBtn:@"取消" achiveBtn:@"完成" ];
    __weak __typeof(vc)weakSelf = vc;
    vc.NameBlock=^(ScanCodeModel*name){
        if (tag==1) {
            _zhuSuStr=name.zhuSuName;
            _zhuSuStrID=name.zhuSuID;
        }else if (tag==2){
            _zhuSuStr2=name.zhuSuName;
            _zhuSuStrID2=name.zhuSuID;
        }else if (tag==3){
            _zhuSuStr3=name.zhuSuName;
            _zhuSuStrID3=name.zhuSuID;
        }else if (tag==4){
            _zhuSuStr4=name.zhuSuName;
            _zhuSuStrID4=name.zhuSuID;
        }
       
        [_tableView reloadData];
        [weakSelf dissmiss];
    };
    [vc show];
    
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
        nameText.tag=1;
        nameText.delegate=self;
      
        if ([_name isEqualToString:@""] ||_name==nil) {
             nameText.placeholder=@"姓名";
        }else{
             nameText.text=_name;
        }
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
        if ([_xingBie isEqualToString:@""] || _xingBie ==nil) {
             [sexBtn setTitle:@"性别" forState:0];
             [sexBtn setTitleColor:[UIColor lightGrayColor] forState:0];
        }else{
            [sexBtn setTitle:_xingBie forState:0];
            [sexBtn setTitleColor:[UIColor blackColor] forState:0];
        }
        _sexBtn=sexBtn;
        sexBtn.titleLabel.font=[UIFont systemFontOfSize:15];
        [headView sd_addSubviews:@[sexBtn]];
        [sexBtn addTarget:self action:@selector(sexbtnClink) forControlEvents:UIControlEventTouchUpInside];
       
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
        nianLingText.tag=2;
        nianLingText.delegate=self;
        if ([_age isEqualToString:@""] ||_age==nil) {
             nianLingText.placeholder=@"年龄";
        }else{
             nianLingText.text=_age;
        }
       
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
-(void)sexbtnClink{
    //1代表性别
    [_tableView endEditing:YES];
    [self ShowAlerViewNSArray:@[@"男",@"女"] Title:@"性别" intt:1];
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
            if ([_leiXing isEqualToString:@""] || _leiXing==nil) {
                 cell.textfield.placeholder=@"选择类型";
            }else{
                cell.textfield.text=[NSString stringWithFormat:@"类型:%@",_leiXing];//;
            }
           
        }else if (indexPath.row==1){
            cell.textfield.text=@"患者信息";
            cell.accessoryType=UITableViewCellAccessoryNone;
        }
        
    }else if (indexPath.section==1){
        if (indexPath.row==0) {
            if([_bingMing isEqualToString:@""] || _bingMing==nil){
                cell.textfield.placeholder=@"病名";
            }else{
                 cell.textfield.text=[NSString stringWithFormat:@"病名:%@",_bingMing];
            }
           
        }else if (indexPath.row==1){
           
            if([_bingLi isEqualToString:@""] || _bingLi==nil){
                 cell.textfield.placeholder=@"病理";
            }else{
                cell.textfield.text=[NSString stringWithFormat:@"病理:%@",_bingLi];//;
            }
            
            
        }else if (indexPath.row==2){
            
            if([_maiXiang isEqualToString:@""] || _maiXiang==nil){
                cell.textfield.placeholder=@"脉象";
            }else{
                cell.textfield.text=[NSString stringWithFormat:@"脉象:%@",_maiXiang];//_maiXiang;
            }
            
        }else if (indexPath.row==3){
            if([_sheTaiZhi isEqualToString:@""] || _sheTaiZhi==nil){
                cell.textfield.placeholder=@"舌苔";
            }else{
                cell.textfield.text=[NSString stringWithFormat:@"%@",_sheTaiZhi];//_sheTaiZhi;
            }
           
        }else if (indexPath.row==4){
            cell.accessoryType=UITableViewCellAccessoryNone;
            cell.insertBtn.hidden=NO;
            cell.insertBtn.tag=indexPath.row;
            [cell.insertBtn setImage:[UIImage imageNamed:@"sbhz_add"] forState:0];
            [cell.insertBtn addTarget:self action:@selector(insertbtnClink:) forControlEvents:UIControlEventTouchUpInside];
            if([_zhuSuStr isEqualToString:@""] || _zhuSuStr==nil){
               cell.textfield.placeholder=@"主诉";
            }else{
                cell.textfield.text=[NSString stringWithFormat:@"主诉:%@",_zhuSuStr];//_zhuSuStr;
            }
            
        }else if (indexPath.row==5){
            //主诉2
            cell.accessoryType=UITableViewCellAccessoryNone;
            cell.insertBtn.hidden=NO;
            [cell.insertBtn setImage:[UIImage imageNamed:@"sbhz_jian"] forState:0];
               cell.insertBtn.tag=indexPath.row;
            [cell.insertBtn addTarget:self action:@selector(insertbtnClink:) forControlEvents:UIControlEventTouchUpInside];
           
            if([_zhuSuStr2 isEqualToString:@""] || _zhuSuStr2==nil){
                cell.textfield.placeholder=@"主诉2";
            }else{
                cell.textfield.text=[NSString stringWithFormat:@"主诉:%@",_zhuSuStr2];
            }
            
        }else if (indexPath.row==6){
            //主诉3
            cell.accessoryType=UITableViewCellAccessoryNone;
            cell.insertBtn.hidden=NO;
            [cell.insertBtn setImage:[UIImage imageNamed:@"sbhz_jian"] forState:0];
            cell.insertBtn.tag=indexPath.row;
            [cell.insertBtn addTarget:self action:@selector(insertbtnClink:) forControlEvents:UIControlEventTouchUpInside];
            
            if([_zhuSuStr3 isEqualToString:@""] || _zhuSuStr3==nil){
                cell.textfield.placeholder=@"主诉3";
            }else{
                cell.textfield.text=[NSString stringWithFormat:@"主诉:%@",_zhuSuStr3];
            }
        }else if (indexPath.row==7){
            //主诉4
            cell.accessoryType=UITableViewCellAccessoryNone;
            cell.insertBtn.hidden=NO;
            [cell.insertBtn setImage:[UIImage imageNamed:@"sbhz_jian"] forState:0];
            cell.insertBtn.tag=indexPath.row;
            [cell.insertBtn addTarget:self action:@selector(insertbtnClink:) forControlEvents:UIControlEventTouchUpInside];
            
            if([_zhuSuStr4 isEqualToString:@""] || _zhuSuStr4==nil){
                cell.textfield.placeholder=@"主诉4";
            }else{
                cell.textfield.text=[NSString stringWithFormat:@"主诉:%@",_zhuSuStr4];
            }
        }
        
        
    }else if (indexPath.section==2){
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        if (indexPath.row==0) {
           
            if([_youWuFangLiao isEqualToString:@""] || _youWuFangLiao==nil){
                 cell.textfield.placeholder=@"有无放疗";
            }else{
                cell.textfield.text=[NSString stringWithFormat:@"有无放疗:%@",_youWuFangLiao];
            }
            
        }else if (indexPath.row==1){
            if([_youWuHuaLiao isEqualToString:@""] || _youWuHuaLiao==nil){
               cell.textfield.placeholder=@"有无化疗";
            }else{
                cell.textfield.text=[NSString stringWithFormat:@"有无化疗:%@",_youWuHuaLiao];//_youWuHuaLiao;
            }
        }else if (indexPath.row==2){
            
            if([_tnmStr isEqualToString:@""] || _tnmStr==nil){
               cell.textfield.placeholder=@"TNM分期";
            }else{
                cell.textfield.text=_tnmStr;
            }
        }else if (indexPath.row==3){
            if([_shouShu isEqualToString:@""] || _shouShu==nil){
                cell.textfield.placeholder=@"手术";
            }else{
                cell.textfield.text=[NSString stringWithFormat:@"手术:%@",_shouShu];//_shouShu;
            }
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
        cell.textview.delegate=self;
        if([_wenTiMiaoShu isEqualToString:@""] || _wenTiMiaoShu==nil){
            cell.textview.text=@"";
        }else{
            //cell.textfield.text=[NSString stringWithFormat:@"手术:%@",_shouShu];//_shouShu;
            cell.textview.text=_wenTiMiaoShu;
        }
        
    }
    
    
}
#pragma mark --插入一行
-(void)insertbtnClink:(UIButton*)btn{
    
    if (btn.tag==4) {
        if (_image2.count>7) {
            [LCProgressHUD showMessage:@"暂时最多支持4个主诉"];
            return;
        }
       [_image2 addObject:@""];
    }else{
       
        ScanCodeCell * cell1 =[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:btn.tag inSection:1]];
        cell1.textfield.text=nil;
        if (btn.tag==5) {
           _zhuSuStr2=@"";
           _zhuSuStrID2=@"";
           _zhuSuStr2=nil;
        
        }else if (btn.tag==6){
            _zhuSuStr3=@"";
            _zhuSuStrID3=@"";
        }else if (btn.tag==7){
            _zhuSuStr4=@"";
            _zhuSuStrID4=@"";
        }
        NSLog(@">>>%lu",btn.tag);
//       [_image2 removeLastObject];
        [_image2 removeObjectAtIndex:btn.tag];
        
    }
   
    [_tableView reloadData];

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==3) {
        return 120;
    }else{

        return 50;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark --清空内容
-(void)dissMissContent{
    
    [_tableView setContentOffset:CGPointMake(0, 0) animated:NO];
    
     [_image2 removeAllObjects];
     [_image2 addObject:@"sbhz_bm"];
     [_image2 addObject:@"sbhz_bl"];
     [_image2 addObject:@"sbhz_mx"];
     [_image2 addObject:@"sbhz_st"];
     [_image2 addObject:@"sbhz_zs"];
    
    
    
    ScanCodeCell * cell0 =[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    ScanCodeCell * cell1 =[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    
    ScanCodeCell * cell2 =[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    ScanCodeCell * cell3 =[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:1]];
    ScanCodeCell * cell4 =[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:1]];
    ScanCodeCell * cell5 =[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:1]];
    ScanCodeCell * cell6 =[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:1]];
    //ScanCodeCell * cell7 =[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:1]];
    
    ScanCodeCell * cell7 =[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:2]];
    ScanCodeCell * cell8 =[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:2]];
    ScanCodeCell * cell9 =[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:2]];
    ScanCodeCell * cell10 =[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:2]];
    
     cell0.textfield.text=nil;
     cell1.textfield.text=nil;
     cell2.textfield.text=nil;
     cell3.textfield.text=nil;
     cell4.textfield.text=nil;
     cell5.textfield.text=nil;
     cell6.textfield.text=nil;
     cell7.textfield.text=nil;
     cell8.textfield.text=nil;
     cell9.textfield.text=nil;
     cell10.textfield.text=nil;
    
    
    
    _name=@"";
    _age=@"";
    _leiXing=@"";
    
    _xingBie=@"";
    
    _bingMingID=nil;
    _bingMing=@"";
 
    _bingLi=@"";
    _bingLiID=nil;
    
    _sheTaiZhi=@"";
    _sheTaiID=nil;
    _sheZhiID=nil;
    
    _maiXiang=@"";
    _maiXiangID=@"";
    
    _youWuHuaLiao=@"";
    _youWuFangLiao=@"";
   
    _shouShu=@"";
    
    _tnmStr=@"";
    _tnmStrID=@"";
    
    _zhuSuStr=@"";
    _zhuSuStrID=@"";
    
    _wenTiMiaoShu=@"";
    [_tableView reloadData];
}





- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField.tag==1) {
        //姓名
        _name=textField.text;
    }else{
        _age=textField.text;
    }
}
- (void)textViewDidEndEditing:(UITextView *)textView{
    _wenTiMiaoShu=textView.text;
}
-(NSString*)ShaiXuanYouWuFnagHuStr:(NSString*)str{
    NSString * youWu;
    
    if ([str isEqualToString:@"无"]) {
        youWu=@"N";
    }else if (str==nil || [str isEqualToString:@""]){
        [LCProgressHUD showMessage:@"请重新选择有无放疗"];;
    }else{
        youWu=@"Y";
    }
    return youWu;
}

-(NSString*)ShaiXuanYouWuFnagHuQiShuStr:(NSString*)strr{
    NSString * qiShu =[self ShaiXuanYouWuFnagHuStr:strr];
    NSMutableDictionary * dicc =[NSMutableDictionary new];
    [dicc setObject:@"1" forKey:@"一期"];
    [dicc setObject:@"2" forKey:@"二期"];
    [dicc setObject:@"3" forKey:@"三期"];
    [dicc setObject:@"4" forKey:@"四期"];
    
    if ([qiShu isEqualToString:@"Y"]) {
         return [dicc objectForKey:strr];
    }else{
        return @"";
    }
   
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
