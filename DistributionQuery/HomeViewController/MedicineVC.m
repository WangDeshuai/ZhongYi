//
//  MedicineVC.m
//  DistributionQuery
//
//  Created by Macx on 17/4/24.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import "MedicineVC.h"
#import "ChineseString.h"
@interface MedicineVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSMutableArray * rightIndexArr;
@property(nonatomic,strong)NSMutableArray * contentArr;

@end

@implementation MedicineVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"药";
    [self dataArr];
    [self CreatSearch];
    [self CreatTabelView];
}



-(void)dataArr{
    NSArray * contentArray=@[@"艾叶",@"安息草",@"艾纳香",@"白术",@"白芷",@"陈皮",@"仓鼠",@"星星",@"邢日",@"刑天",@"网吧",@"往来",@"实在",@"石家庄"];
    //返回表右边索引的首字母
    _rightIndexArr=[ChineseString IndexArray:contentArray];
    //把内容按照首字母分好后，从新排列成一个个小数组，并且返回
    _contentArr=[ChineseString LetterSortArray:contentArray];
    
}

#pragma mark --创建顶部搜索框
-(void)CreatSearch{
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
    _tableView.rowHeight=50;
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
    UITableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    cell.textLabel.font=[UIFont systemFontOfSize:15];
    cell.textLabel.alpha=.6;
    cell.textLabel.text=_contentArr[indexPath.section][indexPath.row];//
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
