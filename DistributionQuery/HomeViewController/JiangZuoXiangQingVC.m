//
//  JiangZuoXiangQingVC.m
//  DistributionQuery
//
//  Created by Macx on 17/4/24.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import "JiangZuoXiangQingVC.h"
#import "XjAVPlayerSDK.h"
#import "AppDelegate.h"
@interface JiangZuoXiangQingVC ()<XjAVPlayerSDKDelegate>
{
    XjAVPlayerSDK *myPlayer;
}
@property(nonatomic,strong)UIView * navView;
@end

@implementation JiangZuoXiangQingVC

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden=YES;
}
-(void)viewWillDisappear:(BOOL)animated
{
     self.navigationController.navigationBarHidden=NO;
    AppDelegate *appdelegate=(AppDelegate *)[UIApplication sharedApplication].delegate;
    appdelegate.allowRotation=NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"视频详情";
    AppDelegate *appdelegate=(AppDelegate *)[UIApplication sharedApplication].delegate;
    appdelegate.allowRotation=YES;
    [self moNiDaoHang];
    [self CreatLabel];


}
- (BOOL)shouldAutorotate{
    return YES;
}
#pragma mark --模拟导航条
-(void)moNiDaoHang{
    UIView * navView =[UIView new];
    navView.backgroundColor=[UIColor whiteColor];
    _navView=navView;
    [self.view sd_addSubviews:@[navView]];
    navView.sd_layout
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .topSpaceToView(self.view,0)
    .heightIs(64);
    //返回按钮
    UIButton * backBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"login_arrow_left"] forState:0];
    [backBtn addTarget:self action:@selector(backBtnClink) forControlEvents:UIControlEventTouchUpInside];
     backBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
    [navView sd_addSubviews:@[backBtn]];
    backBtn.sd_layout
    .leftSpaceToView(navView,15)
    .topSpaceToView(navView,20+7)
    .widthIs(70)
    .heightIs(30);
    //title
    UILabel * titleLabel =[UILabel new];
    titleLabel.text=@"视频详情";
    titleLabel.textColor=[UIColor redColor];
    titleLabel.textAlignment=1;
    titleLabel.font=[UIFont systemFontOfSize:16];
    [navView sd_addSubviews:@[titleLabel]];
    titleLabel.sd_layout
    .centerXEqualToView(navView)
    .centerYEqualToView(backBtn)
    .heightIs(30)
    .widthIs(120);
}


-(void)CreatLabel{
    UILabel * titlabel =[UILabel new];
    titlabel.text=@"周乐--古医脉诊、预防肺癌系列精品讲座";
    titlabel.font=[UIFont systemFontOfSize:15];
    titlabel.alpha=.6;
    titlabel.textAlignment=1;
    titlabel.numberOfLines=0;
    CGFloat g =[ToolClass HeightForText: titlabel.text withSizeOfLabelFont:15 withWidthOfContent:ScreenWidth-30];
    titlabel.frame=CGRectMake(15, 64+20, ScreenWidth-30, g);
    [self.view addSubview:titlabel];

    
    myPlayer= [[XjAVPlayerSDK alloc] initWithFrame:CGRectMake(0, titlabel.frame.origin.y+titlabel.frame.size.height+20, self.view.frame.size.width, self.view.frame.size.width/2)];
    myPlayer.xjPlayerUrl = @"http://static.tripbe.com/videofiles/20121214/9533522808.f4v.mp4";
    myPlayer.xjPlayerTitle = @"XJAVPlayer改良版";
    myPlayer.xjAutoOrient = YES;
    myPlayer.XjAVPlayerSDKDelegate = self;
    myPlayer.xjLastTime = 50;
    [self.view addSubview:myPlayer];

}

- (void)xjNextPlayer{
    myPlayer.xjPlayerUrl = @"http://www.jxgbwlxy.gov.cn/tm/course/041629011/sco1/1.mp4";
    myPlayer.xjPlayerTitle = @"谢大大的自传";
}
- (void)xjGoBack{
        [myPlayer xjStopPlayer];
        [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)backBtnClink
{
    [myPlayer xjStopPlayer];
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
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
