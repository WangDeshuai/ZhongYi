//
//  MyShouCangVC.m
//  DistributionQuery
//
//  Created by Macx on 17/4/25.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import "MyShouCangVC.h"
#import "MyShouCangCell.h"
@interface MyShouCangVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSArray * imageArr;
@end

@implementation MyShouCangVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"我的收藏";
    [self CreatArr];
    [self CreatTabelView];
}

-(void)CreatArr{
    _imageArr=@[@"sc_bing",@"sc_jz",@"sc_ya",@"sc_yao"];
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
    _tableView.rowHeight=70;
    [self.view sd_addSubviews:@[_tableView]];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _imageArr.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
      MyShouCangCell * cell =[MyShouCangCell cellWithTableView:tableView CellID:[NSString stringWithFormat:@"%lu%lu",indexPath.row,indexPath.section]];
    cell.imageview.image=[UIImage imageNamed:_imageArr[indexPath.row]];
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
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
