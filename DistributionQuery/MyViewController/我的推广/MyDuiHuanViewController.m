//
//  MyDuiHuanViewController.m
//  DistributionQuery
//
//  Created by Macx on 17/4/29.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import "MyDuiHuanViewController.h"
#import "MyDuiHuanCell.h"
#import "MyTuiGuangModel.h"
@interface MyDuiHuanViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property(nonatomic,strong)UICollectionView *collectionView;
@property(nonatomic,strong)NSMutableArray * dataArray;
@property(nonatomic,assign)int AAA;
@property (nonatomic,strong) MJRefreshComponent *myRefreshView;
@end

@implementation MyDuiHuanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"我要兑换";
    [self CreatCollectionView];
}

-(void)dataJieXiePage:(int)page
{
    [Engine shangPinJiaZaiMessage:[NSString stringWithFormat:@"%d",page] success:^(NSDictionary *dic) {
        NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
        if ([code isEqualToString:@"200"]) {
            NSArray * dataArr =[dic objectForKey:@"data"];
            NSMutableArray * array2 =[NSMutableArray new];
            for (NSDictionary * dicc in dataArr) {
                MyTuiGuangModel * md =[[MyTuiGuangModel alloc]initWithDuiHuanDic:dicc];
                [array2 addObject:md];
            }
            
            if (self.myRefreshView ==_collectionView.header) {
                _dataArray=array2;
                _collectionView.footer.hidden=_dataArray.count==0?YES:NO;
            }else if (self.myRefreshView == _collectionView.footer){
                [_dataArray addObjectsFromArray:array2];
            }
            [_collectionView reloadData];
            [_myRefreshView  endRefreshing];
        
        }else{
            [LCProgressHUD showMessage:[dic objectForKey:@"msg"]];
        }
    } error:^(NSError *error) {
        
    }];
    
}




#pragma mark --创建collectionView
-(void)CreatCollectionView{
    
    UICollectionViewFlowLayout * flowLawyou =[UICollectionViewFlowLayout new];
    //item大小
    int k =(ScreenWidth-30)/2;
    int g= k+60;
    flowLawyou.itemSize = CGSizeMake(k, g);
    flowLawyou.minimumLineSpacing=10;//行间距
    flowLawyou.minimumInteritemSpacing=10;//列间距
    flowLawyou.sectionInset = UIEdgeInsetsMake(10, 10, 56, 10);
    
    if ([ToolClass isiPad]) {
        int kk =(ScreenWidth-20*4)/3;
        int gg= kk+60;
        flowLawyou.minimumInteritemSpacing=15;//列间距
        flowLawyou.minimumLineSpacing=20;//行间距
        flowLawyou.sectionInset = UIEdgeInsetsMake(10, 10, 56, 10);
        flowLawyou.itemSize = CGSizeMake(kk, gg);
        
    }
    
    
    
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0,0, ScreenWidth, ScreenHeight-64) collectionViewLayout:flowLawyou];
    _collectionView.pagingEnabled = NO;
    _collectionView.delegate = self;
    
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = BG_COLOR;
    [self.view addSubview:_collectionView];
    [_collectionView registerClass:[MyDuiHuanCell class] forCellWithReuseIdentifier:@"cell"];
    //    [self.collectionView registerClass:[ReuserView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headView"];
    __weak typeof (self) weakSelf =self;
    _collectionView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.myRefreshView = weakSelf.collectionView.header;
        _AAA=1;
        [self dataJieXiePage:_AAA];
    }];
    
    [_collectionView.header beginRefreshing];
    //..上拉刷新
    _collectionView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        weakSelf.myRefreshView = weakSelf.collectionView.footer;
        _AAA=_AAA+1;
          [self dataJieXiePage:_AAA];
    }];
    
    _collectionView.footer.hidden = YES;
    
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _dataArray.count;
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MyDuiHuanCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    //  cell.backgroundColor = [UIColor whiteColor];
    //    cell.image1.image=[UIImage imageNamed:@"pic"];
    //    cell.lab.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    
    cell.backgroundColor=[UIColor whiteColor];
    cell.model=_dataArray[indexPath.row];
    return cell;
    
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UIAlertController * actionview=[UIAlertController alertControllerWithTitle:@"立即兑换" message:@"兑换详情请拨打\n客服电话400-4125-406" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * action =[UIAlertAction actionWithTitle:@"兑换" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [ToolClass tellPhone:@"400-4125-406"];
    }];
    UIAlertAction * action2 =[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
   
    [actionview addAction:action2];
     [actionview addAction:action];
    [self presentViewController:actionview animated:YES completion:nil];
    
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
