//
//  YiJianFanKuiVC.m
//  DistributionQuery
//
//  Created by Macx on 17/4/30.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import "YiJianFanKuiVC.h"

@interface YiJianFanKuiVC ()
@property(nonatomic,strong)UITextView * textview;
@end

@implementation YiJianFanKuiVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"意见反馈";
    [self CreatView];
}
-(void)CreatView{
    UIView * view1 =[UIView new];
    view1.backgroundColor=[UIColor whiteColor];
    [self.view sd_addSubviews:@[view1]];
    view1.sd_layout
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .topSpaceToView(self.view,5)
    .heightIs(150);
    
    _textview=[UITextView new];
    _textview.text=@"请输入反馈内容";
    _textview.font=[UIFont systemFontOfSize:14];
    _textview.alpha=.7;
    [view1 sd_addSubviews:@[_textview]];
    _textview.sd_layout
    .leftSpaceToView(view1,15)
    .rightSpaceToView(view1,15)
    .topSpaceToView(view1,10)
    .heightIs(120);
    
    [view1 setupAutoHeightWithBottomView:_textview bottomMargin:15];
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
