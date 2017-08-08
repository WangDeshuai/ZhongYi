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
#import "ScanCodeModel.h"
#import "APAuthV2Info.h"
#import "RSADataSigner.h"
#import <AlipaySDK/AlipaySDK.h>
#import "WeiXinModel.h"
#import "WXApi.h"
#import "WXApiObject.h"
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
@property(nonatomic,strong)NSMutableArray * zhuSuIDArr;
@property(nonatomic,copy)NSString * zhuSuStr;//主诉
@property(nonatomic,copy)NSString * zhuSuStrID;//主诉ID
@property(nonatomic,copy)NSString * wenTiMiaoShu;//问题描述
/*
 
 主诉这，可以无限增加。把需要上传的主诉ID存到zhuSuIDArr中了。
 主诉的名字存到_image2中，_image2本来是存储最左边图标的就存了1个
 现在从第二个开始，就存成主诉的名字了
 
 */

@end

@implementation ScanCodeVC


-(void)viewWillAppear:(BOOL)animated
{
    if ([ToolClass isLogin]==NO) {
        [_tableView removeFromSuperview];
        
        TanKuangView * view =[[TanKuangView alloc]initWithTitle:@"温馨提示" contentName:@"您还没有登录，请先登录在查看" achiveBtn:@"确定"];
        view.buttonClinkBlock=^(UIButton*btn){
            
        };
        [view show];
    }else{
        [Engine1 chaXunVipShengJiLoginPhonesuccess:^(NSDictionary *dic) {
            NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
            if ([code isEqualToString:@"200"]) {
                NSDictionary * dataDic =[dic objectForKey:@"data"];
                NSString * dengJi =[NSString stringWithFormat:@"%@",[dataDic objectForKey:@"level"]];
                int dengJI =[dengJi intValue]-1;
            NSString*   vip=[NSString stringWithFormat:@"%d",dengJI];
                [NSUSE_DEFO setObject:vip forKey:@"vip"];
                [NSUSE_DEFO synchronize];
                if ([vip intValue]>=3) {
                        [self CreatTabelView];
                     [self addFooterButton];
                }else{
                    [_tableView removeFromSuperview];
                    NSString * content =[NSString stringWithFormat:@"此权限仅对VIP3以上开放\n您当前是VIP%@",vip];
                    TanKuangView * view =[[TanKuangView alloc]initWithTitle:@"温馨提示" contentName:content achiveBtn:@"确定"];
                    view.buttonClinkBlock=^(UIButton*btn){
                                    
                    };
                    [view show];
                }
            }
        } error:^(NSError *error) {
            
        }];
        
//        NSString*vip=[NSUSE_DEFO objectForKey:@"vip"];
//        if ([vip intValue]>=3) {
//            [self CreatTabelView];
//        }else{
//            [_tableView removeFromSuperview];
//            NSString * content =[NSString stringWithFormat:@"此权限仅对VIP3以上开放\n您当前是VIP%@",vip];
//            TanKuangView * view =[[TanKuangView alloc]initWithTitle:@"温馨提示" contentName:content achiveBtn:@"确定"];
//            view.buttonClinkBlock=^(UIButton*btn){
//                
//            };
//            [view show];
//        }

        
        
    }
    
    
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"三辨会诊";
    if (_tagg==1) {
        self.backHomeBtn.hidden=NO;
    }else{
        self.backHomeBtn.hidden=YES;
    }
    [self imageData];
//    [self CreatTabelView];
//    [self addFooterButton];
    NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(weiXin) name:@"WX_PaySuccess" object:nil];
}
#pragma mark --微信支付结果
-(void)weiXin{
    [Engine1 saveBaoGaoDanID:@"" Type:[ToolClass quChuLaiStr:_leiXing] XingMing:_name Sex:[ToolClass quChuLaiStr:_xingBie] Age:_age BingMingID:_bingMingID ZhuSuID:[_zhuSuIDArr componentsJoinedByString:@","] BingLiID:_bingLiID MaiXiangID:_maiXiangID SheZhiID:_sheZhiID SheTaiID:_sheTaiID YouWuFangYN:[self ShaiXuanYouWuFnagHuStr:_youWuFangLiao] FangZhouQi:_youWuFangLiao HuaYN:[self ShaiXuanYouWuFnagHuStr:_youWuHuaLiao] HuaZhouQi:_youWuHuaLiao ShouShuID:[ToolClass quChuLaiStr:_shouShu] TNMfen:_tnmStrID Pro:_wenTiMiaoShu success:^(NSDictionary *dic) {
        
        NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
        [LCProgressHUD showMessage:[dic objectForKey:@"msg"]];
        if ([code isEqualToString:@"200"]) {
            //清空信息
            [self dissMissContent];
        }else{
        }
        
        
    } error:^(NSError *error) {
        
    }];


}


