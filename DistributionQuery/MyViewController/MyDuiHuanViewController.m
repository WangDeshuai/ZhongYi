//
//  MyDuiHuanViewController.m
//  DistributionQuery
//
//  Created by Macx on 17/4/29.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import "MyDuiHuanViewController.h"
#import "MyDuiHuanCell.h"
@interface MyDuiHuanViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property(nonatomic,strong)UICollectionView *collectionView;
@end

@implementation MyDuiHuanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"我要兑换";
    [self CreatCollectionView];
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
    
    
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 10;
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MyDuiHuanCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    //  cell.backgroundColor = [UIColor whiteColor];
    //    cell.image1.image=[UIImage imageNamed:@"pic"];
    //    cell.lab.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    
    cell.backgroundColor=[UIColor whiteColor];
    return cell;
    
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
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
