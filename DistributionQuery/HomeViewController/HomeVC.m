//
//  HomeVC.m
//  DistributionQuery
//
//  Created by Macx on 16/10/8.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "HomeVC.h"
#import "MedicineVC.h"//药
#import "LecturesVC.h"//讲座
@interface HomeVC ()<UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate,UIScrollViewDelegate>
@property(nonatomic,strong)UITableView * tableView;

@end

@implementation HomeVC
-(void)viewWillAppear:(BOOL)animated
{
     self.navigationController.navigationBarHidden=YES;
}
-(void)viewWillDisappear:(BOOL)animated
{
    self.navigationController.navigationBarHidden=NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.backHomeBtn.hidden=YES;
    self.title=@"";
    self.automaticallyAdjustsScrollViewInsets=NO;
    [self CreatTabelView];
    
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
   SDCycleScrollView* cycleScrollView2 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, ScreenWidth, 370/2) delegate:self placeholderImage:[UIImage imageNamed:@"home_index"]];
    
    cycleScrollView2.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    cycleScrollView2.currentPageDotColor = [UIColor whiteColor];
    [headView addSubview:cycleScrollView2];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        cycleScrollView2.imageURLStringsGroup = arr;
    });
    cycleScrollView2.clickItemOperationBlock = ^(NSInteger index) {
        // NSLog(@">>>>>  %ld", (long)index);
        
    };
    
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
    UIImageView * yuYinImage =[UIImageView new];
    yuYinImage.image=[UIImage imageNamed:@"home_yuyin"];
    [seaarchBtn sd_addSubviews:@[yuYinImage]];
    yuYinImage.sd_layout
    .rightSpaceToView(seaarchBtn,10)
    .centerYEqualToView(seaarchBtn)
    .widthIs(24/2)
    .heightIs(34/2);
    
//创建的6个按钮
    UIView * btnView =[UIView new];
    btnView.backgroundColor=[UIColor whiteColor];
    [headView sd_addSubviews:@[btnView]];
    btnView.sd_layout
    .leftSpaceToView(headView,0)
    .rightSpaceToView(headView,0)
    .topSpaceToView(cycleScrollView2,0)
    .bottomSpaceToView(headView,5);
    NSArray * imageNameArr =@[@"home_bt1",@"home_bt2",@"home_bt3",@"home_bt4",@"home_bt5",@"home_bt6"];
    NSArray * nameLabelArr =@[@"药",@"药方",@"三辩会诊",@"病名",@"中医医案",@"讲座"];
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
        
    }
    //平板专用坐标
    if ([ToolClass isiPad]) {
        headView.sd_layout
        .heightIs(580);
        cycleScrollView2.frame=CGRectMake(0, 0, ScreenWidth, 580/2);
        btnView.sd_layout
        .topSpaceToView(cycleScrollView2,0);
        
        
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
    
    
    
    
    return headView;
}

#pragma mark --6个按钮btn点击状态
-(void)btnImageClink:(UIButton*)btn{

    if (btn.tag==0) {
        //药
        MedicineVC * vc =[MedicineVC new];
        vc.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (btn.tag==1){
        //药方
    }else if (btn.tag==2){
        //三辩会诊
    }else if (btn.tag==3){
        //病名
    }else if (btn.tag==4){
        //中医医案
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
    [self.view sd_addSubviews:@[_tableView]];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 30;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    cell.textLabel.font=[UIFont systemFontOfSize:15];
    cell.textLabel.alpha=.6;
    cell.textLabel.text=@"123";
    return cell;
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








@end
