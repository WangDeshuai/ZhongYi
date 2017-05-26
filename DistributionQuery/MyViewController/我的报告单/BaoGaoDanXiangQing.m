//
//  BaoGaoDanXiangQing.m
//  DistributionQuery
//
//  Created by Macx on 17/5/11.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import "BaoGaoDanXiangQing.h"
#import "BaoGaiDanModel.h"
#import "HuiZhenKaiFangVC.h"
#import "MedicineXiangQingVC.h"
#import "XiuGaiBaoGaoDanVC.h"
@interface BaoGaoDanXiangQing ()
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)UILabel * contentlabel;
@property(nonatomic,assign)int fount;
@property(nonatomic,strong)UIScrollView * myScrollView;
@property(nonatomic,strong)NSMutableArray * classIDArray;
@end

@implementation BaoGaoDanXiangQing

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"报告单详情";
    [self CreatRightBtn];
    _fount=12;
   
    _classIDArray=[NSMutableArray new];
    _myScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64)];
    _myScrollView.userInteractionEnabled=YES;
    _myScrollView.contentSize=CGSizeMake(0, 1000);
    _myScrollView.backgroundColor=[UIColor redColor];
    [self.view addSubview:_myScrollView];
    [self CreatContent];
    
}
#pragma mark --修改按钮
-(void)CreatRightBtn{
    UIButton*  backHomeBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [backHomeBtn setTitle:@"修改" forState:0];
    [backHomeBtn setTitleColor:MAIN_COLOR forState:0];
    backHomeBtn.frame=CGRectMake(0, 0, 100, 30);
    backHomeBtn.titleLabel.font=[UIFont systemFontOfSize:15];
    backHomeBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentRight;
    [backHomeBtn addTarget:self action:@selector(rightBtnClink) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftBtn2 =[[UIBarButtonItem alloc]initWithCustomView:backHomeBtn];
    self.navigationItem.rightBarButtonItems=@[leftBtn2];
}
-(void)rightBtnClink{
    XiuGaiBaoGaoDanVC * vc =[XiuGaiBaoGaoDanVC new];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)CreatContent{
    UIView * bgView=_myScrollView;//[UIView new];
    bgView.backgroundColor=[UIColor whiteColor];
//    bgView.sd_layout
//    .leftSpaceToView(self.view,0)
//    .rightSpaceToView(self.view,0)
//    .topSpaceToView(self.view,0)
//    .heightIs(ScreenHeight+500);
    //标题
    UILabel * titlelabel =[UILabel new];
    titlelabel.text=@"张士舜三辩肿瘤治疗会诊中心报告单";
    titlelabel.textAlignment=1;
    titlelabel.font=[UIFont systemFontOfSize:20];
    [bgView sd_addSubviews:@[titlelabel]];
    titlelabel.sd_layout
    .topSpaceToView(bgView,20)
    .widthIs(ScreenWidth-100)
    .centerXEqualToView(bgView)
    .autoHeightRatio(0);
    
    //lineView1
    UIView * lineview1 =[UIView new];
    lineview1.backgroundColor=[UIColor blackColor];
    lineview1.alpha=.7;
    [bgView sd_addSubviews:@[lineview1]];
    lineview1.sd_layout
    .leftSpaceToView(bgView,20)
    .rightSpaceToView(bgView,20)
    .topSpaceToView(titlelabel,25)
    .heightIs(1);
    
    NSArray * arr=@[@"姓名",@"性别",@"年龄",@"舌苔舌质",@"手术",@"脉象",@"TNM分期",@"有无放疗",@"有无化疗",@"病名",@"病理"];
    
    NSMutableArray * arr1 =[NSMutableArray new];
    [arr1 addObjectsFromArray:arr];
    int kj=15;
    int k =(ScreenWidth-40-(kj*2))/3;
    int gj=15;
    int g=10;
    NSMutableArray * arry =[NSMutableArray new];
    for (int i =0; i<arr.count; i++) {
        UILabel * namelable =[UILabel new];
        
        _contentlabel=namelable;
        namelable.text=arr[i];
        namelable.backgroundColor=[UIColor whiteColor];
        namelable.font=[UIFont systemFontOfSize:_fount];
        namelable.alpha=.8;
        namelable.textAlignment=0;
        [bgView sd_addSubviews:@[namelable]];
        namelable.sd_layout
        .leftSpaceToView(bgView,20+(k+kj)*(i%3))
        .topSpaceToView(lineview1,10+(g+gj)*(i/3))
        .widthIs(k)
        .heightIs(g);
        [namelable setSingleLineAutoResizeWithMaxWidth:200];
        [arry addObject:namelable];
        
    }
    
    //lineView1
    UIView * lineview2 =[UIView new];
    lineview2.backgroundColor=[UIColor blackColor];
    lineview2.alpha=.7;
    [bgView sd_addSubviews:@[lineview2]];
    lineview2.sd_layout
    .leftEqualToView(lineview1)
    .rightEqualToView(lineview1)
    .topSpaceToView(_contentlabel,10)
    .heightIs(1);
    
    //主诉
    UILabel * zhuSulab =[UILabel new];
    zhuSulab.font=[UIFont systemFontOfSize:_fount];
    zhuSulab.text=@"主诉:";
    zhuSulab.alpha=.8;
    [bgView sd_addSubviews:@[zhuSulab]];
    zhuSulab.sd_layout
    .leftEqualToView(lineview2)
    .rightEqualToView(lineview2)
    .topSpaceToView(lineview2,20)
    .autoHeightRatio(0);
    //主要会诊问题
    UILabel * huizhenLab =[UILabel new];
    huizhenLab.font=[UIFont systemFontOfSize:_fount];
    huizhenLab.text=@"主要会诊问题:";
    huizhenLab.alpha=.8;
    [bgView sd_addSubviews:@[huizhenLab]];
    huizhenLab.sd_layout
    .leftEqualToView(zhuSulab)
    .rightEqualToView(zhuSulab)
    .topSpaceToView(zhuSulab,10)
    .autoHeightRatio(0);
 
    //功效
    UILabel * gongXiao =[UILabel new];
    gongXiao.font=[UIFont systemFontOfSize:_fount];
    gongXiao.text=@"功效:";
    gongXiao.alpha=.8;
    [bgView sd_addSubviews:@[gongXiao]];
    gongXiao.sd_layout
    .leftEqualToView(zhuSulab)
    .rightEqualToView(zhuSulab)
    .topSpaceToView(huizhenLab,10)
    .autoHeightRatio(0);


    
    //会诊开方
    UILabel * huiZhenKai =[UILabel new];
    huiZhenKai.font=[UIFont systemFontOfSize:_fount];
    huiZhenKai.text=@"会诊开方:";
    huiZhenKai.alpha=.8;
    [bgView sd_addSubviews:@[huiZhenKai]];
    huiZhenKai.sd_layout
    .leftEqualToView(zhuSulab)
    .rightEqualToView(zhuSulab)
    .topSpaceToView(gongXiao,10)
    .autoHeightRatio(0);
  
   
  
    
    
    
    
    //医师签字
    UILabel * qianZi =[UILabel new];
    qianZi.font=[UIFont systemFontOfSize:_fount];
    qianZi.text=@"医师签字:";
    qianZi.alpha=.8;
    [bgView sd_addSubviews:@[qianZi]];
    qianZi.sd_layout
    .rightSpaceToView(bgView,100)
    .topSpaceToView(huiZhenKai,50)
    .heightIs(15);
    [qianZi setSingleLineAutoResizeWithMaxWidth:120];
    
    //lineView3
    UIView * lineview3 =[UIView new];
    lineview3.backgroundColor=[UIColor blackColor];
    lineview3.alpha=.7;
    [bgView sd_addSubviews:@[lineview3]];
    lineview3.sd_layout
    .leftEqualToView(lineview1)
    .rightEqualToView(lineview1)
    .topSpaceToView(qianZi,5)
    .heightIs(1);
    
    //底部label
    UILabel * dibu =[UILabel new];
    dibu.font=[UIFont systemFontOfSize:_fount];
    dibu.text=@"此会诊报告仅供主治医师参考，具体开方以医师签字为准";
    dibu.alpha=.8;
    dibu.textAlignment=1;
    [bgView sd_addSubviews:@[dibu]];
    dibu.sd_layout
    .leftSpaceToView(bgView,20)
    .rightSpaceToView(bgView,20)
    .topSpaceToView(lineview3,5)
    .heightIs(15);
    
    NSMutableArray * array2=[NSMutableArray new];
    [LCProgressHUD showMessage:@"请稍后..."];
    [Engine baoGaiDanXiangQingMessageID:_messageID success:^(NSDictionary *dic) {
        NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
        if ([code isEqualToString:@"200"]) {
            [LCProgressHUD hide];
            NSDictionary * dicc =[dic objectForKey:@"data"];
            //@"张士舜三辩肿瘤治疗会诊中心报告单"
            titlelabel.text=[ToolClass isString:[NSString stringWithFormat:@"张士舜三辩%@治疗会诊中心报告单",[dicc objectForKey:@"type"]]];
            
            BaoGaiDanModel * md =[[BaoGaiDanModel alloc]initWithBaoGaoDanXiangQingDic:dicc];
            [array2 addObject:md.xqname];
            [array2 addObject:md.xqsex];
            [array2 addObject:md.xqage];
            [array2 addObject:md.xqsheTai];
            [array2 addObject:md.xqshoushu];
            [array2 addObject:md.xqmaiXiang];
            [array2 addObject:md.xqTNM];
            [array2 addObject:md.xqyouFang];
            [array2 addObject:md.xqyouHua];
            [array2 addObject:md.xqbingMing];
            [array2 addObject:md.xqbingLi];
            
            for (int i=0; i<array2.count; i++) {
                NSString * str1 =arr1[i];
                NSString * str2 =array2[i];
                NSString * string =[NSString stringWithFormat:@"%@  %@",str1,str2];
                UILabel * lab =arry[i];
                lab.text=string;
                
                
            }
            
            NSArray * listArr =[dicc objectForKey:@"list"];
            int k =150;
            int g =20;
            int kj=10;
            int gj=5;
            [_classIDArray removeAllObjects];
            for (int i =0; i<listArr.count; i++) {
                NSDictionary * yaoDic =listArr[i];
                
                
                [_classIDArray addObject:[ToolClass isString:[NSString stringWithFormat:@"%@",[yaoDic objectForKey:@"id"]]]];
                UIButton * btn =[UIButton buttonWithType:UIButtonTypeCustom];
                [btn addTarget:self action:@selector(btnClink:) forControlEvents:UIControlEventTouchUpInside];
                btn.tag=i;
                btn.backgroundColor=[UIColor whiteColor];
                [bgView sd_addSubviews:@[btn]];
                btn.sd_layout
                .leftSpaceToView(bgView,20+(k+kj)*(i%2))
                .widthIs(k)
                .topSpaceToView(huiZhenKai,10+(g+gj)*(i/2))
                .heightIs(g);
                //[btn setSingleLineAutoResizeWithMaxWidth:200];
                qianZi.sd_layout
                .topSpaceToView(btn,50);
                UILabel * yaoName =[UILabel new];
                yaoName.text=[yaoDic objectForKey:@"drug_name"];
                yaoName.font=[UIFont systemFontOfSize:13];
                yaoName.textColor=JXColor(0, 132, 255, 1);
//                yaoName.backgroundColor=[UIColor yellowColor];
                yaoName.textAlignment=0;
                [btn sd_addSubviews:@[yaoName]];
                yaoName.sd_layout
                .leftSpaceToView(btn,0)
                .topSpaceToView(btn,0)
                .bottomSpaceToView(btn,0)
                .widthIs(50);
                [yaoName setSingleLineAutoResizeWithMaxWidth:100];
            
                UILabel * zhongLab =[UILabel new];
                zhongLab.font=[UIFont systemFontOfSize:13];
                zhongLab.text=[yaoDic objectForKey:@"value"];
                zhongLab.textAlignment=0;
//                zhongLab.backgroundColor=[UIColor magentaColor];
                [btn sd_addSubviews:@[zhongLab]];
                zhongLab.sd_layout
                .leftSpaceToView(yaoName,-5)
                .topSpaceToView(btn,0)
                
                .bottomSpaceToView(btn,0);
                [zhongLab setSingleLineAutoResizeWithMaxWidth:120];
//
                [btn setupAutoWidthWithRightView:zhongLab rightMargin:5];
            }
            
            
            
            
            
            //主诉
            zhuSulab.text=[NSString stringWithFormat:@"主诉：%@",md.xqzhusu];
            //主要会诊内容
            huizhenLab.text=[NSString stringWithFormat:@"主要会诊内容：%@",md.xqzhuyaowenti];
           
            //会诊开方
             huiZhenKai.attributedText=[ToolClass HTML:[NSString stringWithFormat:@"会诊开方：%@",md.xqhuikaifang]];
           
            //功效
            gongXiao.text=[NSString stringWithFormat:@"功效：%@",md.xqgongxiao];
        }else{
            [LCProgressHUD showMessage:[dic objectForKey:@"msg"]];
        }
    } error:^(NSError *error) {
        
    }];
    
    dibu.didFinishAutoLayoutBlock=^(CGRect rect){
        _myScrollView.contentSize=CGSizeMake(ScreenWidth, rect.size.height+rect.origin.y+20);
    };
    
    
  
}
-(void)btnClink:(UIButton*)btn{
    
    MedicineXiangQingVC * vc =[MedicineXiangQingVC new];
    vc.yaoID=_classIDArray[btn.tag];
    [self.navigationController pushViewController:vc animated:YES];
    
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
