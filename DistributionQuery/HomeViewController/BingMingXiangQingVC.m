//
//  BingMingXiangQingVC.m
//  DistributionQuery
//
//  Created by Macx on 17/5/3.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import "BingMingXiangQingVC.h"
#import "BingMingXiangQingCell.h"
#import "BingMingModel.h"
#import "UILabel+YBAttributeTextTapAction.h"
#import "MedicineXiangQingVC.h"
@interface BingMingXiangQingVC ()<UITableViewDelegate,UITableViewDataSource,YBAttributeTapActionDelegate>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSArray * titleArray;
@property(nonatomic,strong)NSMutableArray * dataArray;
@property(nonatomic,strong)NSMutableArray * junYaoArray;
@property(nonatomic,strong)NSMutableArray * chenYaoArray;
@property(nonatomic,strong)NSMutableArray * zuoYaoArray;
@property(nonatomic,strong)NSMutableArray * shiYaoArray;
@property(nonatomic,strong)NSMutableArray * junYaoArrayID;
@property(nonatomic,strong)NSMutableArray * chenYaoArrayID;
@property(nonatomic,strong)NSMutableArray * zuoYaoArrayID;
@property(nonatomic,strong)NSMutableArray * shiYaoArrayID;
@end

@implementation BingMingXiangQingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=_titleName;
    _dataArray=[NSMutableArray new];
    _junYaoArray=[NSMutableArray new];
    _chenYaoArray=[NSMutableArray new];
    _zuoYaoArray=[NSMutableArray new];
    _shiYaoArray=[NSMutableArray new];
    
    _junYaoArrayID=[NSMutableArray new];
    _chenYaoArrayID=[NSMutableArray new];
    _zuoYaoArrayID=[NSMutableArray new];
    _shiYaoArrayID=[NSMutableArray new];
    [self CreatRightBtn];
    [self CreatData];
    [self CreatTabelView];
}

-(void)CreatRightBtn{
    UIButton*  backHomeBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [backHomeBtn setImage:[UIImage imageNamed:@"xq_sc"] forState:0];
    [backHomeBtn setImage:[UIImage imageNamed:@"xq_sc_click"] forState:UIControlStateSelected];
    [backHomeBtn setTitleColor:MAIN_COLOR forState:0];
    backHomeBtn.frame=CGRectMake(0, 0, 100, 30);
    backHomeBtn.titleLabel.font=[UIFont systemFontOfSize:15];
    backHomeBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentRight;
    [backHomeBtn addTarget:self action:@selector(rightBtnClink:) forControlEvents:UIControlEventTouchUpInside];
    [Engine1 YanZhengMyShouCangMessageID:_bingID Type:@"2" success:^(NSDictionary *dic) {
        NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
        if ([code isEqualToString:@"200"]) {
            //收藏
            backHomeBtn.selected=YES;
        }else{
            //未收藏
            backHomeBtn.selected=NO;
        }
    } error:^(NSError *error) {
        
    }];
    UIBarButtonItem * leftBtn2 =[[UIBarButtonItem alloc]initWithCustomView:backHomeBtn];
    self.navigationItem.rightBarButtonItems=@[leftBtn2];
}
-(void)rightBtnClink:(UIButton*)btn{
    btn.selected=!btn.selected;
    if (btn.selected==NO) {
        //取消
        [Engine1 shouCangSaveStype:@"2" MessageID:_bingID uccess:^(NSDictionary *dic) {
            [LCProgressHUD showMessage:[dic objectForKey:@"msg"]];
        } error:^(NSError *error) {
            
        }];
    }else{
        //选中（药=1，病=2，讲座=3，医案=4）
        [Engine1 shouCangSaveStype:@"2" MessageID:_bingID uccess:^(NSDictionary *dic) {
            [LCProgressHUD showMessage:[dic objectForKey:@"msg"]];
        } error:^(NSError *error) {
            
        }];
    }
    
}






