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
@interface MoreVideoVC ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property(nonatomic,retain)UICollectionView *collectionView;

@end

@implementation MoreVideoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"更多视频";
    [self CreatCollectionView];
}
-(void)CreatCollectionView{
    
    UICollectionViewFlowLayout * flowLawyou =[UICollectionViewFlowLayout new];
    //item大小
    flowLawyou.itemSize = CGSizeMake((ScreenWidth-30)/2, (ScreenWidth-30)/2.5);
    flowLawyou.minimumLineSpacing=20;//行间距
    flowLawyou.minimumInteritemSpacing=10;//列间距
    flowLawyou.sectionInset = UIEdgeInsetsMake(10, 10, 56, 10);
    
    _collectionView = [[UICollectionView alloc]initWithFrame:self.view.frame collectionViewLayout:flowLawyou];
    _collectionView.pagingEnabled = NO;
    _collectionView.delegate = self;
    
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_collectionView];
    [_collectionView registerClass:[LecturesCell class] forCellWithReuseIdentifier:@"cell"];
    [self.collectionView registerClass:[ReuserView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headView"];
    
    
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
    
    return 10;
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    LecturesCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    //  cell.backgroundColor = [UIColor whiteColor];
    //    cell.image1.image=[UIImage imageNamed:@"pic"];
    //    cell.lab.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    
    cell.backgroundColor=[UIColor redColor];
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
