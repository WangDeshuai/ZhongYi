//
//  MyZhuYeVC.m
//  DistributionQuery
//
//  Created by Macx on 17/5/2.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import "MyZhuYeVC.h"
#import "MyZhuYeXiuGaiVC.h"
#import "ChooseCityVC.h"
@interface MyZhuYeVC ()<UITableViewDataSource,UITableViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSMutableDictionary * messageDic;
@property(nonatomic,strong)NSArray * leftArray;
@property(nonatomic,strong)UIImage * headImage;//头像
@property(nonatomic,copy)NSString * nameText;//姓名
@property(nonatomic,copy)NSString * yiYuanText;//医院名称
@property(nonatomic,copy)NSString * addressText;//详细地址
@property(nonatomic,copy)NSString * xingBieText;//性别Code
@property(nonatomic,copy)NSString * diQuName;
@property(nonatomic,copy)NSString * diQuCode;
@end

@implementation MyZhuYeVC

-(void)viewWillAppear:(BOOL)animated
{
   
    [Engine1 chaXunMyZhuYesuccess:^(NSDictionary *dic) {
        NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
        if ([code isEqualToString:@"200"]) {
            NSDictionary * dataDic =[dic objectForKey:@"data"];

            _messageDic=[ToolClass isDictionary:dataDic];
            [_tableView reloadData];
        }else{
            [LCProgressHUD showMessage:[dic objectForKey:@"msg"]];
        }
    } error:^(NSError *error) {
        
    }];
    
//    _messageDic=[ToolClass duquPlistWenJianPlistName:@"Login"];
  
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"我的主页";
    [self dataArray];
    [self CreatTabelView];
}