-(void)imageData{
    _zhuSuIDArr=[NSMutableArray new];
    NSArray * imageArr1=@[@"sbhz_lx",@"sbhz_admin"];//@"sbhz_bl"
    NSArray * imageArr2 =@[@"sbhz_bm",@"sbhz_fq",@"sbhz_mx",@"sbhz_st"];
    _image2=[[NSMutableArray alloc]initWithObjects:@"sbhz_zs", nil];
    NSArray * imageArr3=@[@"sbhz_fl",@"sbhz_fl",@"sbhz_fl"];
    NSArray * imageArr4=@[@"sbhz_question"];
     _imageArray=@[imageArr1,imageArr2,_image2,imageArr3,imageArr4];
}


#pragma mark --创建发布按钮
-(void)addFooterButton
{
    UIView * footView =[UIView new];
    footView.backgroundColor=BG_COLOR;
    footView.frame=CGRectMake(0, 10, ScreenWidth, 100);
    
    // 1.初始化Button
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    //2.设置文字和文字颜色
    [button setTitle:@"提交" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //3.设置圆角幅度
    button.layer.cornerRadius = 10.0;
    //
    [button addTarget:self action:@selector(publicBtnClink) forControlEvents:UIControlEventTouchUpInside];
    //4.设置frame
    button.frame =CGRectMake(30, 30, ScreenWidth-60, 40);;
    //5.设置背景色
    button.backgroundColor = MAIN_COLOR;
    
    [footView addSubview:button];
    self.tableView.tableFooterView = footView;
}
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
  
    NSLog(@">>>主诉%@",[_zhuSuIDArr componentsJoinedByString:@","] );
    
    
    
    
    //有无放疗
    NSLog(@">>>%@",_youWuFangLiao);
    NSLog(@"有无放疗>>>%@>>>期数=%@",[self ShaiXuanYouWuFnagHuStr:_youWuFangLiao],_youWuFangLiao);//[self ShaiXuanYouWuFnagHuQiShuStr:_youWuFangLiao]
    //有无化疗
    NSLog(@">>>%@",_youWuHuaLiao);
    NSLog(@"有无化疗>>>%@>>>期数=%@",[self ShaiXuanYouWuFnagHuStr:_youWuHuaLiao],_youWuHuaLiao);//[self ShaiXuanYouWuFnagHuQiShuStr:_youWuHuaLiao]
    //TNM分期
    NSLog(@"TNM分期>>>%@",_tnmStrID);
    //手术
     NSLog(@"手术>>>%@>>>id=%@",_shouShu,[ToolClass quChuLaiStr:_shouShu]);
    //主要问题描述
    NSLog(@"问题描述>>>%@",_wenTiMiaoShu);
    NSString * str =[NSUSE_DEFO objectForKey:@"token"];
    if ([str isEqualToString:@"15032735032"]) {
        [Engine1 saveBaoGaoDanID:@"" Type:[ToolClass quChuLaiStr:_leiXing] XingMing:_name Sex:[ToolClass quChuLaiStr:_xingBie] Age:_age BingMingID:_bingMingID ZhuSuID:[_zhuSuIDArr componentsJoinedByString:@","] BingLiID:_bingLiID MaiXiangID:_maiXiangID SheZhiID:_sheZhiID SheTaiID:_sheTaiID YouWuFangYN:[self ShaiXuanYouWuFnagHuStr:_youWuFangLiao] FangZhouQi:_youWuFangLiao HuaYN:[self ShaiXuanYouWuFnagHuStr:_youWuHuaLiao] HuaZhouQi:_youWuHuaLiao ShouShuID:[ToolClass quChuLaiStr:_shouShu] TNMfen:_tnmStrID Pro:_wenTiMiaoShu success:^(NSDictionary *dic) {
            
            NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
            [LCProgressHUD showMessage:[dic objectForKey:@"msg"]];
            if ([code isEqualToString:@"200"]) {
                //清空信息
                [self dissMissContent];
            }else{
            }
            
            
        } error:^(NSError *error) {
            
        }];
        
        return;
    }
   
    NSString * vipDJ =[NSUSE_DEFO objectForKey:@"vip"];
    int vipdj =[vipDJ intValue];
    if (vipdj>=4) {
        [Engine1 saveBaoGaoDanID:@"" Type:[ToolClass quChuLaiStr:_leiXing] XingMing:_name Sex:[ToolClass quChuLaiStr:_xingBie] Age:_age BingMingID:_bingMingID ZhuSuID:[_zhuSuIDArr componentsJoinedByString:@","] BingLiID:_bingLiID MaiXiangID:_maiXiangID SheZhiID:_sheZhiID SheTaiID:_sheTaiID YouWuFangYN:[self ShaiXuanYouWuFnagHuStr:_youWuFangLiao] FangZhouQi:_youWuFangLiao HuaYN:[self ShaiXuanYouWuFnagHuStr:_youWuHuaLiao] HuaZhouQi:_youWuHuaLiao ShouShuID:[ToolClass quChuLaiStr:_shouShu] TNMfen:_tnmStrID Pro:_wenTiMiaoShu success:^(NSDictionary *dic) {
            
            NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
            [LCProgressHUD showMessage:[dic objectForKey:@"msg"]];
            if ([code isEqualToString:@"200"]) {
                //清空信息
                [self dissMissContent];
            }else{
            }
            
            
        } error:^(NSError *error) {
            
        }];
        return;
    }
    
    
    
    
    [Engine1 sanBianHuiZhenPaysuccess:^(NSDictionary *dic) {
        NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
        if ([code isEqualToString:@"200"]) {
            NSDictionary * dataDic =[dic objectForKey:@"data"];
            NSString * isPay =[ToolClass isString:[NSString stringWithFormat:@"%@",[dataDic objectForKey:@"isPay"]]];
            NSString * ciShu =[ToolClass isString:[NSString stringWithFormat:@"%@",[dataDic objectForKey:@"freeExperienceCount"]]];
            if ([isPay isEqualToString:@"N"]) {
                //不支付
                NSString * str =[NSString stringWithFormat:@"您当前可以免费生成3次报告单，超过3次后将会进行收费生成\n当前是第%@次",ciShu];
                TanKuangView * vc =[[TanKuangView alloc]initWithTitle:@"温馨提示" contentName:str achiveBtn:@"确定"];
                vc.buttonClinkBlock=^(UIButton*btn){
                    [LCProgressHUD showLoading:@"请稍后..."];
                    [Engine1 saveBaoGaoDanID:@"" Type:[ToolClass quChuLaiStr:_leiXing] XingMing:_name Sex:[ToolClass quChuLaiStr:_xingBie] Age:_age BingMingID:_bingMingID ZhuSuID:[_zhuSuIDArr componentsJoinedByString:@","] BingLiID:_bingLiID MaiXiangID:_maiXiangID SheZhiID:_sheZhiID SheTaiID:_sheTaiID YouWuFangYN:[self ShaiXuanYouWuFnagHuStr:_youWuFangLiao] FangZhouQi:_youWuFangLiao HuaYN:[self ShaiXuanYouWuFnagHuStr:_youWuHuaLiao] HuaZhouQi:_youWuHuaLiao ShouShuID:[ToolClass quChuLaiStr:_shouShu] TNMfen:_tnmStrID Pro:_wenTiMiaoShu success:^(NSDictionary *dic) {
                        
                        NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
                        [LCProgressHUD showMessage:[dic objectForKey:@"msg"]];
                        if ([code isEqualToString:@"200"]) {
                            //清空信息
                            [self dissMissContent];
                        }else{
                        }
                        
                        
                    } error:^(NSError *error) {
                        
                    }];

                };
                [vc show];
                
                
            }else{
                //支付
                UIAlertController * actionview=[UIAlertController alertControllerWithTitle:@"此次生成报告单需要支付300元" message:@"是否确认支付" preferredStyle:UIAlertControllerStyleActionSheet];
                UIAlertAction * action =[UIAlertAction actionWithTitle:@"支付宝支付" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [LCProgressHUD showLoading:@"请稍后..."];//
                    [Engine1 huoQuDingDanHaoName:@"世舜中医生成报告单" Price:[NSString stringWithFormat:@"%.2d",300] Type:@"report"  success:^(NSDictionary *dic) {
                        NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
                        if ([code isEqualToString:@"200"]) {
                            NSDictionary * dataDic =[dic objectForKey:@"data"];
                            NSString * dingDan =[ToolClass isString:[NSString stringWithFormat:@"%@",[dataDic objectForKey:@"order_no"]]];//_priceNum
                            [self doAlipayPayDingDanHao:dingDan ];
                            [LCProgressHUD hide];
                        }else{
                            [LCProgressHUD showMessage:[dic objectForKey:@"msg"]];
                        }
                        
                    } error:^(NSError *error) {
                        
                    }];

                }];
                UIAlertAction * action2 =[UIAlertAction actionWithTitle:@"微信支付" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                   
                    [Engine1 weiXinYuZhiFuPrice:[NSString stringWithFormat:@"%d",300*100] Type:@"report" MiaoShu:@"世舜中医生成报告单" success:^(NSDictionary *dic) {
                        NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
                        if ([code isEqualToString:@"200"]) {
                            NSDictionary * dataDic =[dic objectForKey:@"data"];
                            WeiXinModel * md =[[WeiXinModel alloc]initWithWeiXinModelDic:dataDic];
                            PayReq *request = [[PayReq alloc] init];
                            request.partnerId = md.weiXinPartnerid;
                            request.prepayId=  md.weiXinPrepayid;
                            request.package = md.weiPackage;
                            request.nonceStr=  md.weiNoncestr;
                            request.timeStamp= md.weiXinTimestamp.intValue;
                            request.sign= md.weiXinSign;
                            [WXApi sendReq:request];
                        }else{
                            [LCProgressHUD showMessage:[dic objectForKey:@"msg"]];
                        }
                    } error:^(NSError *error) {
                        
                    }];

                }];
                
                UIAlertAction * action3 =[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    
                }];
                [actionview addAction:action];
                [actionview addAction:action2];
                [actionview addAction:action3];
                [self presentViewController:actionview animated:YES completion:nil];
                
                
            }
            
            
        }else{
            [LCProgressHUD showMessage:[dic objectForKey:@"msg"]];
        }
    } error:^(NSError *error) {
        
    }];
    
    
    
    
    
}

