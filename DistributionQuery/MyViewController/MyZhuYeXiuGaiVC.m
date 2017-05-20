//
//  MyZhuYeXiuGaiVC.m
//  DistributionQuery
//
//  Created by Macx on 17/5/2.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import "MyZhuYeXiuGaiVC.h"

@interface MyZhuYeXiuGaiVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITextField * textfield;
@property(nonatomic,strong)NSArray * leftArray;
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSArray * canShuArr;
@end

@implementation MyZhuYeXiuGaiVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=_titleStr;
  
    _canShuArr=@[@"name",@"hospital_name",@"address",@"sex"];
    if (_number==3) {
        //性别
        [self CreatTabelView];
    }else{
          [self CreatRightBtn];
         [self tianXieData];
    }
    
}
//选择填写
-(void)tianXieData{
    
    _leftArray=@[@"请修改您的姓名",@"请修改医院名称",@"请填写详细地址"];
    
    UILabel * namelabel =[UILabel new];
    namelabel.text=_leftArray[_number];
    namelabel.alpha=.6;
    namelabel.font=[UIFont systemFontOfSize:15];
    [self.view sd_addSubviews:@[namelabel]];
    namelabel.sd_layout
    .leftSpaceToView(self.view,15)
    .topSpaceToView(self.view,10)
    .heightIs(20);
    [namelabel setSingleLineAutoResizeWithMaxWidth:200];
    
    
    UIView * bgView =[UIView new];
    bgView.backgroundColor=[UIColor whiteColor];
    [self.view sd_addSubviews:@[bgView]];
    bgView.sd_layout
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .topSpaceToView(namelabel,10)
    .heightIs(50);
    
    _textfield=[UITextField new];
    _textfield.placeholder=@"请输入您要修改的名称";
    _textfield.font=[UIFont systemFontOfSize:16];
    [bgView sd_addSubviews:@[_textfield]];
    _textfield.sd_layout
    .leftSpaceToView(bgView,15)
    .centerYEqualToView(bgView)
    .rightSpaceToView(bgView,15)
    .heightIs(45);
}

//右按钮
-(void)CreatRightBtn{
    UIButton*  backHomeBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [backHomeBtn setTitle:@"确定" forState:0];
    [backHomeBtn setTitleColor:MAIN_COLOR forState:0];
    backHomeBtn.frame=CGRectMake(0, 0, 100, 30);
    backHomeBtn.titleLabel.font=[UIFont systemFontOfSize:15];
    backHomeBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentRight;
    [backHomeBtn addTarget:self action:@selector(rightBtnClink) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftBtn2 =[[UIBarButtonItem alloc]initWithCustomView:backHomeBtn];
    self.navigationItem.rightBarButtonItems=@[leftBtn2];
}
-(void)rightBtnClink{
   // self.messageBlock(_textfield.text);
    NSLog(@"参数>>>%@  Value>>%@",_canShuArr[_number],_textfield.text);
    [LCProgressHUD showLoading:@"请稍后..."];
    [Engine myZhuYeSaveMessageCanShuName:_canShuArr[_number] ValueName:_textfield.text Phone:@"15032735032" success:^(NSDictionary *dic) {
        NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
        if ([code isEqualToString:@"200"]) {
            [LCProgressHUD hide];
             self.messageBlock(_textfield.text);
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [LCProgressHUD showMessage:[dic objectForKey:@"msg"]];
        }
    } error:^(NSError *error) {
        
    }];
   // [self.navigationController popViewControllerAnimated:YES];
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
    return 2;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    cell.textLabel.font=[UIFont systemFontOfSize:15];
    cell.textLabel.alpha=.6;
    cell.textLabel.textAlignment=1;
    if (indexPath.row==0) {
        cell.textLabel.text=@"男";
    }else if (indexPath.row==1){
        cell.textLabel.text=@"女";
    }
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
       
        [LCProgressHUD showLoading:@"请稍后..."];
        [Engine myZhuYeSaveMessageCanShuName:@"sex" ValueName:@"M" Phone:@"15032735032" success:^(NSDictionary *dic) {
            NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
            if ([code isEqualToString:@"200"]) {
                [LCProgressHUD hide];
                self.messageBlock(@"0");
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                [LCProgressHUD showMessage:[dic objectForKey:@"msg"]];
            }
        } error:^(NSError *error) {
            
        }];
        
        
        
        
       // self.messageBlock(@"0");//男
        //[self.navigationController popViewControllerAnimated:YES];
    }else if(indexPath.row==1){
        [LCProgressHUD showLoading:@"请稍后..."];
        [Engine myZhuYeSaveMessageCanShuName:@"sex" ValueName:@"Y" Phone:@"15032735032" success:^(NSDictionary *dic) {
            NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
            if ([code isEqualToString:@"200"]) {
                [LCProgressHUD hide];
                self.messageBlock(@"1");
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                [LCProgressHUD showMessage:[dic objectForKey:@"msg"]];
            }
        } error:^(NSError *error) {
            
        }];
    }
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
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
