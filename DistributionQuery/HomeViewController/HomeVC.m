//
//  HomeVC.m
//  DistributionQuery
//
//  Created by Macx on 16/10/8.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "HomeVC.h"
#import "HomeTableViewCell.h"
#import "MedicineVC.h"//药
#import "LecturesVC.h"//讲座
#import "YaoFangVC.h"//药方
#import "ZhongYiYiAnVC.h"//中医医案
#import "BingMingVC.h"//病名
#import "ZhongYiModel.h"
#import "YiAnXiangQingVC.h"
#import "SearchViewController.h"//搜索
#import "TanKuangView.h"
#import "UITextField+ExtentRange.h"
#import "YuYinView.h"
#import "LuoBoTiaoZhuanVC.h"
@interface HomeVC ()<UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate,UIScrollViewDelegate,UITextFieldDelegate>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,assign)int AAA;
@property (nonatomic,strong) MJRefreshComponent *myRefreshView;
@property(nonatomic,strong)NSMutableArray * dataArray;
@property(nonatomic,strong)UITextField * textView;
@property(nonatomic,strong)YuYinView * yuYin;
@end
//0279426206
@implementation HomeVC
-(void)viewWillAppear:(BOOL)animated
{
     self.navigationController.navigationBarHidden=YES;
    _textView.text=nil;
}
-(void)viewWillDisappear:(BOOL)animated
{
    self.navigationController.navigationBarHidden=NO;
    [_yuYin dissmiss];
//    if (_voiceRecognizerView != nil) {
//        [self.voiceRecognizerView cancel];
//    }
//    [super viewWillDisappear:animated];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.backHomeBtn.hidden=YES;
    self.title=@"";
    _dataArray=[NSMutableArray new];
    self.automaticallyAdjustsScrollViewInsets=NO;
    [self CreatTabelView];
    
    
}



#pragma mark --创建数据源
-(void)CreatDataPage:(int)page{
    [Engine1 FirstJiaZaiYiAnMessagePage:[NSString stringWithFormat:@"%d",page] PageSize:@"10" success:^(NSDictionary *dic) {
        NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
        if ([code isEqualToString:@"200"]) {
            NSArray * dataArr=[dic objectForKey:@"data"];
            NSMutableArray * array2 =[NSMutableArray new];
            for (NSDictionary * dicc in dataArr) {
                ZhongYiModel * md =[[ZhongYiModel alloc]initWithZhongYiDic:dicc];
                [array2 addObject:md];
            }
        
            if (self.myRefreshView ==_tableView.header) {
                _dataArray=array2;
                _tableView.footer.hidden=_dataArray.count==0?YES:NO;
            }else if (self.myRefreshView == _tableView.footer){
                [_dataArray addObjectsFromArray:array2];
            }
            [_tableView reloadData];
            [_myRefreshView  endRefreshing];
            
        }else{
            [LCProgressHUD showMessage:[dic objectForKey:@"msg"]];
        }
    } error:^(NSError *error) {
         [_myRefreshView  endRefreshing];
    }];
}



#pragma mark --创建表头
-(UIView*)CcreatTabeViewHead{
    UIView * headView =[UIView new];
    headView.backgroundColor=BG_COLOR;
    headView.sd_layout
    .leftSpaceToView(_tableView,0)
    .rightSpaceToView(_tableView,0)
    .heightIs(370)//(ScreenHeight/100*53)
    .topSpaceToView(_tableView,0);
    //轮播图
    NSArray * arr =@[@"home_index"];//
   SDCycleScrollView* cycleScrollView2 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, ScreenWidth, 185*ScreenWidth/375) delegate:self placeholderImage:[UIImage imageNamed:@"home_index"]];
    
    cycleScrollView2.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    cycleScrollView2.currentPageDotColor = [UIColor whiteColor];
    [headView addSubview:cycleScrollView2];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        cycleScrollView2.imageURLStringsGroup = arr;
    });
    
