//
//  ZhongYiYiAnVC.m
//  DistributionQuery
//
//  Created by Macx on 17/4/30.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import "ZhongYiYiAnVC.h"
#import "ZhongYiYiAnCell.h"
#import "MoreZhongYiVC.h"
#import "YiAnXiangQingVC.h"
@interface ZhongYiYiAnVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)UIButton * lastBtn;
@end

@implementation ZhongYiYiAnVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"中医医案";
    [self CreatTabelView];
}

-(UIView*)CreatTableViewHead{
    UIView * headview =[UIView new];
    headview.backgroundColor=BG_COLOR;
    headview.sd_layout
    .leftSpaceToView(_tableView,0)
    .rightSpaceToView(_tableView,0)
    .topSpaceToView(_tableView,0)
    .heightIs(372);
    
    //创建选择病名
    UIView * view1=[UIView new];
    view1.backgroundColor=[UIColor whiteColor];
    [headview sd_addSubviews:@[view1]];
    view1.sd_layout
    .leftSpaceToView(headview,0)
    .rightSpaceToView(headview,0)
    .topSpaceToView(headview,0)
    .heightIs(45);
    
    UIView * linView =[UIView new];
    linView.backgroundColor=MAIN_COLOR;
    [view1 sd_addSubviews:@[linView]];
    linView.sd_layout
    .leftSpaceToView(view1,15)
    .heightIs(15)
    .centerYEqualToView(view1)
    .widthIs(2);
    
    UILabel * nameLable =[UILabel new];
    nameLable.text=@"选择病名分类";
    nameLable.textColor=MAIN_COLOR;
    nameLable.font=[UIFont systemFontOfSize:16];
    [view1 sd_addSubviews:@[nameLable]];
    nameLable.sd_layout
    .leftSpaceToView(linView,10)
    .centerYEqualToView(view1)
    .heightIs(25);
    [nameLable setSingleLineAutoResizeWithMaxWidth:200];

    
    
    
    
    
    //创建若干个按钮view2
    UIView * view2=[UIView new];
    view2.backgroundColor=[UIColor whiteColor];
    [headview sd_addSubviews:@[view2]];
    view2.sd_layout
    .leftSpaceToView(headview,0)
    .rightSpaceToView(headview,0)
    .topSpaceToView(view1,1)
    .heightIs(300);
    
    
    
    NSArray * btnArr=@[@"肺癌",@"胃癌",@"肝癌",@"肾癌",@"胶质量",@"鼻咽癌",@"口腔癌",@"下咽癌",@"乳腺癌",@"食管癌",@"贵门癌",@"大肠癌",@"但脑癌",@"胰腺癌",@"膀胱癌",@"阴茎癌",@"卵巢癌",@"宫颈癌",@"扁桃体癌",@"甲状腺癌",@"前列腺癌",@"黑色素癌",@"恶性淋巴瘤",@"子宫内膜瘤",@"胸膜间皮癌"];
    
    int kj =10;
    int k=(ScreenWidth-kj*5)/4;
    int g=k*52/148;
    int gj=15;
    if ([ToolClass isiPad]) {
        kj =25;
        k=(ScreenWidth-kj*5)/4;
        g=k*52/148;
        gj=15;
    }
    
    for (int i=0; i<btnArr.count; i++) {
        UIButton * btn =[UIButton buttonWithType:UIButtonTypeCustom];
        btn.sd_cornerRadius=@(15);
        btn.tag=i;
        [btn addTarget:self action:@selector(btnClink:) forControlEvents:UIControlEventTouchUpInside];
        btn.titleLabel.font=[UIFont systemFontOfSize:15];
        
        [btn setTitle:btnArr[i] forState:0];
        [btn setTitleColor:[UIColor lightGrayColor] forState:0];
        [btn setBackgroundImage:[UIImage imageNamed:@"btnNomol"] forState:0];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [btn setBackgroundImage:[UIImage imageNamed:@"btnSelete"] forState:UIControlStateSelected];
        
        if (i==0) {
            btn.selected=YES;
            _lastBtn=btn;
        }
        
        
        [view2 sd_addSubviews:@[btn]];
        btn.sd_layout
        .leftSpaceToView(view2,kj+(k+kj)*(i%4))
        .topSpaceToView(view2,gj+(g+gj)*(i/4))
        .widthIs(k)
        .heightIs(g);
        [view2 setupAutoHeightWithBottomView:btn bottomMargin:20];
        
    }
    
    [headview setupAutoHeightWithBottomView:view2 bottomMargin:5];
    headview.didFinishAutoLayoutBlock=^(CGRect rect){
        NSLog(@"输出%f>>>%f", rect.size.height,rect.origin.y);
    };
    
    return headview;
}

