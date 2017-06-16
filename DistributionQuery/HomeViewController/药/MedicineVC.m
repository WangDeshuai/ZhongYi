//
//  MedicineVC.m
//  DistributionQuery
//
//  Created by Macx on 17/4/24.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import "MedicineVC.h"
#import "ChineseString.h"
#import "MedicineCell.h"
#import "MedicineModel.h"
#import "MedicineXiangQingVC.h"//详情页
@interface MedicineVC ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)UITextField * textfield;//文本框
@property(nonatomic,strong)NSMutableArray * rightIndexArr;//索引
@property(nonatomic,strong)NSMutableArray * contentArr;//标题
@property(nonatomic,strong)NSMutableArray * dexcontentArr;//副标题
@property(nonatomic,strong)NSMutableArray * imageArr;//副标题
@property(nonatomic,strong)NSMutableArray * contentIDArr;//副标题
@property(nonatomic,strong)NSMutableArray * dataArray;
@end

@implementation MedicineVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"药";
    _dataArray=[NSMutableArray new];
    [self dataArrSearZi:@""];
    [self CreatSearch];
    [self CreatTabelView];
}



-(void)dataArrSearZi:(NSString*)zifu{
    [LCProgressHUD showMessage:@"请稍后..."];
    [Engine allYaoPinMessage:zifu success:^(NSDictionary *dic) {
        NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
        
        if ([code isEqualToString:@"200"]) {
            [LCProgressHUD hide];
            NSArray * dataArr =[dic objectForKey:@"data"];
            NSMutableArray * titleArr =[NSMutableArray new];
            NSMutableArray * dexArr =[NSMutableArray new];
            NSMutableArray * imageArr =[NSMutableArray new];
            NSMutableArray * iddArr =[NSMutableArray new];
            for (int i =0; i<dataArr.count; i++) {
                NSDictionary * dicc =dataArr[i];
                MedicineModel * md =[[MedicineModel alloc]initWithYaoDic:dicc];
                [_dataArray addObject:md];
                [titleArr addObject:md.yaoTitleName];
                [dexArr addObject:md.yaoDexName];
                [imageArr addObject:md.yaoImageName];
                [iddArr addObject:md.yaoID];
            }
            
            _rightIndexArr=[ChineseString IndexArray:titleArr];//索引
            _contentArr=[ChineseString LetterSortArray:titleArr];//标题
            _dexcontentArr=[ChineseString LetterSortArray:dexArr];//副标题(去前缀)
            _imageArr=[ChineseString LetterSortArray2:imageArr];//图片(注意去掉前缀)
            _contentIDArr=[ChineseString LetterSortArray2:iddArr];//ID(注意去前缀)
            [_tableView reloadData];
        }else{
            [LCProgressHUD showMessage:[dic objectForKey:@"msg"]];
        }
    } error:^(NSError *error) {
        [LCProgressHUD showMessage:@"请求失败"];
    }];
    
    
    
    
   
    
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
    textfield.delegate=self;
    textfield.returnKeyType=UIReturnKeySearch;
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

#pragma mark --搜索按钮
-(void)searchBtnClink{
    [self dataArrSearZi:_textfield.text];
}
#pragma mark --搜索
-(BOOL)textFieldShouldReturn:(UITextField *)textField

{
    [self.view endEditing:YES];
    [self dataArrSearZi:_textfield.text];
    return YES;
}


#pragma mark --创建表格
-(void)CreatTabelView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 100, ScreenWidth, ScreenHeight-64-100) style:UITableViewStylePlain];
    }
    _tableView.tableFooterView=[UIView new];
    _tableView.backgroundColor=BG_COLOR;
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.keyboardDismissMode=UIScrollViewKeyboardDismissModeOnDrag;
    _tableView.rowHeight=80;
    [self.view sd_addSubviews:@[_tableView]];
    
}

//返回索引数组
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return _rightIndexArr;
}
//响应点击索引时的委托方法
-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    NSInteger count = 0;
    for(NSString *character in _rightIndexArr)
    {
        if([character isEqualToString:title])
        {
            return count;
        }
        count ++;
    }
    return 0;
}

//返回每个区头索引的内容(不用设置区头的高度)
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString * str =[_rightIndexArr objectAtIndex:section];
    return [NSString stringWithFormat:@"     %@",str];
}





-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _contentArr.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_contentArr[section] count];
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MedicineCell * cell =[MedicineCell cellWithTableView:tableView IndexPath:indexPath];
    NSString * title =_contentArr[indexPath.section][indexPath.row];
    NSString * imageName2 =_imageArr[indexPath.section][indexPath.row];
    cell.titleLabel.text=title;
    //拼音
    NSString * pinYin =_dexcontentArr[indexPath.section][indexPath.row];
    //去前缀
    NSString * pinYinStr =[pinYin substringFromIndex:title.length];
    cell.dexLabel.text=pinYinStr;
    
    
    [cell.imageview setImageWithURL:[NSURL URLWithString:[imageName2 substringFromIndex:title.length]] placeholderImage:[UIImage imageNamed:@"yao_zw"]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //药名(用去判断前缀长度)
    NSString * name =_contentArr[indexPath.section][indexPath.row];
    //idd(包涵前缀)
    NSString * idd =_contentIDArr[indexPath.section][indexPath.row];
    MedicineXiangQingVC * vc =[MedicineXiangQingVC new];
    //去掉前缀
    vc.yaoID=[idd substringFromIndex:name.length];
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