#pragma mark --支付宝支付
- (void)doAlipayPayDingDanHao:(NSString*)dingDan
{
    //17733871852
    NSString *appScheme = @"alisdkdemo";
    [[AlipaySDK defaultService] payOrder:dingDan fromScheme:appScheme callback:^(NSDictionary *resultDic) {
        ;
        NSLog(@"支付结果 = %@>>>%@",resultDic,[resultDic objectForKey:@"memo"]);
        NSString * str =[NSString stringWithFormat:@"%@",[resultDic objectForKey:@"resultStatus"]];
        if ([str isEqualToString:@"9000"]) {
            //支付成功(调用报告单)
            [LCProgressHUD showMessage:@"请稍后..."];
            [Engine1 saveBaoGaoDanID:@"" Type:[ToolClass quChuLaiStr:_leiXing] XingMing:_name Sex:[ToolClass quChuLaiStr:_xingBie] Age:_age BingMingID:_bingMingID ZhuSuID:[_zhuSuIDArr componentsJoinedByString:@","] BingLiID:_bingLiID MaiXiangID:_maiXiangID SheZhiID:_sheZhiID SheTaiID:_sheTaiID YouWuFangYN:[self ShaiXuanYouWuFnagHuStr:_youWuFangLiao] FangZhouQi:_youWuFangLiao HuaYN:[self ShaiXuanYouWuFnagHuStr:_youWuHuaLiao] HuaZhouQi:_youWuHuaLiao ShouShuID:[ToolClass quChuLaiStr:_shouShu] TNMfen:_tnmStrID Pro:_wenTiMiaoShu success:^(NSDictionary *dic) {
                
                NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
                [LCProgressHUD showMessage:[dic objectForKey:@"msg"]];
                if ([code isEqualToString:@"200"]) {
                    //清空信息
                    [self dissMissContent];
                }else{
                }
                
                
            } error:^(NSError *error) {
                
            }];
            
        }else{
            [LCProgressHUD showFailure:@"支付失败"];
        }
        
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
//            if (self.isSelect == false) {
//                self.isSelect = true;
//                [self performSelector:@selector(repeatDelay) withObject:nil afterDelay:1];
//                // 在下面实现点击cell需要实现的逻辑就可以了
//                [self huoQuBingMingMessageDataID:@""];
//            }
        }
        //else if (indexPath.row==1){
//            //病理
//            if (self.isSelect == false) {
//                self.isSelect = true;
//                [self performSelector:@selector(repeatDelay) withObject:nil afterDelay:1];
//                // 在下面实现点击cell需要实现的逻辑就可以了
//                 [self BingLiData];
//            }

            
          
        //}
    else if (indexPath.row==1){
            //TNM分期
            [self alevrViewTNMTitle:@"TNM分期"];
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
        }

    }else if (indexPath.section==2){
        [self alevrViewZhuSuTag:indexPath];


    }
    else if(indexPath.section==3){
        if (indexPath.row==0) {
            //有无放疗
            [self alevrViewThreeTitle:@"有无放疗" Tag:0];
        }else if (indexPath.row==1){
            //有无化疗
            [self alevrViewThreeTitle:@"有无化疗" Tag:1];
        }else if (indexPath.row==2){
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
    [Engine1 jiaZaiBingLiMessagesuccess:^(NSDictionary *dic) {
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
    [Engine1 jiaZaiAllMaiXiangMessagesuccess:^(NSDictionary *dic) {
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
//tag==1 (病名接口)
-(void)huoQuBingMingMessageDataID:(NSString*)idd{
    [Engine1 jiaZaiBingMingAllMessageID:idd success:^(NSDictionary *dic) {
        NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
        if ([code isEqualToString:@"200"]) {
            NSArray * dataArr =[dic objectForKey:@"data"];
             NSMutableArray * dataTitle=[NSMutableArray new];
            for (NSDictionary * dicc in dataArr) {
                ScanCodeModel * model =[[ScanCodeModel alloc]initWithBingMingDic:dicc];
                [dataTitle addObject:model];
            }
             [self ShowAlerViewNSArray:dataTitle Title:@"诊断"  intt:5];
        }else{
            [LCProgressHUD showMessage:[dic objectForKey:@"msg"]];
        }
    } error:^(NSError *error) {
        [LCProgressHUD showMessage:@"失败"];
    } ];
}

#pragma mark --显示弹框1
-(void)ShowAlerViewNSArray:(NSArray*)contentArr Title:(NSString*)title intt:(int)tag{
    /*
     tagg==0  第一行其它疑难杂症
     tagg==1  性别
     tagg==2  病理
     tagg==3  脉象
     tagg==4  手术
     tagg==5 诊断
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
        }else if (tag==5){
            _bingMing=mdd.bingMingName;
            _bingMingID=mdd.bingMingID;
            NSLog(@">>a>>%@>>s>%@",_bingMing,_bingMingID);
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
    NSString * str =@"";
    if (tag==1) {
        str=@"诊断及病理";
    }else if (tag==2){
        str=@"舌苔舌质";
    }
    CustomAlertTwo * alertView =[[CustomAlertTwo alloc]initWithTitle:str canCleBtn:@"取消" achiveBtn:@"完成" Tag:tag];
     __weak __typeof(alertView)weakSelf = alertView;
    alertView.clickBlock=^(UIButton*btn,ScanCodeModel*md,ScanCodeModel*md2){
        if(tag==1){
            _bingMing=md.bingMingName;
            _bingMingID=md.bingMingID;
        }else if (tag==2){
            //md2是舌质  md是舌苔
            NSLog(@">>>%@>>>>%@",md2.sheZhiName,md.sheTaiName);
            _sheTaiZhi=[NSString stringWithFormat:@"舌质:%@ 舌苔:%@",md2.sheZhiName,md.sheTaiName];
            _sheTai=md.sheTaiName;
            _sheTaiID=md.sheTaiID;
           
            _sheZhi=md2.sheZhiName;
            _sheZhiID=md2.sheZhiID;
            
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
-(void)alevrViewZhuSuTag:(NSIndexPath*)tag{
    NSLog(@">>>>病名ID=%@",_bingMingID);
    if (_bingMingID==nil) {
        [LCProgressHUD showMessage:@"请先选择诊断及病理"];
        return;
    }
    
    CustomAlertFive * vc =[[CustomAlertFive alloc]initWithTitle:@"主诉" canCleBtn:@"取消" achiveBtn:@"完成" BingMingID:_bingMingID];
    __weak __typeof(vc)weakSelf = vc;
    vc.NameBlock=^(ScanCodeModel*name){

        for (NSString * idd in _zhuSuIDArr) {
            if ([idd isEqualToString:name.zhuSuID]) {
                [LCProgressHUD showMessage:@"不能重复选择"];
                return ;
            }
        }
        
        if (tag.row==0) {
            _zhuSuStr=name.zhuSuName;
            _zhuSuStrID=name.zhuSuID;
            [_zhuSuIDArr addObject:name.zhuSuID];
        }else{
            [_image2 replaceObjectAtIndex:tag.row withObject:name.zhuSuName];
            [_zhuSuIDArr addObject:name.zhuSuID];
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
        nianLingText.keyboardType=UIKeyboardTypeNamePhonePad;
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
                cell.textfield.text=nil;
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
            //诊断
            if([_bingMing isEqualToString:@""] || _bingMing==nil){
                 cell.textfield.text=nil;
                cell.textfield.placeholder=@"诊断及病理";
            }else{
                 cell.textfield.text=[NSString stringWithFormat:@"诊断:%@",_bingMing];
            }
           
        }
        //else if (indexPath.row==1){
//           //病理
//            if([_bingLi isEqualToString:@""] || _bingLi==nil){
//                 cell.textfield.text=nil;
//                 cell.textfield.placeholder=@"病理";
//            }else{
//                cell.textfield.text=[NSString stringWithFormat:@"病理:%@",_bingLi];//;
//            }
            
            
        //}
    else if (indexPath.row==1){
            //TNM分期
            if([_tnmStr isEqualToString:@""] || _tnmStr==nil){
                 cell.textfield.text=nil;
                cell.textfield.placeholder=@"TNM分期";
            }else{
                cell.textfield.text=_tnmStr;
            }
        }else if (indexPath.row==2){
            //脉象
            if([_maiXiang isEqualToString:@""] || _maiXiang==nil){
                 cell.textfield.text=nil;
                cell.textfield.placeholder=@"脉象";
                
            }else{
                cell.textfield.text=[NSString stringWithFormat:@"脉象:%@",_maiXiang];
            }
            
        }else if (indexPath.row==3){
            //舌苔
            if([_sheTaiZhi isEqualToString:@""] || _sheTaiZhi==nil){
                 cell.textfield.text=nil;
                cell.textfield.placeholder=@"舌苔";
            }else{
                cell.textfield.text=[NSString stringWithFormat:@"%@",_sheTaiZhi];
            }
        }

        
    }else if (indexPath.section==2){
        cell.insertBtn.hidden=NO;
        cell.insertBtn.tag=indexPath.row;
        cell.accessoryType=UITableViewCellAccessoryNone;
         [cell.insertBtn addTarget:self action:@selector(insertbtnClink:) forControlEvents:UIControlEventTouchUpInside];
        if (indexPath.row==0) {
            [cell.insertBtn setImage:[UIImage imageNamed:@"sbhz_add"] forState:0];
           
            if([_zhuSuStr isEqualToString:@""] || _zhuSuStr==nil){
                 cell.textfield.text=nil;
                cell.textfield.placeholder=@"主诉1";
            }else{
                cell.textfield.text=[NSString stringWithFormat:@"主诉1:%@",_zhuSuStr];//_zhuSuStr;
            }
        }else{
            if (_image2.count>1) {
                [cell.insertBtn setImage:[UIImage imageNamed:@"sbhz_jian"] forState:0];
                cell.textfield.text=[NSString stringWithFormat:@"主诉%lu:%@",indexPath.row+1,_image2[indexPath.row]];
            }
            
        }
        
    }
    else if (indexPath.section==3){
        //有无放疗
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        if (indexPath.row==0) {
           
            if([_youWuFangLiao isEqualToString:@""] || _youWuFangLiao==nil){
                 cell.textfield.text=nil;
                 cell.textfield.placeholder=@"有无放疗";
            }else{
                cell.textfield.text=[NSString stringWithFormat:@"有无放疗:%@",_youWuFangLiao];
            }
            
        }else if (indexPath.row==1){
            //有无化疗
            if([_youWuHuaLiao isEqualToString:@""] || _youWuHuaLiao==nil){
                 cell.textfield.text=nil;
               cell.textfield.placeholder=@"有无化疗";
            }else{
                cell.textfield.text=[NSString stringWithFormat:@"有无化疗:%@",_youWuHuaLiao];//_youWuHuaLiao;
            }
        }else if (indexPath.row==2){
            //手术
            if([_shouShu isEqualToString:@""] || _shouShu==nil){
                 cell.textfield.text=nil;
                cell.textfield.placeholder=@"手术";
            }else{
                cell.textfield.text=[NSString stringWithFormat:@"手术:%@",_shouShu];//_shouShu;
            }
        }
    }else if (indexPath.section==4){
        //主要问题描述
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
    
    
    if (btn.tag==0) {
        //插入一行
        NSMutableArray *indexPaths = [[NSMutableArray alloc] init];
        NSInteger row = _image2.count;
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:2];
        [indexPaths addObject: indexPath];
        [_image2 addObject:@""];
        [self.tableView beginUpdates];
        [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
        [self.tableView endUpdates];
        
        
        [_tableView scrollToRowAtIndexPath:indexPath
                                atScrollPosition:UITableViewScrollPositionNone animated:YES];
        
        
    }else{
        _tableView.editing=!_tableView.editing;
    }

}

#pragma mark --删除
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    if (indexPath.section==2) {
        if (indexPath.row==0) {
            return NO;
        }else{
           return YES;
        }
    }else{
      return NO;
    }
    
    
}
//定义编辑样式
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}
//修改编辑按钮文字
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}
//进入编辑模式，按下出现的编辑按钮后,进行删除操作
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_image2 removeObjectAtIndex:indexPath.row];
        if (_zhuSuIDArr.count!=0) {
            [_zhuSuIDArr removeObjectAtIndex:indexPath.row];
        }
       
        // Delete the row from the data source.
        [_tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

#pragma mark --删除结束
#pragma mark --行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==4) {
        return 120;
    }else{
        if ([ToolClass isiPad]) {
            return 60;
        }else{
          return 50;  
        }
        
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
  
     [_image2 addObject:@"sbhz_zs"];
     [_zhuSuIDArr removeAllObjects];
    
    
    
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

#pragma mark --TextViewDeleagte
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    NSLog(@"开始滑动");
     _tableView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight-64);
}

-(void)textViewDidBeginEditing:(UITextView *)textView{
//    NSLog(@"开始");
    _tableView.frame = CGRectMake(0, -180, ScreenWidth, ScreenHeight-64);
}
- (void)textViewDidEndEditing:(UITextView *)textView{
    _wenTiMiaoShu=textView.text;
//    NSLog(@"结束");
    _tableView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight-64);

}
-(NSString*)ShaiXuanYouWuFnagHuStr:(NSString*)str{
    NSString * youWu;
    
    if ([str isEqualToString:@"无"]) {
        youWu=@"N";
    }else if (str==nil || [str isEqualToString:@""]){
//        [LCProgressHUD showMessage:@"请重新选择有无放疗"];;
    }else{
        youWu=@"Y";
    }
    return youWu;
}

-(NSString*)ShaiXuanYouWuFnagHuQiShuStr:(NSString*)strr{
    NSString * qiShu =[self ShaiXuanYouWuFnagHuStr:strr];
    NSMutableDictionary * dicc =[NSMutableDictionary new];
    [dicc setObject:@"1" forKey:@"一个周期"];
    [dicc setObject:@"2" forKey:@"二个周期"];
    [dicc setObject:@"3" forKey:@"三个周期"];
    [dicc setObject:@"4" forKey:@"四个周期"];
    
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
