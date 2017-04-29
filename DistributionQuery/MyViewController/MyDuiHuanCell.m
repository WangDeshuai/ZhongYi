//
//  MyDuiHuanCell.m
//  DistributionQuery
//
//  Created by Macx on 17/4/29.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import "MyDuiHuanCell.h"
@interface MyDuiHuanCell()
@property(nonatomic,strong)UIImageView * bgimage;
@property(nonatomic,strong)UILabel * titleLable;
@property(nonatomic,strong)UIButton * duihuanBtn;
@property(nonatomic,strong)UILabel * contentLabel;
@end
@implementation MyDuiHuanCell
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self CreatLabel];
    }
    return self;
}
-(void)CreatLabel{
    _bgimage=[UIImageView new];
    _titleLable=[UILabel new];
    _duihuanBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _contentLabel=[UILabel new];
    [self.contentView sd_addSubviews:@[_bgimage,_titleLable,_duihuanBtn,_contentLabel]];
    
    _titleLable.font=[UIFont systemFontOfSize:16];
    _titleLable.alpha=.6;
    _titleLable.textAlignment=0;
    _contentLabel.font=[UIFont systemFontOfSize:13];
    _contentLabel.alpha=.5;
    _contentLabel.textAlignment=0;
    _contentLabel.numberOfLines=2;
    
    [_duihuanBtn setTitle:@"立即兑换" forState:0];
    _duihuanBtn.titleLabel.font=[UIFont systemFontOfSize:13];
    [_duihuanBtn setTitleColor:MAIN_COLOR forState:0];
    _duihuanBtn.sd_cornerRadius=@(10);
    
    
    _bgimage.image=[UIImage imageNamed:@"dh_pic"];
    _titleLable.text=@"中草药书籍";
    _contentLabel.text=@"中草药书籍全名中草药全图鉴定江苏凤凰科学技术";
    
//    _titleLable.backgroundColor=[UIColor redColor];
//    _contentLabel.backgroundColor=[UIColor greenColor];
    
    _bgimage.sd_layout
    .leftSpaceToView(self.contentView,0)
    .topSpaceToView(self.contentView,0)
    .rightSpaceToView(self.contentView,0)
    .heightEqualToWidth();
    
    _duihuanBtn.sd_layout
    .rightSpaceToView(self.contentView,5)
    .topSpaceToView(_bgimage,0)
    .widthIs(70)
    .heightIs(15);
    
    _titleLable.sd_layout
    .leftSpaceToView(self.contentView,5)
    .centerYEqualToView(_duihuanBtn)
    .rightSpaceToView(_duihuanBtn,5)
    .heightIs(15);
    
    _contentLabel.sd_layout
    .leftEqualToView(_titleLable)
    .rightSpaceToView(self.contentView,0)
    .topSpaceToView(_titleLable,5)
    .bottomSpaceToView(self.contentView,5);
    
}
@end
