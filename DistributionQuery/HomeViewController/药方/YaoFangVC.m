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
#import "YaoFangModel.h"
@interface YaoFangVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSMutableArray * dataArray;
@property(nonatomic,strong) UITextField * textfield;
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSMutableArray * topClassID;//上面分类ID
@property(nonatomic,strong)NSArray * topArray;
@property(nonatomic,assign)int AAA;
@property (nonatomic,strong) MJRefreshComponent *myRefreshView;
@property(nonatomic,strong)UIButton * lastBtn;
@end

@implementation YaoFangVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"方剂";
    [self searchView];
    [self CreatDataArray];
    [self CreatTabelView];
    
}

-(void)CreatDataInterNetPage:(int)page {
    [Engine yaoFangJiaZaiAllPage:[NSString stringWithFormat:@"%d",page] SearchStr:_textfield.text success:^(NSDictionary *dic) {
        NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
        if ([code isEqualToString:@"200"]) {
            NSArray * dataArr =[dic objectForKey:@"data"];
            NSMutableArray * array2 =[NSMutableArray new];
            for (NSDictionary * dicc in dataArr) {
                YaoFangModel * model =[[YaoFangModel alloc]initWithYaoListViewDic:dicc];
                [array2 addObject:model];
            }
           
            if (self.myRefreshView ==_tableView.header) {
                _dataArray=array2;
                _tableView.footer.hidden=_dataArray.count==0?YES:NO;
            }else if (self.myRefreshView == _tableView.footer){
                [_dataArray addObjectsFromArray:array2];
            }
            [_tableView reloadData];
            [_myRefreshView  endRefreshing];
            
            
            
        }
    } error:^(NSError *error) {
         [_myRefreshView  endRefreshing];
    }];
}


