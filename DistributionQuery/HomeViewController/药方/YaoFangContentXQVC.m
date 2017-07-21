//
//  YaoFangContentXQVC.m
//  DistributionQuery
//
//  Created by Macx on 17/4/27.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import "YaoFangContentXQVC.h"
#import "YaoFangContentXQCell.h"
#import "YaoFangModel.h"
#import "UILabel+YBAttributeTextTapAction.h"
#import "MedicineXiangQingVC.h"
@interface YaoFangContentXQVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSArray * leftArray;
@property(nonatomic,strong)NSMutableArray * dataArray;
@property(nonatomic,strong)NSMutableArray * zuChengArr;
@property(nonatomic,strong)NSMutableArray * zuChengID;
@end

@implementation YaoFangContentXQVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _zuChengArr=[NSMutableArray new];
    _zuChengID=[NSMutableArray new];
    self.title=@"药方详情";
    [self CreatArray];
    [self CreatTabelView];
}
#pragma mark --创建数据源
-(void)CreatArray{
    _dataArray=[NSMutableArray new];
    [LCProgressHUD showLoading:@"请稍后..."];
    [Engine1 jiaZaiYaoFangXiangQingYaoID:_yaoID success:^(NSDictionary *dic)
    {
        NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
        if ([code isEqualToString:@"200"]) {
            [LCProgressHUD hide];
            NSDictionary * dicc =[dic objectForKey:@"data"];
           
            NSArray * zuChengArr =[dicc objectForKey:@"comprises"];
            for (NSDictionary * zudicc  in zuChengArr) {
                NSString * zName =[ToolClass isString:[NSString stringWithFormat:@"%@",[zudicc objectForKey:@"drug_name"]]];
                NSString * zKeShu=[ToolClass isString:[NSString stringWithFormat:@"%@",[zudicc objectForKey:@"value"]]];
                NSString * idd =[ToolClass isString:[NSString stringWithFormat:@"%@",[zudicc objectForKey:@"id"]]];
                NSString * zk =[NSString stringWithFormat:@"%@%@",zName,zKeShu];
                [_zuChengArr addObject:zk];
                [_zuChengID addObject:idd];
            }

            
            YaoFangModel * md =[[YaoFangModel alloc]initWithYaoFangXiangQingDic:dicc];
             self.title=md.xqfangMing;
             [_dataArray addObject:md.xqfangMing];
             [_dataArray addObject:md.xqzuCheng];
             [_dataArray addObject:md.xqgongXiao];
             [_dataArray addObject:md.xqzhuZhi];
//             [_dataArray addObject:md.xqfangJie];
            NSString*vip=[NSUSE_DEFO objectForKey:@"vip"];
            if ([vip intValue]>=3) {
                [_dataArray addObject:md.xqfangJie];
            }else{
                [_dataArray addObject:@"此权限仅对VIP3开放"];
            }
            
             [_dataArray addObject:md.xqyongFa];
             [_dataArray addObject:md.xqjinJi];
             [_dataArray addObject:md.xqzhuYiShiXiang];
            [_tableView reloadData];
            
        }else{
            [LCProgressHUD showMessage:[dic objectForKey:@"msg"]];
        }
    } error:^(NSError *error) {
        
    }];
    
    _leftArray=@[@"【方名】",@"【组成】",@"【功效】",@"【主治】",@"【方解】",@"【用法】",@"【禁忌】",@"【注意事项】"];
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
    YaoFangContentXQCell * cell =[YaoFangContentXQCell cellWithTableView:tableView IndexPath:indexPath];
    cell.namelabel.text=_leftArray[indexPath.row];
    if (indexPath.row==7) {
       cell.text=[NSString stringWithFormat:@"                        %@",_dataArray[indexPath.row]];
    }else if(indexPath.row==1){
       [self juYaoCell:cell];
    }else{
         cell.text=[NSString stringWithFormat:@"                 %@",_dataArray[indexPath.row]];
    }
   
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * str ;
    if (indexPath.row==7) {
        str=[NSString stringWithFormat:@"                        %@",_dataArray[indexPath.row]];
    }else{
        str=[NSString stringWithFormat:@"                 %@",_dataArray[indexPath.row]];
    }
    
    
    
    
    return  [_tableView cellHeightForIndexPath:indexPath model:str keyPath:@"text" cellClass:[YaoFangContentXQCell class] contentViewWidth:[ToolClass  cellContentViewWith]];
}
-(void)juYaoCell:(YaoFangContentXQCell*)cell{
    NSString * label_text2 =[NSString stringWithFormat:@"                 %@",_dataArray[1]];
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:5];
    
    NSDictionary *attribs = @{NSParagraphStyleAttributeName: paragraphStyle};
    
    NSMutableAttributedString *attributedString2 = [[NSMutableAttributedString alloc]initWithString:label_text2  attributes:attribs];
   
    
    [attributedString2 addAttribute:NSForegroundColorAttributeName value:JXColor(0, 135, 243, 1) range:NSMakeRange(0, label_text2.length)];
    [attributedString2 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, label_text2.length)];
    
    cell.contentlabel.attributedText=attributedString2;
    [ cell.contentlabel yb_addAttributeTapActionWithStrings:_zuChengArr tapClicked:^(NSString *string, NSRange range, NSInteger index) {
        MedicineXiangQingVC * vc =[MedicineXiangQingVC new];
        vc.yaoID=_zuChengID[index];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    cell.contentlabel.enabledTapEffect = NO;
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