//   //轮播图
    
    if ([ToolClass isiPad]==NO) {
        [Engine1 shouYiFirstLunBoisIPad:@"N" success:^(NSDictionary *dic) {
            NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
            if ([code isEqualToString:@"200"]) {
                NSArray * dataArr =[dic objectForKey:@"data"];
                NSMutableArray * array =[NSMutableArray new];
                NSMutableArray * iddStrArr =[NSMutableArray new];
                for (NSDictionary * dicc in dataArr) {
                    NSString * urlStr=[ToolClass isString:[NSString stringWithFormat:@"%@",[dicc objectForKey:@"filePath"]]];
                    NSString * idd =[ToolClass isString:[NSString stringWithFormat:@"%@",[dicc objectForKey:@"id"]]];
                    [array addObject:urlStr];
                    [iddStrArr addObject:idd];
                }
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    cycleScrollView2.imageURLStringsGroup = array;
                });
           
                cycleScrollView2.clickItemOperationBlock = ^(NSInteger index) {
                    LuoBoTiaoZhuanVC * vc =[LuoBoTiaoZhuanVC new];
                    vc.hidesBottomBarWhenPushed=YES;
                    vc.idd=iddStrArr[index];
                    [self.navigationController pushViewController:vc animated:YES];
                };
            
            
            }
        } error:^(NSError *error) {
            
        }];

    }
    
    
    
   //创建搜索框
    UIButton * seaarchBtn =[UIButton buttonWithType:UIButtonTypeCustom];
//    seaarchBtn.backgroundColor=[UIColor lightGrayColor];
    [seaarchBtn setBackgroundImage:[UIImage imageNamed:@"home_search_bg"] forState:0];
    [cycleScrollView2 sd_addSubviews:@[seaarchBtn]];
    seaarchBtn.sd_layout
    .leftSpaceToView(cycleScrollView2,10)
    .rightSpaceToView(cycleScrollView2,10)
    .topSpaceToView(cycleScrollView2,10)
    .heightIs(30);
  //放大镜
    UIImageView * searImage =[UIImageView new];
    searImage.image=[UIImage imageNamed:@"home_search"];
    [seaarchBtn sd_addSubviews:@[searImage]];
    searImage.sd_layout
    .leftSpaceToView(seaarchBtn,10)
    .centerYEqualToView(seaarchBtn)
    .widthIs(26/2)
    .heightIs(27/2);
    //语音
    UIButton * yuYinImage =[UIButton new];
