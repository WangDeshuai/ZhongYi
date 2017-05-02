//
//  HomeTableViewCell.m
//  DistributionQuery
//
//  Created by Macx on 17/5/2.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import "HomeTableViewCell.h"
@interface HomeTableViewCell()
@property(nonatomic,strong)UILabel * titleLable;
@property(nonatomic,strong)UILabel * contentlabel;
@property(nonatomic,strong)UILabel * timelabel;
@property(nonatomic,strong)UILabel * namelabel;
@end
@implementation HomeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
+(instancetype)cellWithTableView:(UITableView*)tableView IndexPath:(NSIndexPath *)indexPath{
    NSString * cellID =[NSString stringWithFormat:@"%lu%lu",(long)indexPath.section,(long)indexPath.row];
    HomeTableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell=[[HomeTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self CreatStar];
    }
    return self;
}
-(void)CreatStar{
    _titleLable=[UILabel new];
    _contentlabel=[UILabel new];
    _timelabel=[UILabel new];
    _namelabel=[UILabel new];
    [self.contentView sd_addSubviews:@[_titleLable,_contentlabel,_timelabel,_namelabel]];
    _titleLable.font=[UIFont systemFontOfSize:16];
    _titleLable.alpha=.7;
    _titleLable.numberOfLines=0;
    _titleLable.textColor=MAIN_COLOR;
    _contentlabel.font=[UIFont systemFontOfSize:15];
    _contentlabel.alpha=.6;
    _contentlabel.numberOfLines=0;
    _timelabel.font=[UIFont systemFontOfSize:14];
    _timelabel.textAlignment=0;
    _timelabel.alpha=.5;
    _namelabel.alpha=.5;
    _namelabel.font=[UIFont systemFontOfSize:14];
    _namelabel.textAlignment=2;
    
    _titleLable.text=@"更年期综合征";
    _contentlabel.text=@"病案详情:异常汗出4月，情绪容易激动，脾气暴躁，情绪容易激动，脾气暴躁，";
    _timelabel.text=@"2017-03-11";
    _namelabel.text=@"王璇";
    
    _titleLable.sd_layout
    .leftSpaceToView(self.contentView,15)
    .topSpaceToView(self.contentView,10)
    .heightIs(20);
    [_titleLable setSingleLineAutoResizeWithMaxWidth:200];
    
    _contentlabel.sd_layout
    .leftEqualToView(_titleLable)
    .rightSpaceToView(self.contentView,15)
    .topSpaceToView(_titleLable,10)
    .heightIs(20);
    
    _timelabel.sd_layout
    .leftEqualToView(_titleLable)
    .topSpaceToView(_contentlabel,10)
    .heightRatioToView(_titleLable,1);
    [_timelabel setSingleLineAutoResizeWithMaxWidth:220];
    
    _namelabel.sd_layout
    .rightSpaceToView(self.contentView,15)
    .centerYEqualToView(_timelabel)
    .heightIs(20);
    [_namelabel setSingleLineAutoResizeWithMaxWidth:220];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
