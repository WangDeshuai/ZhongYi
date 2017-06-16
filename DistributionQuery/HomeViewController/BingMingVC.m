//
//  BingMingVC.m
//  DistributionQuery
//
//  Created by Macx on 17/5/2.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import "BingMingVC.h"
#import "YaoFangModel.h"
#import "BingMingXiangQingVC.h"
@interface BingMingVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)UIButton * lastBtn;
@property(nonatomic,strong) UITextField * textfield;
@property(nonatomic,strong)NSMutableArray * classID;
@property(nonatomic,strong)NSMutableArray * dataArray1;
@end

@implementation BingMingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"病种";
    _classID=[NSMutableArray new];
    _dataArray1=[NSMutableArray new];
//    [self CreatSearch];
    [self CreatTabelView];
}
#pragma mark --创建顶部搜索框
-(void)CreatSearch{
    //搜索按钮
    UIButton * searchBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [searchBtn setTitle:@"搜索" forState:0];
    
    searchBtn.backgroundColor=BG_COLOR;
    [searchBtn addTarget:self action:@selector(searchBtnClink) forControlEvents:UIControlEventTouchUpInside];
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
    _textfield=textfield;
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
    
    //药物分类
    UILabel * nameLable =[UILabel new];
    nameLable.backgroundColor=[UIColor whiteColor];
    nameLable.text=@"   药物分类";
    nameLable.textColor=JXColor(187, 187, 187, 1);
    nameLable.font=[UIFont systemFontOfSize:15];
    [self.view sd_addSubviews:@[nameLable]];
    nameLable.sd_layout
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .topSpaceToView(textfield,10)
    .heightIs(45);
    
}
#pragma mark --搜索
-(void)searchBtnClink{
    
}
-(UIView*)CreatTableViewHead{
    UIView * headview =[UIView new];
    headview.backgroundColor=[UIColor whiteColor];
    headview.sd_layout
    .leftSpaceToView(_tableView,0)
    .rightSpaceToView(_tableView,0)
    .topSpaceToView(_tableView,0)
    .heightIs(ScreenHeight);
    
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

    
    //
    
    [Engine bingMingFenLeisuccess:^(NSDictionary *dic) {
        NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
        if ([code isEqualToString:@"200"]) {
            NSArray * dataArr =[dic objectForKey:@"data"];
           // NSMutableArray * array =[NSMutableArray new];
            for (NSDictionary * dicc in dataArr) {
                YaoFangModel * md =[[YaoFangModel alloc]initWithYaoClassViewDic:dicc];
                [_dataArray1 addObject:md.yaoFangClass];
                [_classID addObject:md.yaoClassID];
            }

//            NSArray * btnArr=@[@"肺癌",@"胃癌",@"肝癌",@"肾癌",@"胶质量",@"鼻咽癌",@"口腔癌",@"下咽癌",@"乳腺癌",@"食管癌",@"贵门癌",@"大肠癌",@"但脑癌",@"胰腺癌",@"膀胱癌",@"阴茎癌",@"卵巢癌",@"宫颈癌",@"扁桃体癌",@"甲状腺癌",@"前列腺癌",@"黑色素癌",@"恶性淋巴瘤",@"子宫内膜瘤",@"胸膜间皮癌"];
            
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
            
            for (int i=0; i<_dataArray1.count; i++) {
                UIButton * btn =[UIButton buttonWithType:UIButtonTypeCustom];
                btn.sd_cornerRadius=@(15);
                btn.tag=i;
                [btn addTarget:self action:@selector(btnClink:) forControlEvents:UIControlEventTouchUpInside];
                btn.titleLabel.font=[UIFont systemFontOfSize:13];
                
                [btn setTitle:_dataArray1[i] forState:0];
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
                .leftSpaceToView(view2,kj+(k+kj)*(i%3))
                .topSpaceToView(view2,gj+(g+gj)*(i/3))
                .widthIs(k)
                .heightIs(g);
                [view2 setupAutoHeightWithBottomView:btn bottomMargin:20];
                
                if ([ToolClass isiPad]) {
                    btn.sd_layout
                    .leftSpaceToView(view2,kj+(k+kj)*(i%4))
                    .topSpaceToView(view2,gj+(g+gj)*(i/4))
                    .widthIs(k)
                    .heightIs(g);
                    [view2 setupAutoHeightWithBottomView:btn bottomMargin:20];
                }
                
            }
            
            [headview setupAutoHeightWithBottomView:view2 bottomMargin:5];
            headview.didFinishAutoLayoutBlock=^(CGRect rect){
                NSLog(@"输出%f>>>%f", rect.size.height,rect.origin.y);
            };
            

            
            
        }
    } error:^(NSError *error) {
        
    }];
    
    
    
    
    
    
       return headview;
}

#pragma mark --btnClink
-(void)btnClink:(UIButton*)button{
    _lastBtn.selected=NO;
    button.selected=YES;
    _lastBtn=button;
    BingMingXiangQingVC * vc =[[BingMingXiangQingVC alloc]init];
    vc.titleName=_dataArray1[button.tag];
    vc.bingID=_classID[button.tag];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark --创建表格
-(void)CreatTabelView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64) style:UITableViewStylePlain];
    }
    _tableView.tableFooterView=[UIView new];
    _tableView.backgroundColor=[UIColor whiteColor];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.keyboardDismissMode=UIScrollViewKeyboardDismissModeOnDrag;
    _tableView.tableHeaderView=[self CreatTableViewHead];
    [self.view sd_addSubviews:@[_tableView]];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
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