#pragma mark --btnClink
-(void)btnClink:(UIButton*)button{
    _lastBtn.selected=NO;
    button.selected=YES;
    _lastBtn=button;
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
    _tableView.tableHeaderView=[self CreatTableViewHead];
    _tableView.rowHeight=70;
    [self.view sd_addSubviews:@[_tableView]];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZhongYiYiAnCell * cell =[ZhongYiYiAnCell cellWithTableView:tableView IndexPath:indexPath];
    return cell;
}

#pragma mark --表的点击
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    YiAnXiangQingVC * vc =[YiAnXiangQingVC new];
    [self.navigationController pushViewController:vc animated:YES];
}


-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * headview =[UIView new];
    headview.backgroundColor=[UIColor whiteColor];
    UIView * linView =[UIView new];
    linView.backgroundColor=MAIN_COLOR;
    [headview sd_addSubviews:@[linView]];
    linView.sd_layout
    .leftSpaceToView(headview,15)
    .heightIs(15)
    .centerYEqualToView(headview)
    .widthIs(2);
    UILabel * namelabel =[UILabel new];
    namelabel.font=[UIFont systemFontOfSize:15];
    namelabel.textAlignment=0;
    namelabel.textColor=MAIN_COLOR;
    namelabel.text=@"医案";
    [headview sd_addSubviews:@[namelabel]];
    namelabel.sd_layout
    .leftSpaceToView(linView,10)
    .centerYEqualToView(headview)
    .heightIs(20);
    [namelabel setSingleLineAutoResizeWithMaxWidth:200];
    
    //更多
    UIButton * moreBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [moreBtn setImage:[UIImage imageNamed:@"jz_arrow_right"] forState:0];
    [moreBtn setTitle:@"更多" forState:0];
    [moreBtn addTarget:self action:@selector(moreBtnClink) forControlEvents:UIControlEventTouchUpInside];
    moreBtn.titleLabel.font=[UIFont systemFontOfSize:15];
    [moreBtn setTitleColor:JXColor(171, 171, 171, 1) forState:0];
    [headview sd_addSubviews:@[moreBtn]];
    moreBtn.sd_layout
    .rightSpaceToView(headview,15)
    .centerYEqualToView(headview)
    .widthIs(60)
    .heightIs(30);
    
    // 设置button的图片的约束
    moreBtn.imageView.sd_layout
    .widthIs(8)
    .rightSpaceToView(moreBtn, 5)
    .centerYEqualToView(moreBtn)
    .heightIs(13);
    
    // 设置button的label的约束
    moreBtn.titleLabel.sd_layout
    .centerYEqualToView(moreBtn.imageView)
    .rightSpaceToView(moreBtn.imageView,0)
    .leftSpaceToView(moreBtn,10)
    .heightIs(20);

    
    UIView * linview2 =[UIView new];
    linview2.backgroundColor=BG_COLOR;
    [headview sd_addSubviews:@[linview2]];
    linview2.sd_layout
    .leftSpaceToView(headview,5)
    .rightSpaceToView(headview,5)
    .bottomSpaceToView(headview,1)
    .heightIs(1);

    
    return headview;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}
#pragma mark--更多
-(void)moreBtnClink{
    MoreZhongYiVC * vc =[MoreZhongYiVC new];
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
