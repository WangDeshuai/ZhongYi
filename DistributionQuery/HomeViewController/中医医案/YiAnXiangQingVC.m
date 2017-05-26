//
//  YiAnXiangQingVC.m
//  DistributionQuery
//
//  Created by Macx on 17/5/2.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import "YiAnXiangQingVC.h"
#import "YiAnXiangQingCell.h"
@interface YiAnXiangQingVC ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSArray * leftArray;
@property(nonatomic,strong)NSMutableArray * dataArray;
@end

@implementation YiAnXiangQingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"医案详情";
    [self CreatArr];
    [self CreatTabelView];
}
-(void)CreatArr{
    _leftArray=@[@"患者情况:",@"初诊时间:",@"病案详情:"];
    _dataArray=[NSMutableArray new];
//    _dataArray=@[@"王璇、女、28岁、河北保定",@"2017-05-03",@"异常出汗4月，异于常人，情绪容易激动，脾气暴躁，话多、患者长期痰湿内生，中焦气机阻泄，气急败坏，胀痛大便不通等病情"];
    
    
    
}

-(UIView*)CreatHeadView{
    UIView * headview =[UIView new];
    headview.sd_layout
    .leftSpaceToView(_tableView,0)
    .rightSpaceToView(_tableView,0)
    .topSpaceToView(_tableView,0)
    .heightIs(316*(ScreenWidth-20)/640+35+25);
    
    UILabel * nameLable =[UILabel new];
    nameLable.text=@"理气和胃，化痰清热食管麻痹";
    nameLable.textColor=MAIN_COLOR;
    nameLable.font=[UIFont systemFontOfSize:16];
    nameLable.textAlignment=1;
    [headview sd_addSubviews:@[nameLable]];
    nameLable.sd_layout
    .leftSpaceToView(headview,10)
    .rightSpaceToView(headview,10)
    .heightIs(20)
    .topSpaceToView(headview,15);
    
    UIImageView * imageview =[UIImageView new];
    imageview.image=[UIImage imageNamed:@"home_index"];//640 316
    [headview sd_addSubviews:@[imageview]];
    imageview.sd_layout
    .leftSpaceToView(headview,0)
    .rightSpaceToView(headview,0)
    .topSpaceToView(nameLable,15)
    .heightIs(370/2);
    
    
    
    [LCProgressHUD showLoading:@"请稍后..."];
    [Engine YiAnXiangQingMessageID:_messageID success:^(NSDictionary *dic) {
        NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
        if ([code isEqualToString:@"200"]) {
            [LCProgressHUD hide];
            NSDictionary * dataDic =[dic objectForKey:@"data"];
            [_dataArray addObject:[ToolClass isString:[NSString stringWithFormat:@"%@",[dataDic objectForKey:@"patientCondition"]]]];
            NSString * time=[ToolClass isString:[NSString stringWithFormat:@"%@",[dataDic objectForKey:@"createTime"]]];
            [_dataArray addObject:[ToolClass ConvertStrToTime:[time longLongValue]]];
            [_dataArray addObject:[ToolClass isString:[NSString stringWithFormat:@"%@",[dataDic objectForKey:@"content"]]]];
            [_tableView reloadData];
            //图片
            NSString * strImage =[ToolClass isString:[NSString stringWithFormat:@"%@",[dataDic objectForKey:@"filePath"]]];
            [imageview setImageWithURL:[NSURL URLWithString:strImage] placeholderImage:[UIImage imageNamed:@"home_index"]];
        }else{
            [LCProgressHUD showMessage:[dic objectForKey:@"msg"]];
        }
    } error:^(NSError *error) {
        [LCProgressHUD showMessage:@"加载失败"];
    }];

    
    
    
    return headview;
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
    _tableView.tableHeaderView=[self CreatHeadView];
    [self.view sd_addSubviews:@[_tableView]];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YiAnXiangQingCell * cell =[YiAnXiangQingCell cellWithTableView:tableView IndexPath:indexPath];
    
    if (indexPath.row==2) {
        cell.text1=[_dataArray lastObject];
    }else{
        cell.text=[NSString stringWithFormat:@"                   %@",_dataArray[indexPath.row]];
    }
    
    
    
    cell.leftLabel.text=_leftArray[indexPath.row];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * str =[NSString stringWithFormat:@"                   %@",_dataArray[indexPath.row]];
    CGFloat gg =[tableView cellHeightForIndexPath:indexPath model:str keyPath:@"text" cellClass:[YiAnXiangQingCell class] contentViewWidth:[ToolClass cellContentViewWith]];
    
    if (indexPath.row==2) {
        return gg;
    }
    
    return gg;
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