#pragma mark --数据源
-(void)CreatData{
    [LCProgressHUD showLoading:@"请稍后..."];
    NSLog(@">>>%@",_bingID);
    [Engine1 BingZhongXiangQingClassID:_bingID success:^(NSDictionary *dic) {
        NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
        if ([code isEqualToString:@"200"]) {
            
            if ([dic objectForKey:@"data"]==[NSNull null] ) {
                [LCProgressHUD showFailure:@"数据为空"];
                [self.navigationController popViewControllerAnimated:YES];
                return ;
            }
            [LCProgressHUD hide];
            NSDictionary * dataDic =[dic objectForKey:@"data"];
            NSArray * jun=[dataDic objectForKey:@"juns"];
            NSArray * chen =[dataDic objectForKey:@"chens"];
            NSArray * zuo=[dataDic objectForKey:@"zuos"];
            NSArray * shi =[dataDic objectForKey:@"shis"];
           //君药
            for (NSDictionary * junDic in jun) {
                NSString * name =[junDic objectForKey:@"drugName"];
                NSString * idd =[NSString stringWithFormat:@"%@",[junDic objectForKey:@"id"]];
                [_junYaoArray addObject:name];
                [_junYaoArrayID addObject:idd];
            }
            //臣药
            for (NSDictionary * chenDic in chen) {
                NSString * name =[chenDic objectForKey:@"drugName"];
                NSString * idd =[NSString stringWithFormat:@"%@",[chenDic objectForKey:@"id"]];
                [_chenYaoArray addObject:name];
                [_chenYaoArrayID addObject:idd];
            }
            
            //佐药
            for (NSDictionary * zuoDic in zuo) {
                NSString * name =[zuoDic objectForKey:@"drugName"];
                NSString * idd =[NSString stringWithFormat:@"%@",[zuoDic objectForKey:@"id"]];
                [_zuoYaoArray addObject:name];
                [_zuoYaoArrayID addObject:idd];
            }
            
            //使药
            for (NSDictionary * shiDic in shi) {
                NSString * name =[shiDic objectForKey:@"drugName"];
                NSString * idd =[NSString stringWithFormat:@"%@",[shiDic objectForKey:@"id"]];
                [_shiYaoArray addObject:name];
                [_shiYaoArrayID addObject:idd];
            }
            
            
            BingMingModel * md =[[BingMingModel alloc]initWithBingMingXiangQingDic:dataDic];
            [_dataArray addObject:md.xqBingName];
            [_dataArray addObject:md.xqzyBingName];
            [_dataArray addObject:md.junYao];//君药
           
            [_dataArray addObject:md.xqDingYi];
            [_dataArray addObject:md.xqBingYin];
            [_dataArray addObject:md.xqLinChuang];
            [_dataArray addObject:md.xqZhenDuan];
           
            [_dataArray addObject:md.xqChangGui];
             [_dataArray addObject:md.xqJianBie];
            self.title=md.xqBingName;
            [_tableView reloadData];
            
        }else{
            [LCProgressHUD showMessage:[dic objectForKey:@"msg"]];
        }
    } error:^(NSError *error) {
         [LCProgressHUD showMessage:@"查询失败"];
    }];
    
    _titleArray=@[@"病名",@"中医病名",@"君臣佐使",@"定义",@"病因病机",@"临床表现",@"诊断",@"鉴别诊断",@"常规治疗"];
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
    return _dataArray.count;;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BingMingXiangQingCell * cell =[BingMingXiangQingCell cellWithTableView:tableView IndexPath:indexPath];
    cell.titleLabel.text=_titleArray[indexPath.row];
    if (indexPath.row==4) {
        cell.text=_dataArray[indexPath.row];
    }else{
        cell.text1=_dataArray[indexPath.row];
    }
    if (indexPath.row==2) {
        cell.junLabel.hidden=NO;
        cell.chenLabel.hidden=NO;
        cell.zuoLabel.hidden=NO;
        cell.shiLabel.hidden=NO;
        
        [self juYaoCell:cell];
        [self chenCell:cell];
        [self zuoYaoCell:cell];
        [self shiYaoCell:cell];
    
    }
    return cell;
}