//    yuYinImage.image=[UIImage imageNamed:@"home_yuyin"];
    [yuYinImage setImage:[UIImage imageNamed:@"home_yuyin"] forState:0];
    [seaarchBtn sd_addSubviews:@[yuYinImage]];
    [yuYinImage addTarget:self action:@selector(yuYinPublic) forControlEvents:UIControlEventTouchUpInside];
    yuYinImage.sd_layout
    .rightSpaceToView(seaarchBtn,10)
    .centerYEqualToView(seaarchBtn)
    .widthIs(24)
    .heightIs(34);
    
    //搜索框
    UITextField * searchText =[UITextField new];
    _textView=searchText;
    searchText.placeholder=@"搜索病种、方剂、中药等";
    [searchText setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    searchText.font=[UIFont systemFontOfSize:15];
    searchText.returnKeyType=UIReturnKeySearch;
    searchText.textColor=[UIColor whiteColor];
    searchText.delegate = self;
    [seaarchBtn sd_addSubviews:@[searchText]];
    searchText.sd_layout
    .leftSpaceToView(searImage,5)
    .rightSpaceToView(yuYinImage,10)
    .centerYEqualToView(seaarchBtn)
    .heightIs(30);
    
    
    
//创建的6个按钮  100238867741
    UIView * btnView =[UIView new];
    btnView.backgroundColor=[UIColor whiteColor];
    [headView sd_addSubviews:@[btnView]];
    btnView.sd_layout
    .leftSpaceToView(headView,0)
    .rightSpaceToView(headView,0)
    .topSpaceToView(cycleScrollView2,0);
        NSArray * imageNameArr =@[@"home_bt1",@"home_bt2",@"home_bt3",@"home_bt4",@"home_bt5",@"home_bt6"];
    NSArray * nameLabelArr =@[@"中药",@"方剂",@"三辨会诊",@"病种",@"中医医案",@"讲座"];
    int k =70;
    int g =70;
    int j =(ScreenWidth-80-k*3)/2;
    for (int i=0; i<imageNameArr.count; i++) {
        UIButton * btnImage =[UIButton buttonWithType:UIButtonTypeCustom];
        [btnImage setImage:[UIImage imageNamed:imageNameArr[i]] forState:0];
        btnImage.titleLabel.font=[UIFont systemFontOfSize:15];
        [btnImage setTitleColor:JXColor(139, 139, 139, 1) forState:0];
        [btnImage setTitle:nameLabelArr[i] forState:0];
        btnImage.tag=i;
        [btnImage addTarget:self action:@selector(btnImageClink:) forControlEvents:UIControlEventTouchUpInside];
        [btnView sd_addSubviews:@[btnImage]];
        // 设置button的图片的约束
        btnImage.imageView.sd_layout
        .widthIs(42)
        .topSpaceToView(btnImage, 0)
        .centerXEqualToView(btnImage)
        .heightIs(42);
        
        // 设置button的label的约束
        btnImage.titleLabel.sd_layout
        .topSpaceToView(btnImage.imageView, 8)
        .leftEqualToView(btnImage)
        .rightEqualToView(btnImage)
        .bottomSpaceToView(btnImage, 0);
        
        btnImage.titleLabel.textAlignment=1;
        if (ScreenWidth==320) {
            int jj =(ScreenWidth-40-k*3)/2;
            btnImage.sd_layout
            .leftSpaceToView(btnView,20+(k+jj)*(i%3))
            .topSpaceToView(btnView,16+(g+13)*(i/3))
            .widthIs(k)
            .heightIs(g);
        }else if ([ToolClass isiPad]){
            //平板专用坐标
            int kk =100;
            int jj =(ScreenWidth-160-kk*3)/2;
             btnImage.titleLabel.font=[UIFont systemFontOfSize:18];
            btnImage.sd_layout
            .leftSpaceToView(btnView,80+(kk+jj)*(i%3))
            .topSpaceToView(btnView,20+(kk+50)*(i/3))
            .widthIs(kk)
            .heightIs(kk);
            // 设置button的图片的约束
            btnImage.imageView.sd_layout
            .widthIs(128/2)
            .topSpaceToView(btnImage, 0)
            .centerXEqualToView(btnImage)
            .heightIs(128/2);
           
        }else{
            btnImage.sd_layout
            .leftSpaceToView(btnView,40+(k+j)*(i%3))
            .topSpaceToView(btnView,16+(g+13)*(i/3))
            .widthIs(k)
            .heightIs(g);
        }
        [btnView setupAutoHeightWithBottomView:btnImage bottomMargin:10];
    }
    //平板专用坐标
    if ([ToolClass isiPad]) {

        cycleScrollView2.frame=CGRectMake(0, 0, ScreenWidth, 570*ScreenWidth/1536);
        btnView.sd_layout
        .topSpaceToView(cycleScrollView2,0);
        [Engine1 shouYiFirstLunBoisIPad:@"Y" success:^(NSDictionary *dic) {
            NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
            if ([code isEqualToString:@"200"]) {
                NSArray * dataArr =[dic objectForKey:@"data"];
                NSMutableArray * array =[NSMutableArray new];
                NSMutableArray * iddStrArr =[NSMutableArray new];
                for (NSDictionary * dicc in dataArr) {
                    NSString * urlStr=[ToolClass isString:[NSString stringWithFormat:@"%@",[dicc objectForKey:@"filePath"]]];
                    NSString * idd =[ToolClass isString:[NSString stringWithFormat:@"%@",[dicc objectForKey:@"id"]]];
                    [array addObject:urlStr];
                    [iddStrArr addObject:idd];
                }
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    cycleScrollView2.imageURLStringsGroup = array;
                });
                
                cycleScrollView2.clickItemOperationBlock = ^(NSInteger index) {
                    LuoBoTiaoZhuanVC * vc =[LuoBoTiaoZhuanVC new];
                    vc.hidesBottomBarWhenPushed=YES;
                    vc.idd=iddStrArr[index];
                    [self.navigationController pushViewController:vc animated:YES];
                };
                
                
            }
        } error:^(NSError *error) {
            
        }];
        
        
        seaarchBtn.sd_layout
        .leftSpaceToView(cycleScrollView2,30)
        .rightSpaceToView(cycleScrollView2,30)
        .topSpaceToView(cycleScrollView2,15)
        .heightIs(45);
        searImage.sd_layout
        .widthIs(42/2)
        .heightIs(43/2);
        yuYinImage.sd_layout
        .widthIs(37/2)
        .heightIs(53/2);
    }
    
    
    [headView setupAutoHeightWithBottomView:btnView bottomMargin:10];
    __weak __typeof(headView)weakSelf = headView;
    headView.didFinishAutoLayoutBlock=^(CGRect rect){
        weakSelf.sd_layout
        .heightIs(rect.size.height);
        
        [self.tableView beginUpdates];
        [self.tableView setTableHeaderView:weakSelf];
        [self.tableView endUpdates];
        
    };
    
    
    
    
    return headView;
}
-(void)yuYinPublic{
     [self.view endEditing:YES];
    YuYinView * vc =[[YuYinView alloc]init];
    _yuYin=vc;
    //[weakSelf.textView deleteBackward];
     __weak typeof(self) weakSelf = self;
    vc.TextBlock=^(NSString*text,BOOL isLast){
        //1.获取光标位置
        NSRange selectedRange = weakSelf.textView.selectedRange;
        //2.将光标所在位置的的字符串进行替换
        weakSelf.textView.text = [weakSelf.textView.text stringByReplacingCharactersInRange:selectedRange withString:text];
        //3.修改光标位置,光标放到新增加的文字的后面
        weakSelf.textView.selectedRange = NSMakeRange((selectedRange.location + text.length), 0);
        if (isLast==YES) {
            SearchViewController * vc =[SearchViewController new];
            vc.keyWord=weakSelf.textView.text;
            vc.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:vc animated:YES];
        }

    };
    [vc  show];
}