#pragma mark --创建数据源
-(void)CreatDataArray{
    _dataArray=[NSMutableArray new];
    _topClassID=[NSMutableArray new];
}
#pragma mark --创建搜索按钮
-(void)searchView{
    //搜索按钮
    UIButton * searchBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [searchBtn setTitle:@"搜索" forState:0];
    searchBtn.backgroundColor=BG_COLOR;
    [searchBtn setTitleColor:[UIColor blackColor] forState:0];
    searchBtn.alpha=.6;
    [searchBtn addTarget:self action:@selector(searchBtnClink2) forControlEvents:UIControlEventTouchUpInside];
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
    _textfield=textfield;
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
-(void)searchBtnClink2{
    [_dataArray removeAllObjects];
    [self CreatDataInterNetPage:0];
}


#pragma mark --表头
-(UIView*)CreatTableViewHead{
    UIView * bgHeadView =[UIView new];
    bgHeadView.backgroundColor=[UIColor whiteColor];
   
    bgHeadView.sd_layout
    .leftSpaceToView(_tableView,0)
    .rightSpaceToView(_tableView,0)
    .topSpaceToView(_tableView,0)
    .heightIs(248+5);
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
    
    [LCProgressHUD showMessage:@"请稍后..."];
    [Engine yaoFangClassFenLeisuccess:^(NSDictionary *dic) {
        NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
        if ([code isEqualToString:@"200"]) {
             [LCProgressHUD hide];
            NSArray * dataArr =[dic objectForKey:@"data"];
            NSMutableArray * array =[NSMutableArray new];
            for (NSDictionary * dicc in dataArr) {
                YaoFangModel * md =[[YaoFangModel alloc]initWithYaoClassViewDic:dicc];
                [array addObject:md.yaoFangClass];
                [_topClassID addObject:md.yaoClassID];
            }
//            [array addObject:@"更多"];
            //若干个按钮
            _topArray=array;
//            int kj= 10;
//            int k =(ScreenWidth-(10*5))/4;
//            int gj =15;
//            int g =25;
            
            int kj =10;
            int k=(ScreenWidth-kj*4)/3;
            int g=k*52/148-10;
            int gj=15;
            if ([ToolClass isiPad]) {
                kj =25;
                k=(ScreenWidth-kj*5)/4;
                g=k*52/148;
                gj=15;
            }
            for (int i =0; i<array.count; i++) {
                UIButton * button =[UIButton buttonWithType:UIButtonTypeCustom];
                 button.sd_cornerRadius=@(15);
                button.titleLabel.font=[UIFont systemFontOfSize:13];
                [button setTitle:array[i] forState:0];
                [button setTitleColor:[UIColor lightGrayColor] forState:0];
                [button setBackgroundImage:[UIImage imageNamed:@"btnNomol"] forState:0];
                [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
                [button setBackgroundImage:[UIImage imageNamed:@"btnSelete"] forState:UIControlStateSelected];
                [bgHeadView sd_addSubviews:@[button]];

                button.tag=i;
                button.sd_layout
                .leftSpaceToView(bgHeadView,kj+(k+kj)*(i%3))
                .topSpaceToView(nameLabel,gj+(g+gj)*(i/3))
                .widthIs(k)
                .heightIs(g);
                
                if (i==0) {
                    button.selected=YES;
                    _lastBtn=button;
                }
                
                if ([ToolClass isiPad]) {
                    button.sd_layout
                    .leftSpaceToView(bgHeadView,kj+(k+kj)*(i%4))
                    .topSpaceToView(nameLabel,gj+(g+gj)*(i/4))
                    .widthIs(k)
                    .heightIs(g);
                    ;
                }

//                button.sd_layout
//                .leftSpaceToView(bgHeadView,kj+(kj+k)*(i%4))
//                .topSpaceToView(nameLabel,gj+(gj+g)*(i/4))
//                .widthIs(k)
//                .heightIs(g);
                
                
                [button addTarget:self action:@selector(buttonClinck:) forControlEvents:UIControlEventTouchUpInside];
                [bgHeadView setupAutoHeightWithBottomView:button bottomMargin:10];
                
            }
            bgHeadView.didFinishAutoLayoutBlock=^(CGRect rect){
                NSLog(@">>>%f",rect.size.height);
                
            };
        }else{
            [LCProgressHUD showMessage:[dic objectForKey:@"msg"]];
        }
    } error:^(NSError *error) {
        
    }];
    
    
    
    
    
    
    
    
    return bgHeadView;
}
#pragma mark --topClink
-(void)buttonClinck:(UIButton*)btn{
//    YaoFangModel * md=_topArray[btn.tag];
//    if (btn.tag==_topArray.count-1) {
//        MoreClassVC * vc =[MoreClassVC new];
//        [self.navigationController pushViewController:vc animated:YES];
//    }else{
    _lastBtn.selected=NO;
    btn.selected=YES;
    _lastBtn=btn;
        YaoFangTopXQVC * vc =[YaoFangTopXQVC new];
        vc.classID=_topClassID[btn.tag];
        vc.titlename=_topArray[btn.tag];
        [self.navigationController pushViewController:vc animated:YES];
//    }
    
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
    
    __weak typeof (self) weakSelf =self;
    _tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.myRefreshView = weakSelf.tableView.header;
        _AAA=1;
        [self CreatDataInterNetPage:_AAA];
    }];
    
    [_tableView.header beginRefreshing];
    //..上拉刷新
    _tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        weakSelf.myRefreshView = weakSelf.tableView.footer;
        _AAA=_AAA+1;
        [self CreatDataInterNetPage:_AAA];
    }];
    
    _tableView.footer.hidden = YES;
    
    
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
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    UILabel * namelable= (UILabel*)[cell viewWithTag:1];
    namelable.alpha=.7;
    namelable.font=[UIFont systemFontOfSize:16];
    namelable.sd_layout
    .leftSpaceToView(cell,15)
    .centerYEqualToView(cell)
    .rightSpaceToView(cell,15)
    .heightIs(25);
    YaoFangModel * md=_dataArray[indexPath.row];
    namelable.text=md.name;
    
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
    nameLabel.text=@"名医名方";
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
#pragma mark --表格点击
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    YaoFangModel * md=_dataArray[indexPath.row];
    YaoFangContentXQVC * vc =[YaoFangContentXQVC new];
    vc.yaoID=md.yaoID;
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
