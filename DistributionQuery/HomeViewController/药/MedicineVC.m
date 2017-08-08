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
#import "YuYinView.h"
#import "UITextField+ExtentRange.h"
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
    [LCProgressHUD showLoading:@"请稍后..."];
    [Engine1 allYaoPinMessage:zifu success:^(NSDictionary *dic) {
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
                [dexArr addObject:md.yaoDexName];
                [titleArr addObject:md.yaoTitleName];
                [imageArr addObject:md.yaoImageName];
                [iddArr addObject:md.yaoID];
            }
            
            _rightIndexArr=[ChineseString IndexArray:dexArr];//索引
            _dexcontentArr=[ChineseString LetterSortArray:dexArr NsArr:_dataArray];//拼音(以它为准)
            
           
           
//            for (NSString * mdd in arr) {
//                NSLog(@">>>%@",mdd);
//            }
//            _contentArr=[ChineseString LetterSortArray:titleArr];//标题
//            
//            _imageArr=[ChineseString LetterSortArray2:imageArr];//图片(注意去掉前缀)//LetterSortArray2是去掉过滤符号了
//            _contentIDArr=[ChineseString LetterSortArray2:iddArr];//ID(注意去前缀)
//            NSLog(@">>>%lu>>>%lu>>>%lu>>>>%lu",_dexcontentArr.count,_contentArr.count,_imageArr.count,_contentIDArr.count);
//            NSArray * a =_dexcontentArr[0];
//            for (NSString * str in a) {
//                NSLog(@"拼音>>>%@",str);
//            }
////            
//            for (NSString * str in _contentArr) {
//                NSLog(@"全部标题>>>%@",str);
//            }

            
//            //不知道为什么，特么 百合 和壁虎位置不对，，，（图片，和拼音的不对），需要调换
//            NSMutableArray *pinyin =_contentArr[1];
//            int j = 0;
//            for (int i =0; i<pinyin.count; i++) {
//                NSString * str =pinyin[i];
//                if ([str isEqualToString:@"百合"]) {
//                   // NSLog(@"输出百合的i=%d",i);
//                    j=i;
//                }
//                if ([str isEqualToString:@"壁虎"]) {
//                    // NSLog(@"输出壁虎的i=%d",i);
//                    if (j<i) {
//                         [pinyin exchangeObjectAtIndex:j withObjectAtIndex:i];
//                    }
//                }
//
//            
//            }
//           
//            NSMutableArray *iddAray =_contentIDArr[1];
//            int jj = 0;
//            for (int ii =0; ii<iddAray.count; ii++) {
//                NSString * str =iddAray[ii];
//                
//                if ([str isEqualToString:@"百合129"]) {
//                    NSLog(@"输出百合的i=%d",ii);
//                    jj=ii;
//                }
//                
//                if ([str isEqualToString:@"壁虎108"]) {
//                    NSLog(@"输出壁虎的i=%d",ii);
//                    if(jj<ii){
//                        NSLog(@"换了");
//                        [iddAray exchangeObjectAtIndex:jj withObjectAtIndex:ii];
//                    }
//                }
            
                
                
//            }

                        
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
    [yuYinBtn addTarget:self action:@selector(yuYinClink) forControlEvents:UIControlEventTouchUpInside];
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

-(void)yuYinClink{
     [self.view endEditing:YES];
    //语音
    YuYinView * vc =[[YuYinView alloc]init];
    
    //[weakSelf.textView deleteBackward];
    __weak typeof(self) weakSelf = self;
     __weak typeof(vc) weakSelfVC = vc;
    vc.TextBlock=^(NSString*text,BOOL isLast){
        //1.获取光标位置
        NSRange selectedRange = weakSelf.textfield.selectedRange;
        //2.将光标所在位置的的字符串进行替换
        weakSelf.textfield.text = [weakSelf.textfield.text stringByReplacingCharactersInRange:selectedRange withString:text];
        //3.修改光标位置,光标放到新增加的文字的后面
        weakSelf.textfield.selectedRange = NSMakeRange((selectedRange.location + text.length), 0);
        if (isLast==YES) {
            NSLog(@">>>>%@",_textfield.text);
            [weakSelfVC dissmiss];
            [_dataArray removeAllObjects];
            [self dataArrSearZi:_textfield.text];
        }
        
    };
    [vc  show];
}

#pragma mark --搜索按钮
-(void)searchBtnClink{
    [_dataArray removeAllObjects];
    [self dataArrSearZi:_textfield.text];
}
#pragma mark --搜索
-(BOOL)textFieldShouldReturn:(UITextField *)textField

{
    [self.view endEditing:YES];
     [_dataArray removeAllObjects];
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
    return _dexcontentArr.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dexcontentArr[section] count];
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MedicineCell * cell =[MedicineCell cellWithTableView:tableView IndexPath:indexPath];
    
    MedicineModel * md =_dexcontentArr[indexPath.section][indexPath.row];
    [cell.imageview setImageWithURL:[NSURL URLWithString:md.yaoImageName] placeholderImage:[UIImage imageNamed:@"yao_zw"]];
    cell.dexLabel.text=md.yaoDexName;
    cell.titleLabel.text=md.yaoTitleName;
    
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //idd(包涵前缀)
    MedicineModel * md =_dexcontentArr[indexPath.section][indexPath.row];
    MedicineXiangQingVC * vc =[MedicineXiangQingVC new];
    //去掉前缀
    NSLog(@">>>%@",md.yaoID);
    vc.yaoID=md.yaoID;
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