//君药
-(void)juYaoCell:(BingMingXiangQingCell*)cell{
    NSString * label_text2 =[NSString stringWithFormat:@"【君药】%@",[_junYaoArray componentsJoinedByString:@"、"]];
    
//    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
//    [paragraphStyle setLineSpacing:1];
//    NSDictionary *attribs = @{NSParagraphStyleAttributeName: paragraphStyle};
    
    
    NSMutableAttributedString *attributedString2 = [[NSMutableAttributedString alloc]initWithString:label_text2];

     [attributedString2 addAttribute:NSForegroundColorAttributeName value:JXColor(153, 153, 153, 1) range:NSMakeRange(0, 4)];
     [attributedString2 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0, label_text2.length)];
  
    cell.junLabel.attributedText=attributedString2;
    [ cell.junLabel yb_addAttributeTapActionWithStrings:_junYaoArray tapClicked:^(NSString *string, NSRange range, NSInteger index) {
        NSLog(@"君药>>>%@",string);
        MedicineXiangQingVC * vc =[MedicineXiangQingVC new];
        vc.yaoID=_junYaoArrayID[index];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    cell.junLabel.enabledTapEffect = NO;
}
//臣药
-(void)chenCell:(BingMingXiangQingCell*)cell{
    NSString * label_text2 =[NSString stringWithFormat:@"【臣药】%@",[_chenYaoArray componentsJoinedByString:@"、"]];
    NSMutableAttributedString *attributedString2 = [[NSMutableAttributedString alloc]initWithString:label_text2];
    [attributedString2 addAttribute:NSForegroundColorAttributeName value:JXColor(153, 153, 153, 1) range:NSMakeRange(0, 4)];
    [attributedString2 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0, label_text2.length)];
    cell.chenLabel.attributedText=attributedString2;
    [ cell.chenLabel yb_addAttributeTapActionWithStrings:_chenYaoArray tapClicked:^(NSString *string, NSRange range, NSInteger index) {
        NSLog(@"臣药>>>%@",string);
        
        MedicineXiangQingVC * vc =[MedicineXiangQingVC new];
        vc.yaoID=_chenYaoArrayID[index];
        [self.navigationController pushViewController:vc animated:YES];
        
    }];
    cell.chenLabel.enabledTapEffect = NO;
}
//佐药
-(void)zuoYaoCell:(BingMingXiangQingCell*)cell{
    NSString * label_text2 =[NSString stringWithFormat:@"【佐药】%@",[_zuoYaoArray componentsJoinedByString:@"、"]];
    NSMutableAttributedString *attributedString2 = [[NSMutableAttributedString alloc]initWithString:label_text2];
      [attributedString2 addAttribute:NSForegroundColorAttributeName value:JXColor(153, 153, 153, 1) range:NSMakeRange(0, 4)];
    [attributedString2 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0, label_text2.length)];
    cell.zuoLabel.attributedText=attributedString2;
    [ cell.zuoLabel yb_addAttributeTapActionWithStrings:_zuoYaoArray tapClicked:^(NSString *string, NSRange range, NSInteger index) {
        NSLog(@"佐药>>>%@",string);
        MedicineXiangQingVC * vc =[MedicineXiangQingVC new];
        vc.yaoID=_zuoYaoArrayID[index];
        [self.navigationController pushViewController:vc animated:YES];
    }];
     cell.zuoLabel.enabledTapEffect = NO;
}
//使药
-(void)shiYaoCell:(BingMingXiangQingCell*)cell{
    NSString * label_text2 =[NSString stringWithFormat:@"【使药】%@",[_shiYaoArray componentsJoinedByString:@"、"]];
    NSMutableAttributedString *attributedString2 = [[NSMutableAttributedString alloc]initWithString:label_text2];
      [attributedString2 addAttribute:NSForegroundColorAttributeName value:JXColor(153, 153, 153, 1) range:NSMakeRange(0, 4)];
    [attributedString2 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0, label_text2.length)];
    cell.shiLabel.attributedText=attributedString2;
    [ cell.shiLabel yb_addAttributeTapActionWithStrings:_shiYaoArray tapClicked:^(NSString *string, NSRange range, NSInteger index) {
        NSLog(@"使药>>>%@",string);
        MedicineXiangQingVC * vc =[MedicineXiangQingVC new];
        vc.yaoID=_shiYaoArrayID[index];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    cell.shiLabel.enabledTapEffect = NO;
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * str =_dataArray[indexPath.row];
    
    
    if (indexPath.row==2) {
        
      NSString * label_text1 =[NSString stringWithFormat:@"【使药】%@",[_junYaoArray componentsJoinedByString:@"、"]];
      NSString * label_text2 =[NSString stringWithFormat:@"【使药】%@",[_chenYaoArray componentsJoinedByString:@"、"]];
    NSString * label_text3 =[NSString stringWithFormat:@"【使药】%@",[_zuoYaoArray componentsJoinedByString:@"、"]];
    NSString * label_text4 =[NSString stringWithFormat:@"【使药】%@",[_shiYaoArray componentsJoinedByString:@"、"]];
        
        CGFloat g1 =[ToolClass HeightForText:label_text1 withSizeOfLabelFont:15 withWidthOfContent:ScreenWidth-30];
        CGFloat g2 =[ToolClass HeightForText:label_text2 withSizeOfLabelFont:15 withWidthOfContent:ScreenWidth-30];
        CGFloat g3 =[ToolClass HeightForText:label_text3 withSizeOfLabelFont:15 withWidthOfContent:ScreenWidth-30];
        CGFloat g4 =[ToolClass HeightForText:label_text4 withSizeOfLabelFont:15 withWidthOfContent:ScreenWidth-30];
        
         CGFloat g11 =[self isPanDuanHeight:g1];
         CGFloat g22 =[self isPanDuanHeight:g2];
         CGFloat g33 =[self isPanDuanHeight:g3];
         CGFloat g44 =[self isPanDuanHeight:g4];
        
//        NSLog(@"高度>>%f>>>%f>>%f>>%f",g1,g2,g3,g4);
//        
//       NSLog(@"过滤后高度>>%f>>>%f>>%f>>%f",g11,g22,g33,g44);
        return g11+g22+g33+g44+35;
    }else{
      return  [_tableView cellHeightForIndexPath:indexPath model:str keyPath:@"text" cellClass:[BingMingXiangQingCell class] contentViewWidth:[ToolClass  cellContentViewWith]]+10;
    }
    
}

-(CGFloat)isPanDuanHeight:(CGFloat)idd{
    CGFloat flat=0;
    
    if (idd<20) {
        flat=30;
    }else{
        flat=idd;
    }
    
    return flat;
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
