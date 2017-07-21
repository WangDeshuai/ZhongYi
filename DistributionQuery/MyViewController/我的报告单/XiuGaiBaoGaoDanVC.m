//
//  XiuGaiBaoGaoDanVC.m
//  DistributionQuery
//
//  Created by Macx on 17/5/25.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import "XiuGaiBaoGaoDanVC.h"

@interface XiuGaiBaoGaoDanVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSMutableArray * dataArray;
@property(nonatomic,strong)NSMutableArray * leftArray;
@end

@implementation XiuGaiBaoGaoDanVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"修改报告单";
    _leftArray=[[NSMutableArray alloc]initWithObjects:@"姓名:",@"性别:", @"年龄:",nil];
    _dataArray=[NSMutableArray new];
    [self bianJiBaoGaoDan];
    [self CreatTabelView];
    [self addFooterButton];
}

-(void)bianJiBaoGaoDan{
    [Engine1 bianJiMyBaoGaoDanMessage:_baoGaoID success:^(NSDictionary *dic)
    {
        NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
        if ([code isEqualToString:@"200"]) {
            NSDictionary * dataArr =[dic objectForKey:@"data"];
            NSString * name =[NSString stringWithFormat:@"%@",[dataArr objectForKey:@"name"]];
            NSString * age =[NSString stringWithFormat:@"%@",[dataArr objectForKey:@"age"]];
            NSString * sex =[self stingMorY:[NSString stringWithFormat:@"%@",[dataArr objectForKey:@"sex"]]];
            [_dataArray addObject:name];
            [_dataArray addObject:sex];
            [_dataArray addObject:age];
            [_tableView reloadData];
        }else{
            [LCProgressHUD showMessage:[dic objectForKey:@"msg"]];
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
        namelabel.textAlignment=0;
        namelabel.tag=1;
        namelabel.font=[UIFont systemFontOfSize:15];
        [cell sd_addSubviews:@[namelabel]];
        
        UITextField * textfield =[UITextField new];
        textfield.tag=2;
        
        textfield.font=[UIFont systemFontOfSize:15];
        [cell sd_addSubviews:@[textfield]];
    }
    UILabel * namelabel =[cell viewWithTag:1];
    namelabel.alpha=.7;
    namelabel.text=_leftArray[indexPath.row];
    UITextField * textfield =[cell viewWithTag:2];
    textfield.text=_dataArray[indexPath.row];
    textfield.textAlignment=0;
    namelabel.sd_layout
    .leftSpaceToView(cell,15)
    .centerYEqualToView(cell)
    .heightIs(20)
    .widthIs(40);
    
    textfield.sd_layout
    .leftSpaceToView(namelabel,5)
    .rightSpaceToView(cell,15)
    .heightIs(30)
    .centerYEqualToView(cell);
    
    
    return cell;
}
-(void)addFooterButton
{
    
    UIView * footView =[UIView new];
    footView.backgroundColor=BG_COLOR;
    footView.frame=CGRectMake(0, 10, ScreenWidth, 100);
    
    // 1.初始化Button
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    //    //2.设置文字和文字颜色
    [button setTitle:@"提交" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //    //3.设置圆角幅度
    button.layer.cornerRadius = 8.0;
    //
    [button addTarget:self action:@selector(buttonClink) forControlEvents:UIControlEventTouchUpInside];
    //    //4.设置frame
    button.frame =CGRectMake(30, 30, ScreenWidth-60, 40);;
    //
    //    //5.设置背景色
    button.backgroundColor = MAIN_COLOR;
    
    [footView addSubview:button];
    self.tableView.tableFooterView = footView;
}
#pragma mark --提交
-(void)buttonClink{
     UITableViewCell * cell0 =[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    UITableViewCell * cell1 =[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    UITableViewCell * cell2 =[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    UITextField * text1 =[cell0 viewWithTag:2];
    UITextField * text2 =[cell1 viewWithTag:2];
    UITextField * text3 =[cell2 viewWithTag:2];
    NSLog(@">>>%@",text1.text);
    NSLog(@">>>%@",text2.text);
    NSLog(@">>>%@",text3.text);
    [LCProgressHUD showLoading:@"请稍后..."];
    [Engine1 saveGengXinBaoGaoDanMessageID:_baoGaoID MessageName:text1.text MessageSex:[self stingMorYTwo:text2.text] Age:text3.text success:^(NSDictionary *dic) {
        [LCProgressHUD showMessage:[dic objectForKey:@"msg"]];
        NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
        if ([code isEqualToString:@"200"]) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    } error:^(NSError *error) {
        
    }];
    
    
}
-(NSString*)stingMorY:(NSString*)name{
    if ([name isEqualToString:@"M"]) {
        return @"男";
    }else{
        return @"女";
    }
}
-(NSString*)stingMorYTwo:(NSString*)name{
    if ([name isEqualToString:@"男"]) {
        return @"M";
    }else{
        return @"F";
    }
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
