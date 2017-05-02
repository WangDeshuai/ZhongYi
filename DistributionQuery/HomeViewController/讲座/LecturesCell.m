//
//  LecturesCell.m
//  DistributionQuery
//
//  Created by Macx on 17/4/24.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import "LecturesCell.h"
@interface LecturesCell()
@property(nonatomic,strong)UIImageView * imageview;
@property(nonatomic,strong)UILabel * titleLable;
@property(nonatomic,strong)UILabel * timeLabel;
@end
@implementation LecturesCell
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _imageview=[UIImageView new];
        _titleLable=[UILabel new];
        _timeLabel=[UILabel new];
        [self.contentView sd_addSubviews:@[_imageview,_titleLable,_timeLabel]];
       //属性
        _titleLable.font=[UIFont systemFontOfSize:15];
        _titleLable.alpha=.7;
        _timeLabel.font=[UIFont systemFontOfSize:15];
        _timeLabel.alpha=.7;
        
//        _titleLable.backgroundColor=[UIColor magentaColor];
//        _timeLabel.backgroundColor=[UIColor yellowColor];
        
        //赋值
         _imageview.image=[UIImage imageNamed:@"jz_pic"];
         _titleLable.text=@"王伟--治疗肺癌有效方法";
         _timeLabel.text=@"2016-11-12";
        
        
        _imageview.sd_layout
        .leftSpaceToView(self.contentView,0)
        .rightSpaceToView(self.contentView,0)
        .topSpaceToView(self.contentView,0)
        .heightIs(self.frame.size.height-40);
       
        _timeLabel.sd_layout
        .leftSpaceToView(self.contentView,0)
        .rightSpaceToView(self.contentView,0)
        .bottomSpaceToView(self.contentView,0)
        .heightIs(20);
        
        _titleLable.sd_layout
        .leftSpaceToView(self.contentView,0)
        .rightSpaceToView(self.contentView,0)
        .heightIs(20)
        .topSpaceToView(_imageview,0);
        
        
        
        
    }
    return self;
}

@end
