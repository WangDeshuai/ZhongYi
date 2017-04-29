//
//  YaoFangVC.m
//  DistributionQuery
//
//  Created by Macx on 17/4/25.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import "YaoFangVC.h"
#import "YaoFangTopXQVC.h"//分类详情
#import "MoreClassVC.h"//更多分类
#import "YaoFangContentXQVC.h"//药方详情

@interface YaoFangVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSArray * dataArray;
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSArray * topArray;
@end

@implementation YaoFangVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"药方";
    [self searchView];
    [self CreatDataArray];
    [self CreatTabelView];
    
}
#pragma mark --创建数据源
-(void)CreatDataArray{
    _dataArray=@[@"神经病",@"精神病",@"桂之缘(肺癌)",@"桂枝汤(胃癌)"];
}
#pragma mark --创建搜索按钮
-(void)searchView{
    //搜索按钮
    UIButton * searchBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [searchBtn setTitle:@"搜索" forState:0];
    searchBtn.backgroundColor=BG_COLOR;
    [searchBtn setTitleColor:[UIColor blackColor] forState:0];
    searchBtn.alpha=.6;
    searchBtn.titleLabel.font=[UIFont systemFontOfSize:15];
    [self.view sd_addSubviews:@[searchBtn]];
    searchBtn.sd_layout
    .rightSpaceToView(self.view,15)
    .heightIs(35)
    .topSpaceToView(self.view,10)
    .widthIs(70);
    //搜索框
    UITextField * textfield =[UITextField new];
    textfield.placeholder=@"搜索药";
    textfield.backgroundColor=[UIColor whiteColor];
    textfield.font=[UIFont systemFontOfSize:15];
    textfield.leftView =[ToolClass imageViewNameStr:@"yao_search"];
    textfield.leftViewMode = UITextFieldViewModeAlways;
    textfield.sd_cornerRadius=@(5);
    [self.view sd_addSubviews:@[textfield]];
    textfield.sd_layout
    .leftSpaceToView(self.view,15)
    .rightSpaceToView(searchBtn,0)
    .topSpaceToView(self.view,10)
    .heightIs(35);
    //语音
    UIButton * yuYinBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [yuYinBtn setImage:[UIImage imageNamed:@"yao_yuyin"] forState:0];
    [textfield sd_addSubviews:@[yuYinBtn]];
    yuYinBtn.sd_layout
    .rightSpaceToView(textfield,10)
    .centerYEqualToView(textfield)
    .widthIs(30)
    .heightIs(30);
    
    
}
#pragma mark --表头
-(UIView*)CreatTableViewHead{
    UIView * bgHeadView =[UIView new];
    bgHeadView.backgroundColor=[UIColor whiteColor];
   
    bgHeadView.sd_layout
    .leftSpaceToView(_tableView,0)
    .rightSpaceToView(_tableView,0)
    .topSpaceToView(_tableView,0)
    .heightIs(164+5);
    //分类图标
    UIImageView * tuBiaoImage =[UIImageView new];
    tuBiaoImage.image=[UIImage imageNamed:@"yf_search"];
    [bgHeadView sd_addSubviews:@[tuBiaoImage]];
    tuBiaoImage.sd_layout
    .leftSpaceToView(bgHeadView,15)
    .topSpaceToView(bgHeadView,15)
    .widthIs(18)
    .heightIs(18);
    UILabel * nameLabel =[UILabel new];
    nameLabel.text=@"选择分类";
    nameLabel.textColor=MAIN_COLOR;
    nameLabel.font=[UIFont systemFontOfSize:16];
    [bgHeadView sd_addSubviews:@[nameLabel]];
    nameLabel.sd_layout
    .leftSpaceToView(tuBiaoImage,10)
    .centerYEqualToView(tuBiaoImage)
    .heightIs(20)
    .widthIs(150);
    //若干个按钮
    NSArray * titleBtn=@[@"食管癌",@"乳腺癌",@"胃癌癌",@"肠癌",@"咽炎癌",@"子宫癌",@"卵巢癌",@"血瘤癌",@"脂肪癌",@"宫颈癌",@"淋巴癌",@"更多"];
    _topArray=titleBtn;
    int kj= 15;
    int k =(ScreenWidth-(15*5))/4;
    int gj =15;
    int g =25;
    for (int i =0; i<titleBtn.count; i++) {
        UIButton * button =[UIButton buttonWithType:UIButtonTypeCustom];
//        button.backgroundColor=[UIColor magentaColor];
        button.titleLabel.font=[UIFont systemFontOfSize:15];
        [button setTitle:titleBtn[i] forState:0];
        [button setTitleColor:[UIColor blackColor] forState:0];
        [bgHeadView sd_addSubviews:@[button]];
        button.tag=i;
        button.sd_layout
        .leftSpaceToView(bgHeadView,kj+(kj+k)*(i%4))
        .topSpaceToView(nameLabel,gj+(gj+g)*(i/4))
        .widthIs(k)
        .heightIs(g);
        [button addTarget:self action:@selector(buttonClinck:) forControlEvents:UIControlEventTouchUpInside];
        [bgHeadView setupAutoHeightWithBottomView:button bottomMargin:10];
        
    }
    bgHeadView.didFinishAutoLayoutBlock=^(CGRect rect){
        NSLog(@">>>%f",rect.size.height);
        
    };
    
    
    
    
    return bgHeadView;
}
#pragma mark --topClink
-(void)buttonClinck:(UIButton*)btn{
   
    if (btn.tag==_topArray.count-1) {
        MoreClassVC * vc =[MoreClassVC new];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        YaoFangTopXQVC * vc =[YaoFangTopXQVC new];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}
#pragma mark --创建表格
-(void)CreatTabelView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 55, ScreenWidth, ScreenHeight-64) style:UITableViewStylePlain];
    }
    _tableView.tableFooterView=[UIView new];
    _tableView.backgroundColor=BG_COLOR;
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.keyboardDismissMode=UIScrollViewKeyboardDismissModeOnDrag;
    _tableView.rowHeight=50;
    _tableView.tableHeaderView=[self CreatTableViewHead];
    [self.view sd_addSubviews:@[_tableView]];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        UILabel * namelabel =[UILabel new];
        namelabel.tag=1;
        [cell sd_addSubviews:@[namelabel]];
    }
    UILabel * namelable= (UILabel*)[cell viewWithTag:1];
    namelable.alpha=.7;
    namelable.font=[UIFont systemFontOfSize:16];
    namelable.sd_layout
    .leftSpaceToView(cell,15)
    .centerYEqualToView(cell)
    .rightSpaceToView(cell,15)
    .heightIs(25);
    namelable.text=_dataArray[indexPath.row];
    
    return cell;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * headview =[UIView new];
    headview.backgroundColor=[UIColor whiteColor];
    
    //分类图标
    UIImageView * tuBiaoImage =[UIImageView new];
    tuBiaoImage.image=[UIImage imageNamed:@"yf_yao"];
    [headview sd_addSubviews:@[tuBiaoImage]];
    tuBiaoImage.sd_layout
    .leftSpaceToView(headview,15)
    .centerYEqualToView(headview)
    .widthIs(13)
    .heightIs(11);
    UILabel * nameLabel =[UILabel new];
    nameLabel.text=@"张士舜名医名方";
    nameLabel.textColor=MAIN_COLOR;
    nameLabel.font=[UIFont systemFontOfSize:16];
    [headview sd_addSubviews:@[nameLabel]];
    nameLabel.sd_layout
    .leftSpaceToView(tuBiaoImage,10)
    .centerYEqualToView(tuBiaoImage)
    .heightIs(20)
    .widthIs(200);
    
    //线
    UIView * linView =[UIView new];
    linView.backgroundColor=BG_COLOR;
    [headview sd_addSubviews:@[linView]];
    linView.sd_layout
    .leftSpaceToView(headview,5)
    .bottomSpaceToView(headview,1)
    .heightIs(1)
    .rightSpaceToView(headview,5);
    
    
    
    return headview;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    YaoFangContentXQVC * vc =[YaoFangContentXQVC new];
    [self.navigationController pushViewController:vc animated:YES];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
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
