//
//  ReuserView.m
//  DistributionQuery
//
//  Created by Macx on 17/4/24.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import "ReuserView.h"

@implementation ReuserView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIView * linView =[UIView new];
        linView.backgroundColor=JXColor(245, 3, 3, 1);
        [self sd_addSubviews:@[linView]];
        linView.sd_layout
        .leftSpaceToView(self,15)
        .topSpaceToView(self,5)
        .bottomSpaceToView(self,5)
        .widthIs(2);
        
        _nameLable =[UILabel new];
        _nameLable.text=@"更多讲座视频";
        _nameLable.textColor=JXColor(245, 3, 3, 1);
        _nameLable.font=[UIFont systemFontOfSize:16];
        [self sd_addSubviews:@[_nameLable]];
        _nameLable.sd_layout
        .leftSpaceToView(linView,15)
        .centerYEqualToView(self)
        .heightIs(25);
        [_nameLable setSingleLineAutoResizeWithMaxWidth:200];
        
        
    }
    return self;
}

@end
