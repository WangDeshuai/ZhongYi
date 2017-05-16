//
//  MoreVideoVC.m
//  DistributionQuery
//
//  Created by Macx on 17/4/24.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import "MoreVideoVC.h"
#import "LecturesCell.h"
#import "ReuserView.h"
#import "LecturesModel.h"
@interface MoreVideoVC ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property(nonatomic,retain)UICollectionView *collectionView;

@property(nonatomic,strong)NSMutableArray * dataArray;
@property(nonatomic,assign)int AAA;
@property (nonatomic,strong) MJRefreshComponent *myRefreshView;


@end

@implementation MoreVideoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"更多视频";
    [self CreatCollectionView];
}

-(void)CreatDataPage:(int)page{
    
    [Engine jiaZaiJiangZuoAllMessagePage:[NSString stringWithFormat:@"%d",page] success:^(NSDictionary *dic) {
        NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
        NSMutableArray * array2 =[NSMutableArray new];
        if ([code isEqualToString:@"200"]) {
            NSArray * dataArr =[dic objectForKey:@"data"];
            for (NSDictionary * dicc in dataArr) {
                LecturesModel * md =[[LecturesModel alloc]initWithJiangZuoDic:dicc];
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





-(void)CreatCollectionView{
    
    UICollectionViewFlowLayout * flowLawyou =[UICollectionViewFlowLayout new];
    //item大小
    flowLawyou.itemSize = CGSizeMake((ScreenWidth-30)/2, (ScreenWidth-30)/2.5);
    flowLawyou.minimumLineSpacing=20;//行间距
    flowLawyou.minimumInteritemSpacing=10;//列间距
    flowLawyou.sectionInset = UIEdgeInsetsMake(10, 10, 56, 10);
    
    if ([ToolClass isiPad]) {
        flowLawyou.minimumInteritemSpacing=15;//列间距
        flowLawyou.minimumLineSpacing=20;//行间距
        flowLawyou.sectionInset = UIEdgeInsetsMake(10, 10, 56, 10);
        flowLawyou.itemSize = CGSizeMake((ScreenWidth-20*4)/3, (ScreenWidth-20)/3.5);
        
    }
    
    _collectionView = [[UICollectionView alloc]initWithFrame:self.view.frame collectionViewLayout:flowLawyou];
    _collectionView.pagingEnabled = NO;
    _collectionView.delegate = self;
    
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_collectionView];
    [_collectionView registerClass:[LecturesCell class] forCellWithReuseIdentifier:@"cell"];
    [self.collectionView registerClass:[ReuserView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headView"];
    
    
    __weak typeof (self) weakSelf =self;
    _collectionView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.myRefreshView = weakSelf.collectionView.header;
        _AAA=1;
        [self CreatDataPage:_AAA];
        
    }];
    
    [_collectionView.header beginRefreshing];
    //..上拉刷新
    _collectionView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        weakSelf.myRefreshView = weakSelf.collectionView.footer;
        _AAA=_AAA+1;
         [self CreatDataPage:_AAA];;
    }];
    
    _collectionView.footer.hidden = YES;

    
    
    
    
    
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (kind == UICollectionElementKindSectionHeader) {
        ReuserView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headView" forIndexPath:indexPath];
        header.backgroundColor=[UIColor whiteColor];
        return header;
        
    }else
    {
        return nil;
    }
}
//区头大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    return CGSizeMake(ScreenWidth, 50);
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _dataArray.count;
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    LecturesCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    //  cell.backgroundColor = [UIColor whiteColor];
    //    cell.image1.image=[UIImage imageNamed:@"pic"];
    //    cell.lab.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    cell.model=_dataArray[indexPath.row];
    cell.backgroundColor=[UIColor whiteColor];
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
