//
//  LecturesVC.m
//  DistributionQuery
//
//  Created by Macx on 17/4/24.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import "LecturesVC.h"
#import "LecturesCell.h"
#import "MoreVideoVC.h"//更多
#import "JiangZuoXiangQingVC.h"//讲座详情页
#import "YaoFangModel.h"
#import "LecturesModel.h"
@interface LecturesVC ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property(nonatomic,strong)UICollectionView *collectionView;
@property(nonatomic,strong)UIButton * lastBtn;
@property(nonatomic,strong)NSMutableArray * dataArray1;
@property(nonatomic,strong)NSMutableArray * classID;
@property(nonatomic,copy)NSString * bingMingID;
@property(nonatomic,strong)NSMutableArray * dataArray;
@property(nonatomic,assign)int AAA;
@property(nonatomic,assign)int rectHeight;
@property (nonatomic,strong) MJRefreshComponent *myRefreshView;

@end

@implementation LecturesVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"讲座";
    _dataArray1=[NSMutableArray new];
    _classID=[NSMutableArray new];
    _dataArray=[NSMutableArray new];
    _bingMingID=@"1";
    [self searchView];
    [self CreatCollectionView];
    [self CreatBtn];
}

-(void)CreatDataPage:(int)page BingID:(NSString*)bingID {
  
    NSLog(@">>>>%d>>>>%@",page,bingID);
    [Engine1 jiangZuoBingZhongID:bingID Page:[NSString stringWithFormat:@"%d",page] PageSize:@"10" success:^(NSDictionary *dic) {
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

-(void)chaXunAllPage:(int)page{
    [Engine1 jiaZaiJiangZuoAllMessagePage:[NSString stringWithFormat:@"%d",page] success:^(NSDictionary *dic) {
        
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

#pragma mark --创建搜索按钮
-(void)searchView{
    //搜索按钮
    UIButton * searchBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [searchBtn setTitle:@"搜索" forState:0];
    searchBtn.backgroundColor=BG_COLOR;
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
    textfield.placeholder=@"搜索药";
    textfield.backgroundColor=[UIColor whiteColor];
    textfield.font=[UIFont systemFontOfSize:15];
    textfield.leftView =[ToolClass imageViewNameStr:@"yao_search"];
    textfield.leftViewMode = UITextFieldViewModeAlways;
    textfield.sd_cornerRadius=@(5);
    [self.view sd_addSubviews:@[textfield]];
    textfield.sd_layout
    .leftSpaceToView(self.view,15)
    .rightSpaceToView(searchBtn,0)
    .topSpaceToView(self.view,10)
    .heightIs(35);
    //语音
    UIButton * yuYinBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [yuYinBtn setImage:[UIImage imageNamed:@"yao_yuyin"] forState:0];
    [textfield sd_addSubviews:@[yuYinBtn]];
    yuYinBtn.sd_layout
    .rightSpaceToView(textfield,10)
    .centerYEqualToView(textfield)
    .widthIs(30)
    .heightIs(30);

    
}


#pragma mark --创建若干个按钮
-(void)CreatBtn{
    UIView * headView =[UIView new];
    headView.backgroundColor=BG_COLOR;
    [_collectionView sd_addSubviews:@[headView]];
    headView.sd_layout
    .leftSpaceToView(_collectionView,0)
    .rightSpaceToView(_collectionView,0)
    .topSpaceToView(_collectionView,0)
    .heightIs(400);
    
    //创建选择病名
    UIView * view1=[UIView new];
    view1.backgroundColor=[UIColor whiteColor];
    [headView sd_addSubviews:@[view1]];
    view1.sd_layout
    .leftSpaceToView(headView,0)
    .rightSpaceToView(headView,0)
    .topSpaceToView(headView,0)
    .heightIs(45);
    
    UIView * linView =[UIView new];
    linView.backgroundColor=JXColor(245, 3, 3, 1);
    [view1 sd_addSubviews:@[linView]];
    linView.sd_layout
    .leftSpaceToView(view1,15)
    .heightIs(15)
    .centerYEqualToView(view1)
    .widthIs(2);
    
    UILabel * nameLable =[UILabel new];
    nameLable.text=@"选择病名分类";
    nameLable.textColor=JXColor(245, 3, 3, 1);
    nameLable.font=[UIFont systemFontOfSize:16];
    [view1 sd_addSubviews:@[nameLable]];
    nameLable.sd_layout
    .leftSpaceToView(linView,10)
    .centerYEqualToView(view1)
    .heightIs(25);
    [nameLable setSingleLineAutoResizeWithMaxWidth:200];
    
    //创建若干个按钮view2
    UIView * view2=[UIView new];
    view2.backgroundColor=[UIColor whiteColor];
    [headView sd_addSubviews:@[view2]];
    view2.sd_layout
    .leftSpaceToView(headView,0)
    .rightSpaceToView(headView,0)
    .topSpaceToView(view1,1)
    .heightIs(300);
    
    
    
    [Engine1 jiaZaiBingZhongClasssuccess:^(NSDictionary *dic) {
        NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
        if ([code isEqualToString:@"200"]) {
            NSArray * dataArr =[dic objectForKey:@"data"];
            // NSMutableArray * array =[NSMutableArray new];
            for (NSDictionary * dicc in dataArr) {
                YaoFangModel * md =[[YaoFangModel alloc]initWithYaoClassViewDic:dicc];
                [_dataArray1 addObject:md.yaoFangClass];
                [_classID addObject:md.yaoClassID];
            }
            
            //            NSArray * btnArr=@[@"肺癌",@"胃癌",@"肝癌",@"肾癌",@"胶质量",@"鼻咽癌",@"口腔癌",@"下咽癌",@"乳腺癌",@"食管癌",@"贵门癌",@"大肠癌",@"但脑癌",@"胰腺癌",@"膀胱癌",@"阴茎癌",@"卵巢癌",@"宫颈癌",@"扁桃体癌",@"甲状腺癌",@"前列腺癌",@"黑色素癌",@"恶性淋巴瘤",@"子宫内膜瘤",@"胸膜间皮癌"];
            
            int kj =10;
            int k=(ScreenWidth-kj*4)/3;
            int g=k*52/148-10;
            int gj=15;
            if ([ToolClass isiPad]) {
                kj =25;
                k=(ScreenWidth-kj*5)/4;
                g=k*52/148;
                gj=15;
            }
            
            for (int i=0; i<_dataArray1.count; i++) {
                UIButton * btn =[UIButton buttonWithType:UIButtonTypeCustom];
                btn.sd_cornerRadius=@(15);
                btn.tag=i;
                [btn addTarget:self action:@selector(btnClink:) forControlEvents:UIControlEventTouchUpInside];
                btn.titleLabel.font=[UIFont systemFontOfSize:13];
                
                [btn setTitle:_dataArray1[i] forState:0];
                [btn setTitleColor:[UIColor lightGrayColor] forState:0];
                [btn setBackgroundImage:[UIImage imageNamed:@"btnNomol"] forState:0];
                [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
                [btn setBackgroundImage:[UIImage imageNamed:@"btnSelete"] forState:UIControlStateSelected];
                
                if (i==0) {
                    btn.selected=YES;
                    _lastBtn=btn;
                }
                
                
                [view2 sd_addSubviews:@[btn]];
                btn.sd_layout
                .leftSpaceToView(view2,kj+(k+kj)*(i%3))
                .topSpaceToView(view2,gj+(g+gj)*(i/3))
                .widthIs(k)
                .heightIs(g);
                [view2 setupAutoHeightWithBottomView:btn bottomMargin:20];
                if ([ToolClass isiPad]) {
                    btn.sd_layout
                    .leftSpaceToView(view2,kj+(k+kj)*(i%4))
                    .topSpaceToView(view2,gj+(g+gj)*(i/4))
                    .widthIs(k)
                    .heightIs(g);
                    [view2 setupAutoHeightWithBottomView:btn bottomMargin:20];
                }
                
            }
            
//            [headview setupAutoHeightWithBottomView:view2 bottomMargin:5];
//            headview.didFinishAutoLayoutBlock=^(CGRect rect){
//                NSLog(@"输出%f>>>%f", rect.size.height,rect.origin.y);
//            };
            
            
            
            
        }
    } error:^(NSError *error) {
        
    }];
    
    
   //讲座
    UIView * view3=[UIView new];
    view3.backgroundColor=[UIColor whiteColor];
    [headView sd_addSubviews:@[view3]];
    view3.sd_layout
    .leftSpaceToView(headView,0)
    .rightSpaceToView(headView,0)
    .topSpaceToView(view2,5)
    .heightIs(40);
    UIView * linView2 =[UIView new];
    linView2.backgroundColor=JXColor(245, 3, 3, 1);
    [view3 sd_addSubviews:@[linView2]];
    linView2.sd_layout
    .leftSpaceToView(view3,15)
    .heightIs(15)
    .centerYEqualToView(view3)
    .widthIs(2);
    
    UILabel * nameLable2 =[UILabel new];
    nameLable2.text=@"讲座";
    nameLable2.textColor=JXColor(245, 3, 3, 1);
    nameLable2.font=[UIFont systemFontOfSize:16];
    [view3 sd_addSubviews:@[nameLable2]];
    nameLable2.sd_layout
    .leftSpaceToView(linView,15)
    .centerYEqualToView(view3)
    .heightIs(25);
    [nameLable2 setSingleLineAutoResizeWithMaxWidth:200];
    //更多
    UIButton * moreBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [moreBtn setImage:[UIImage imageNamed:@"jz_arrow_right"] forState:0];
    [moreBtn setTitle:@"更多" forState:0];
    [moreBtn addTarget:self action:@selector(moreBtnClink) forControlEvents:UIControlEventTouchUpInside];
    moreBtn.titleLabel.font=[UIFont systemFontOfSize:15];
    [moreBtn setTitleColor:JXColor(171, 171, 171, 1) forState:0];
//    [view3 sd_addSubviews:@[moreBtn]];
    moreBtn.sd_layout
    .rightSpaceToView(view3,15)
    .centerYEqualToView(nameLable2)
    .widthIs(60)
    .heightIs(30);
    
    // 设置button的图片的约束
    moreBtn.imageView.sd_layout
    .widthIs(8)
    .rightSpaceToView(moreBtn, 5)
    .centerYEqualToView(moreBtn)
    .heightIs(13);
    
    // 设置button的label的约束
    moreBtn.titleLabel.sd_layout
    .centerYEqualToView(moreBtn.imageView)
    .rightSpaceToView(moreBtn.imageView,0)
    .leftSpaceToView(moreBtn,10)
    .heightIs(20);
    
    [headView setupAutoHeightWithBottomView:view3 bottomMargin:0];
 
    
       
    headView.didFinishAutoLayoutBlock=^(CGRect rect){
        NSLog(@"输出%f>>>%f", rect.size.height,rect.origin.y);
    };
}

#pragma mark --点击状态
-(void)btnClink:(UIButton*)button{
    _lastBtn.selected=NO;
    button.selected=YES;
    _lastBtn=button;
    NSLog(@"病种ID=%@",_classID[button.tag]);
    _bingMingID=_classID[button.tag];
    [_dataArray removeAllObjects];
    [_collectionView reloadData];
    _AAA=1;
     [self CreatDataPage:_AAA BingID:_bingMingID];
    
}
#pragma mark --更多视频
-(void)moreBtnClink{
    MoreVideoVC * vc =[MoreVideoVC new];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark --创建collectionView
-(void)CreatCollectionView{
    
    UICollectionViewFlowLayout * flowLawyou =[UICollectionViewFlowLayout new];
    //item大小
    flowLawyou.itemSize = CGSizeMake((ScreenWidth-30)/2, (ScreenWidth-30)/2.5);
    flowLawyou.minimumLineSpacing=20;//行间距
    flowLawyou.minimumInteritemSpacing=10;//列间距
    NSLog(@">>>%d",_rectHeight);
    flowLawyou.sectionInset = UIEdgeInsetsMake(399+20, 10, 56, 10);
    
    if ([ToolClass isiPad]) {
        flowLawyou.minimumInteritemSpacing=15;//列间距
        flowLawyou.minimumLineSpacing=20;//行间距
        flowLawyou.sectionInset = UIEdgeInsetsMake(608+20, 10, 56, 10);
        flowLawyou.itemSize = CGSizeMake((ScreenWidth-20*4)/3, (ScreenWidth-20)/3.5);
        
    }
    
    
    
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0,55, ScreenWidth, ScreenHeight-64-55) collectionViewLayout:flowLawyou];
    _collectionView.pagingEnabled = NO;
    _collectionView.delegate = self;
    
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_collectionView];
    [_collectionView registerClass:[LecturesCell class] forCellWithReuseIdentifier:@"cell"];
    
    __weak typeof (self) weakSelf =self;
    _collectionView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.myRefreshView = weakSelf.collectionView.header;
        _AAA=1;
//        [self CreatDataPage:_AAA BingID:_bingMingID];
        [self chaXunAllPage:_AAA];
    }];
    
    [_collectionView.header beginRefreshing];
    //..上拉刷新
    _collectionView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        weakSelf.myRefreshView = weakSelf.collectionView.footer;
        _AAA=_AAA+1;
//         [self CreatDataPage:_AAA BingID:_bingMingID];
         [self chaXunAllPage:_AAA];
    }];
    
    _collectionView.footer.hidden = YES;
    
    
    
//    [self.collectionView registerClass:[ReuserView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headView"];

   
}
//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
//{
//   
//    
//    if (kind == UICollectionElementKindSectionHeader) {
//        ReuserView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headView" forIndexPath:indexPath];
//        header.backgroundColor=[UIColor greenColor];
//        //header.frame=CGRectMake(0, 200, ScreenWidth, 50);
//        header.nameLable.text=@"讲座";
//        return nil;
//        
//    }else
//    {
//        return nil;
//    }
//}
////区头大小
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
//    
//    return CGSizeMake(ScreenWidth, 50);
//}



- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _dataArray.count;
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    LecturesCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.model=_dataArray[indexPath.row];
    
    cell.backgroundColor=[UIColor whiteColor];
    
    //  cell.backgroundColor = [UIColor whiteColor];
    //    cell.image1.image=[UIImage imageNamed:@"pic"];
    //    cell.lab.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    
    return cell;
    
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    LecturesModel * md =_dataArray[indexPath.row];
    JiangZuoXiangQingVC * vc =[JiangZuoXiangQingVC new];
    vc.messageid=md.jiangZuoID;
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