-(void)dataArray{
    _leftArray=@[@"头像",@"姓名",@"性别",@"医院名称",@"选择地区",@"详细地址"];
}
#pragma mark --创建表格
-(void)CreatTabelView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 5, ScreenWidth, ScreenHeight-64-5) style:UITableViewStylePlain];
    }
    _tableView.tableFooterView=[UIView new];
    _tableView.backgroundColor=[UIColor whiteColor];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.keyboardDismissMode=UIScrollViewKeyboardDismissModeOnDrag;
  
    [self.view sd_addSubviews:@[_tableView]];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _leftArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Cell"];
        UIImageView * lineImage =[UIImageView new];
        lineImage.tag=10;
        [cell sd_addSubviews:@[lineImage]];
    }
    
    UIImageView * imageivew =[cell viewWithTag:10];
    imageivew.hidden=NO;
    cell.textLabel.font=[UIFont systemFontOfSize:15];
    cell.textLabel.text=_leftArray[indexPath.row];
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.detailTextLabel.font=[UIFont systemFontOfSize:15];
    cell.detailTextLabel.textColor=[UIColor blackColor];
    cell.detailTextLabel.alpha=.7;
    if (indexPath.row==0) {
        //头像
        imageivew.hidden=NO;
        if (_headImage==nil) {
          
            [imageivew setImageWithURL:[NSURL URLWithString:[_messageDic objectForKey:@"filePath"]] placeholderImage:[UIImage imageNamed:@"homepage_pic"]];
        }else{
            imageivew.image=_headImage;
        }
        imageivew.sd_cornerRadius=@(30);
        imageivew.sd_layout
        .rightSpaceToView(cell,35)
        .centerYEqualToView(cell)
        .widthIs(60)
        .heightIs(60);
        
    }else if (indexPath.row==1){
        //姓名
        cell.detailTextLabel.text=[self stringHouMianText:_nameText InternetText:[self stringValue:[_messageDic objectForKey:@"name"] Sting:@"未填写"]];
    }else if (indexPath.row==2){
        //性别
         cell.detailTextLabel.text=[self stringHouMianText:_xingBieText InternetText:[self stringValue:[self sringSex:[_messageDic objectForKey:@"sex"]] Sting:@"未选择"]];
    }else if (indexPath.row==3){
        //医院名称
         cell.detailTextLabel.text=[self stringHouMianText:_yiYuanText InternetText:[self stringValue:[_messageDic objectForKey:@"hospitalName"] Sting:@"未填写"]];
    }else if (indexPath.row==4){
        //地区选择
         cell.detailTextLabel.text=[self stringHouMianText:_diQuName InternetText:[self stringValue:[_messageDic objectForKey:@"city_name"] Sting:@"未填写"]];
    }else if (indexPath.row==5){
        //详细地址
         cell.detailTextLabel.text=[self stringHouMianText:_addressText InternetText:[self stringValue:[_messageDic objectForKey:@"address"] Sting:@"未填写"]];
    }
    
    
    
   
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row==0) {
        //头像
        [self headImageClick];
    }else if (indexPath.row==1){
        //姓名
        MyZhuYeXiuGaiVC * vc =[MyZhuYeXiuGaiVC new];
        vc.titleStr=_leftArray[indexPath.row];
        vc.number=0;
        vc.messageBlock=^(NSString*name){
            _nameText=name;
            [_tableView reloadData];
        };
        [self.navigationController pushViewController:vc animated:YES];

    }else if (indexPath.row==2){
        //性别
        MyZhuYeXiuGaiVC * vc =[MyZhuYeXiuGaiVC new];
        vc.titleStr=_leftArray[indexPath.row];
        vc.number=3;
        vc.messageBlock=^(NSString*name){
            _xingBieText=name;
            [_tableView reloadData];
        };
        [self.navigationController pushViewController:vc animated:YES];

    }else if (indexPath.row==3){
        //医院名称
        MyZhuYeXiuGaiVC * vc =[MyZhuYeXiuGaiVC new];
        vc.titleStr=_leftArray[indexPath.row];
         vc.number=1;
        vc.messageBlock=^(NSString*name){
            _yiYuanText=name;
            [_tableView reloadData];
        };
        [self.navigationController pushViewController:vc animated:YES];

    }else if (indexPath.row==4){
        //选择地区
        ChooseCityVC * vc =[ChooseCityVC new];
        vc.CityNameBlock=^(NSString*sheng,NSString*city,NSString*xian,NSString*xianCode){
            _diQuName=[NSString stringWithFormat:@"%@-%@-%@",sheng,city,xian];
            _diQuCode=xianCode;
            [_tableView reloadData];
        };
        [self.navigationController pushViewController:vc animated:YES];;
    }else if (indexPath.row==5){
        //详细地址
        MyZhuYeXiuGaiVC * vc =[MyZhuYeXiuGaiVC new];
        vc.titleStr=_leftArray[indexPath.row];
        vc.number=2;
        vc.messageBlock=^(NSString*name){
            _addressText=name;
            [_tableView reloadData];
        };
        [self.navigationController pushViewController:vc animated:YES];

    }
    
    
    
    
}
//text1是从后面界面传过来的，text2是从上个界面过来的_model
-(NSString *)stringHouMianText:(NSString*)text1 InternetText:(NSString*)text2{
    
    NSString * str;
    if (text1) {
        str=text1;
    }else{
        str=text2;
    }
    
    return str;
}

-(NSString*)stringValue:(NSString*)str1 Sting:(NSString*)str2{
    if (str1 && ![str1 isEqualToString:@""]) {
        return str1;
    }else{
        return str2;
    }
}
//性别
-(NSString*)sringSex:(NSString*)str{
    if ([str isEqualToString:@"Y"]) {
        return @"女";
    }else if ([str isEqualToString:@"M"]){
        return @"男";
    }else{
        return @"未选择";
    }
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        return 80;
    }else{
        return 50;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark --调用系统相册
-(void)headImageClick{
    UIImagePickerController * imagePicker =[UIImagePickerController new];
    imagePicker.delegate = self;
    imagePicker.sourceType=UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    imagePicker.allowsEditing=YES;
    imagePicker.navigationController.navigationBar.barTintColor = [UIColor redColor];
    [self presentViewController:imagePicker animated:YES completion:nil];
    
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
   
    _headImage=image;
    [self dismissViewControllerAnimated:YES completion:nil];
    [LCProgressHUD showLoading:@"请稍后..."];
    [Engine1 headImage:image success:^(NSDictionary *dic) {
       
        [LCProgressHUD showMessage:[dic objectForKey:@"msg"]];
    } error:^(NSError *error) {
        
    }];
    [_tableView reloadData];
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
