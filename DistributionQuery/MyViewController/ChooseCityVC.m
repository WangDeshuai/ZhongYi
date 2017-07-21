//
//  ChooseCityVC.m
//  DistributionQuery
//
//  Created by Macx on 17/5/19.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import "ChooseCityVC.h"
#import "CityModel.h"
@interface ChooseCityVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tableView;//最左边的表
@property(nonatomic,strong)UITableView * centerTableView;//中间边的表
@property(nonatomic,strong)UITableView * rightTableView;//最右边的表


@property(nonatomic,strong)NSMutableArray * dataArray1;
@property(nonatomic,strong)NSMutableArray * dataArray2;
@property(nonatomic,strong)NSMutableArray * dataArray3;

////用来记录省市县的,block的时候容易传回去
@property(nonatomic,copy)NSString * shengName;
@property(nonatomic,copy)NSString * shiName;
@end

@implementation ChooseCityVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"地区选择";
    _dataArray1=[NSMutableArray new];
    _dataArray2=[NSMutableArray new];
    _dataArray3=[NSMutableArray new];
    [self jieXiSheng];
    [self CreatTabelView];
}



#pragma mark --解析省
-(void)jieXiSheng{
    [Engine1 shengShiXianDiQu:@"1" success:^(NSDictionary *dic) {
        NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
        if ([code isEqualToString:@"200"]) {
            NSArray * dataArr =[dic objectForKey:@"data"];
            for (NSDictionary * dicc in dataArr) {
                CityModel * md =[[CityModel alloc]initWithShengDic:dicc];
                [_dataArray1 addObject:md];
            }
            [_tableView reloadData];
        }else{
            [LCProgressHUD showMessage:[dic objectForKey:@"msg"]];
        }
    } error:^(NSError *error) {
        
    }];
}


#pragma mark --根据省解析市
-(void)jieXiCityID:(NSString*)idd{
    [Engine1 CityID:idd success:^(NSDictionary *dic) {
        NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
        if ([code isEqualToString:@"200"]) {
            NSArray * dataArr =[dic objectForKey:@"data"];
            for (NSDictionary * dicc in dataArr) {
                CityModel * md =[[CityModel alloc]initWithCityDic:dicc];
                [_dataArray2 addObject:md];
            }
            
            [_centerTableView reloadData];
        }else{
            [LCProgressHUD showMessage:[dic objectForKey:@"msg"]];
        }
    } error:^(NSError *error) {
        
    }];
}

#pragma mark --根据市解析县
-(void)jieXiXianID:(NSString*)idd{
    [Engine1 shengShiXianDiQu:idd success:^(NSDictionary *dic) {
        NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
        if ([code isEqualToString:@"200"]) {
            NSArray * dataArr =[dic objectForKey:@"data"];
            for (NSDictionary * dicc in dataArr) {
                CityModel * md =[[CityModel alloc]initWithXianDic:dicc];
                [_dataArray3 addObject:md];
            }
            [_rightTableView reloadData];
        }else{
            [LCProgressHUD showMessage:[dic objectForKey:@"msg"]];
        }
    } error:^(NSError *error) {
        
    }];
}



#pragma mark --创建最左边的表格
-(void)CreatTabelView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth/3, ScreenHeight) style:UITableViewStylePlain];
    }
    _tableView.dataSource=self;
    _tableView.delegate=self;
    _tableView.backgroundColor=BG_COLOR;
    _tableView.tableFooterView=[UIView new];
    [self.view addSubview:_tableView];
    
}
#pragma mark --创建中间的表格
-(void)CreatCenterTabelView{
    [_centerTableView removeFromSuperview];
    _centerTableView=nil;
    if (!_centerTableView) {
        _centerTableView=[[UITableView alloc]initWithFrame:CGRectMake(ScreenWidth/3, 0, ScreenWidth/3, ScreenHeight-64) style:UITableViewStylePlain];
    }
    _centerTableView.dataSource=self;
    _centerTableView.delegate=self;
    _centerTableView.backgroundColor=BG_COLOR;
    _centerTableView.tableFooterView=[UIView new];
    [self.view addSubview:_centerTableView];
    
}

#pragma mark --创建最右边的表格
-(void)CreatRightTableView{
    [_rightTableView removeFromSuperview];
    _rightTableView=nil;
    if (!_rightTableView) {
        _rightTableView=[[UITableView alloc]initWithFrame:CGRectMake(ScreenWidth/3*2, 0, ScreenWidth/3, ScreenHeight-64) style:UITableViewStylePlain];
    }
    _rightTableView.dataSource=self;
    _rightTableView.delegate=self;
    _rightTableView.backgroundColor=BG_COLOR;
    _rightTableView.tableFooterView=[UIView new];
    [self.view addSubview:_rightTableView];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    
    if (tableView==_tableView) {
        return _dataArray1.count;
    }else if (tableView==_centerTableView){
        return _dataArray2.count;
    }else{
        return _dataArray3.count;
    }
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        UILabel * nameLabel =[UILabel new];
        nameLabel.tag=1;
        [cell sd_addSubviews:@[nameLabel]];
    }
    UILabel * nameLabel =[cell viewWithTag:1];
    nameLabel.font=[UIFont systemFontOfSize:15];
    nameLabel.alpha=.7;
    nameLabel.sd_layout
    .centerXEqualToView(cell)
    .centerYEqualToView(cell)
    .heightIs(20);
    [nameLabel setSingleLineAutoResizeWithMaxWidth:220];
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    if (tableView==_tableView) {
        CityModel * md =_dataArray1[indexPath.row];
        nameLabel.text=md.shengName;
    }else if (tableView==_centerTableView){
         CityModel * md =_dataArray2[indexPath.row];
         nameLabel.text=md.cityName;
    }else{
         cell.accessoryType=UITableViewCellAccessoryNone;
        CityModel * md =_dataArray3[indexPath.row];
        nameLabel.text=md.xianName;
    }
    
    
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==_tableView) {
        //点击第一列的时候移除，第三列
        [_rightTableView removeFromSuperview];
        [self CreatCenterTabelView];
        [_dataArray2 removeAllObjects];
        CityModel * md=_dataArray1[indexPath.row];
        _shengName=md.shengName;
        [self jieXiCityID:md.shengID];
    }else if (tableView==_centerTableView){
        [self CreatRightTableView];
        [_dataArray3 removeAllObjects];
         CityModel * md=_dataArray2[indexPath.row];
        _shiName=md.cityName;
        [self jieXiXianID:md.cityID];
    }else{
         CityModel * md=_dataArray3[indexPath.row];
         NSLog(@"shengName%@,cityName%@,xianName%@",_shengName,_shiName,md.xianName);
        [LCProgressHUD showLoading:@"请稍后..."];
        [Engine1 myZhuYeSaveMessageCanShuName:@"address_code" ValueName:md.xianCode  success:^(NSDictionary *dic) {
            NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
            if ([code isEqualToString:@"200"]) {
                [LCProgressHUD hide];
                NSDictionary * data =[dic objectForKey:@"data"];
                [ToolClass savePlist:[ToolClass isDictionary:data] name:@"Login"];
                self.CityNameBlock(_shengName,_shiName,md.xianName,md.xianCode);
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
