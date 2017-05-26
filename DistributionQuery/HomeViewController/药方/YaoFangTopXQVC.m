//
//  YaoFangTopXQVC.m
//  DistributionQuery
//
//  Created by Macx on 17/4/27.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import "YaoFangTopXQVC.h"
#import "YaoFangModel.h"
#import "YaoFangContentXQVC.h"
@interface YaoFangTopXQVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSArray * titleArray;
@property(nonatomic,strong)NSArray * contentArray;
@property(nonatomic,strong)NSMutableArray * dataArray;
@end

@implementation YaoFangTopXQVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=_titlename;
    [self CreatDataArr];
    [self CreatTabelView];
}
#pragma mark --创建数据源
-(void)CreatDataArr{
    _dataArray=[NSMutableArray new];
    [Engine bingZhongFenLeiXiangXiID:_classID success:^(NSDictionary *dic) {
        NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
        if ([code isEqualToString:@"200"]) {
            NSArray * dataArr =[dic objectForKey:@"data"];
            if (dataArr.count==0) {
                [LCProgressHUD showMessage:@"暂无内容"];
                [self.navigationController popViewControllerAnimated:YES];
                return ;
            }
            
            for (NSDictionary * dicc in dataArr) {
                YaoFangModel * md =[[YaoFangModel alloc]initWithFenLeiXiangQingDic:dicc];
                [_dataArray addObject:md];
            }
            [_tableView reloadData];
            
        }else{
            [LCProgressHUD showMessage:[dic objectForKey:@"msg"]];
        }
    } error:^(NSError *error) {
        
    }];
    
    
    
    
    
//    _titleArray=@[@"生脉散",@"药汤",@"六一散",@"四君子汤",@"理中丸",@"大力丸"];
//    _contentArray=@[@"【功效】益气养阴，剑汗生脉，益气养阴，剑汗生脉",@"【功效】益气养阴，剑汗生脉",@"【功效】益气养阴，剑汗生脉，仪器",@"【功效】益气养阴，剑汗生脉益气养阴，剑汗生脉",@"【功效】益气养阴，剑汗生脉，益气养阴，剑汗生脉，益气养阴，剑汗生脉益气养阴，剑汗生脉，益气养阴，剑汗生脉，益气养阴，剑汗生脉益气养阴，剑汗生脉，益气养阴，剑汗生脉，益气养阴，剑汗生脉益气养阴，剑汗生脉，益气养阴，剑汗生脉，益气养阴，剑汗生脉",@"【功效】益气养阴，剑汗生脉"];
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
        UILabel * titleLabel =[UILabel new];
        titleLabel.tag=10;
        titleLabel.textColor=MAIN_COLOR;
        UILabel * contentLabel =[UILabel new];
        contentLabel.tag=20;
        contentLabel.alpha=.6;
        [cell sd_addSubviews:@[titleLabel,contentLabel]];
    }
    YaoFangModel * md =_dataArray[indexPath.row];
    UILabel * titlelabel =[cell viewWithTag:10];
    UILabel * contentlabel =[cell viewWithTag:20];
    titlelabel.font=[UIFont systemFontOfSize:16];
    contentlabel.font=[UIFont systemFontOfSize:16];
    contentlabel.numberOfLines=2;
    titlelabel.sd_layout
    .leftSpaceToView(cell,15)
    .topSpaceToView(cell,10)
    .rightSpaceToView(cell,15)
    .heightIs(20);
    
    contentlabel.sd_layout
    .leftEqualToView(titlelabel)
    .topSpaceToView(titlelabel,5)
    .rightSpaceToView(cell,15)
    .heightIs(40);
    
    
    titlelabel.text=md.titleclassname;
    contentlabel.text=[NSString stringWithFormat:@"【功效】%@",md.gongclassxiao];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath

{
//    NSString * str =_contentArray[indexPath.row];
//     CGFloat contentViewWidth = CGRectGetWidth(self.tableView.bounds);
//    CGFloat height=  [ToolClass HeightForText:str withSizeOfLabelFont:16 withWidthOfContent:contentViewWidth];
    
   
    
    return 90;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     YaoFangModel * md =_dataArray[indexPath.row];
    YaoFangContentXQVC * vc =[YaoFangContentXQVC new];
    vc.yaoID=md.fenleiID;
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