#pragma mark --6个按钮btn点击状态
-(void)btnImageClink:(UIButton*)btn{

    [Engine1 chaXunVipShengJiLoginPhonesuccess:^(NSDictionary *dic) {
        NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
        if ([code isEqualToString:@"200"]) {
            NSDictionary * dataDic =[dic objectForKey:@"data"];
            NSString * dengJi =[NSString stringWithFormat:@"%@",[dataDic objectForKey:@"level"]];
            int dengJI =[dengJi intValue]-1;
            dengJi=[NSString stringWithFormat:@"%d",dengJI];
            NSString * str =[NSUSE_DEFO objectForKey:@"vip"];
            if ([dengJi isEqualToString:str]) {
            }else{
                [NSUSE_DEFO setObject:dengJi forKey:@"vip"];
                [NSUSE_DEFO synchronize];
            }
        }
    } error:^(NSError *error) {
        
    }];
   
    
    if (btn.tag==0) {
        if ( [ToolClass isLogin]==NO) {
            LoginViewController * vc =[LoginViewController new];
            vc.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            //药
            NSString*vip=[NSUSE_DEFO objectForKey:@"vip"];
            if ([vip intValue]>=2) {
                MedicineVC * vc =[MedicineVC new];
                vc.hidesBottomBarWhenPushed=YES;
                [self.navigationController pushViewController:vc animated:YES];
            }else{
                NSString * content =[NSString stringWithFormat:@"此权限仅对VIP2以上开放\n您当前是VIP%@",vip];
                TanKuangView * view =[[TanKuangView alloc]initWithTitle:@"温馨提示" contentName:content achiveBtn:@"确定"];
                view.buttonClinkBlock=^(UIButton*btn){
                    
                };
                [view show];
            }
//
           
        }
       
    }else if (btn.tag==1){
        if ( [ToolClass isLogin]==NO) {
            LoginViewController * vc =[LoginViewController new];
            vc.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            //药方
            NSString*vip=[NSUSE_DEFO objectForKey:@"vip"];
            if ([vip intValue]>=1) {
                YaoFangVC * vc =[YaoFangVC new];
                vc.hidesBottomBarWhenPushed=YES;
                [self.navigationController pushViewController:vc animated:YES];

            }else{
                NSString * content =[NSString stringWithFormat:@"此权限仅对VIP1以上开放\n您当前是VIP%@",vip];
                TanKuangView * view =[[TanKuangView alloc]initWithTitle:@"温馨提示" contentName:content achiveBtn:@"确定"];
                view.buttonClinkBlock=^(UIButton*btn){
                    
                };
                [view show];
            }
            
           
        }
        
    }else if (btn.tag==2){
        //三辩会诊
        if ( [ToolClass isLogin]==NO) {
            LoginViewController * vc =[LoginViewController new];
            vc.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            
            NSString*vip=[NSUSE_DEFO objectForKey:@"vip"];
            if ([vip intValue]>3) {
                ScanCodeVC * vc =[ScanCodeVC new];
                vc.tagg=1;
                vc.hidesBottomBarWhenPushed=YES;
                [self.navigationController pushViewController:vc animated:YES];
                //18031107573
            }else{
                NSString * content =[NSString stringWithFormat:@"此权限仅对VIP3以上开放\n您当前是VIP%@",vip];
                TanKuangView * view =[[TanKuangView alloc]initWithTitle:@"温馨提示" contentName:content achiveBtn:@"确定"];
                view.buttonClinkBlock=^(UIButton*btn){
                    
                };
                [view show];
            }
           
        }
        
        
    }else if (btn.tag==3){
        //病名
        if ( [ToolClass isLogin]==NO) {
            LoginViewController * vc =[LoginViewController new];
            vc.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            NSString*vip=[NSUSE_DEFO objectForKey:@"vip"];
            if ([vip intValue]>=2) {
                BingMingVC * vc =[BingMingVC new];
                vc.hidesBottomBarWhenPushed=YES;
                [self.navigationController pushViewController:vc animated:YES];
            }else{
                NSString * content =[NSString stringWithFormat:@"此权限仅对VIP2以上开放\n您当前是VIP%@",vip];
                TanKuangView * view =[[TanKuangView alloc]initWithTitle:@"温馨提示" contentName:content achiveBtn:@"确定"];
                view.buttonClinkBlock=^(UIButton*btn){
                    
                };
                [view show];
            }
            
        }
        
    }else if (btn.tag==4){
        //中医医案
        ZhongYiYiAnVC * vc =[ZhongYiYiAnVC new];
        vc.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (btn.tag==5){
        //讲座
        LecturesVC * vc =[LecturesVC new];
        vc.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
}


#pragma mark --创建表格
-(void)CreatTabelView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 20, ScreenWidth, ScreenHeight-49) style:UITableViewStylePlain];
    }
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.tableFooterView=[UIView new];
    _tableView.tableHeaderView=[self CcreatTabeViewHead];
    _tableView.rowHeight=80;
    if ([ToolClass isiPad]) {
        _tableView.rowHeight=100;
    }
    [self.view sd_addSubviews:@[_tableView]];
    
    __weak typeof (self) weakSelf =self;
    _tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.myRefreshView = weakSelf.tableView.header;
        _AAA=1;
        [self CreatDataPage:_AAA];
    }];
    
    [_tableView.header beginRefreshing];
    //..上拉刷新
    _tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        weakSelf.myRefreshView = weakSelf.tableView.footer;
        _AAA=_AAA+1;
        [self CreatDataPage:_AAA];;
    }];
    
    _tableView.footer.hidden = YES;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeTableViewCell * cell =[HomeTableViewCell cellWithTableView:tableView IndexPath:indexPath];
    cell.model=_dataArray[indexPath.row];
    return cell;
}

