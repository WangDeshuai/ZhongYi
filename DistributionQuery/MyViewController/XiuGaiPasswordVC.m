//
//  XiuGaiPasswordVC.m
//  DistributionQuery
//
//  Created by Macx on 17/5/25.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import "XiuGaiPasswordVC.h"

@interface XiuGaiPasswordVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSArray * imageArr;
@property(nonatomic,strong)NSArray * dataArr;
@end

@implementation XiuGaiPasswordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"修改密码";//login_ys
    _imageArr=@[@"login_ys",@"login_ys",@"login_ys"];
    _dataArr=@[@"请输入原密码",@"请输入新密码",@"请再次输入新密码"];
    [self CreatTabelView];
    
    
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
    _tableView.rowHeight=55;
    [self.view sd_addSubviews:@[_tableView]];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArr.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        UIImageView * image1 =[UIImageView new];
        UITextField * textfield =[UITextField new];
        textfield.tag=2;
        image1.tag=1;
        [cell sd_addSubviews:@[image1,textfield]];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    UIImageView * image1 =[cell viewWithTag:1];
    image1.sd_layout
    .leftSpaceToView(cell,15)
    .centerYEqualToView(cell)
    .widthIs(25/2)
    .heightIs(31/2);
    image1.image=[UIImage imageNamed:_imageArr[indexPath.row]];
    UITextField * textfield =[cell viewWithTag:2];
    textfield.keyboardType=UIKeyboardTypeASCIICapable;
    textfield.placeholder=_dataArr[indexPath.row];
    textfield.font=[UIFont systemFontOfSize:15];
    textfield.sd_layout
    .leftSpaceToView(image1,10)
    .centerYEqualToView(cell)
    .heightIs(30)
    .rightSpaceToView(cell,15);
    return cell;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView * footView =[UIView new];
    footView.backgroundColor=BG_COLOR;
    
    UIButton * tuiChuBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [tuiChuBtn setTitle:@"完成" forState:0];
    [tuiChuBtn addTarget:self action:@selector(tuiChuBtnClink) forControlEvents:UIControlEventTouchUpInside];
    [tuiChuBtn setTitleColor:[UIColor whiteColor] forState:0];
    tuiChuBtn.titleLabel.font=[UIFont systemFontOfSize:15];
    tuiChuBtn.backgroundColor=MAIN_COLOR;
    tuiChuBtn.sd_cornerRadius=@(5);
    [footView sd_addSubviews:@[tuiChuBtn]];
    tuiChuBtn.sd_layout
    .leftSpaceToView(footView,20)
    .rightSpaceToView(footView,20)
    .centerYEqualToView(footView)
    .heightIs(40);
    
    return footView;
}
//完成
-(void)tuiChuBtnClink{
    UITableViewCell * cell1 =[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    UITableViewCell * cell2 =[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    UITableViewCell * cell3 =[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    
    UITextField * text1 =[cell1 viewWithTag:2];
    UITextField * text2 =[cell2 viewWithTag:2];
    UITextField * text3 =[cell3 viewWithTag:2];
    [LCProgressHUD showLoading:@"正在修改..."];
    [Engine XiuGaiPassWordYuan:text1.text NewWord:text2.text success:^(NSDictionary *dic) {
        NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
        [LCProgressHUD showMessage:[dic objectForKey:@"msg"]];
        if ([code isEqualToString:@"200"]) {
            //修改成功之后，退出从新登陆
            //1.清空token
            [NSUSE_DEFO removeObjectForKey:@"token"];
            [NSUSE_DEFO synchronize];
            //2.清空登录的.plist
            [ToolClass deleagtePlistName:@"Login"];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
    } error:^(NSError *error) {
        
    }];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 100;
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