#pragma mark --表的点击
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZhongYiModel * md =_dataArray[indexPath.row];
    YiAnXiangQingVC * vc =[YiAnXiangQingVC new];
    vc.hidesBottomBarWhenPushed=YES;
    vc.messageID=md.zhongYiID;
    vc.titlename=md.titlename;
    [self.navigationController pushViewController:vc animated:YES];
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
   
    UIView * bgview =[UIView new];
    bgview.backgroundColor=BG_COLOR;
    
    
    UIView * headView =[UIView new];//  23  24
    headView.backgroundColor=[UIColor whiteColor];
    [bgview sd_addSubviews:@[headView]];
    headView.sd_layout
    .leftSpaceToView(bgview,0)
    .rightSpaceToView(bgview,0)
    .topSpaceToView(bgview,0)
    .bottomSpaceToView(bgview,1);
    
    UIButton * titlelabel =[UIButton buttonWithType:UIButtonTypeCustom];
    [titlelabel setTitle:@"医案" forState:0];
    titlelabel.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;//使图片和文字水平居中显示
    titlelabel.titleLabel.font=[UIFont systemFontOfSize:15];
    [titlelabel setTitleColor:JXColor(254, 111, 80, 1) forState:0];
    [titlelabel setImage:[UIImage imageNamed:@"home_yian"] forState:0];
    [headView sd_addSubviews:@[titlelabel]];
    titlelabel.sd_layout
    .centerYEqualToView(headView)
    .centerXEqualToView(headView)
    .heightIs(40)
    .widthIs(100);
    
    // 设置button的图片的约束
    titlelabel.imageView.sd_layout
    .widthIs(23/2)
    .leftSpaceToView(titlelabel, 5)
    .centerYEqualToView(titlelabel)
    .heightIs(24/2);
    
    // 设置button的label的约束
    titlelabel.titleLabel.sd_layout
    .centerYEqualToView(titlelabel.imageView)
    .leftSpaceToView(titlelabel.imageView,12)
    .rightEqualToView(titlelabel)
    .heightIs(20);
    
    //箭头
    UIButton * jianBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [jianBtn setImage:[UIImage imageNamed:@"home_arrow"] forState:0];//19  34
    [headView sd_addSubviews:@[jianBtn]];
    jianBtn.sd_layout
    .rightSpaceToView(headView,10)
    .centerYEqualToView(headView)
    .widthIs(20)
    .heightIs(34);
    
    
    
    if ([ToolClass isiPad]) {
        // 设置button的图片的约束
        titlelabel.imageView.sd_layout
        .widthIs(35/2)
        .leftSpaceToView(titlelabel, 5)
        .centerYEqualToView(titlelabel)
        .heightIs(37/2);
        titlelabel.titleLabel.font=[UIFont systemFontOfSize:17];

    }
    
    
    return bgview;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 51;
}




-(BOOL)textFieldShouldReturn:(UITextField *)textField

{
    
    [self.view endEditing:YES];
    SearchViewController * vc =[SearchViewController new];
    vc.keyWord=textField.text;
    vc.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:vc animated:YES];
    return YES;
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
      [self.view endEditing:YES];
}


@end
