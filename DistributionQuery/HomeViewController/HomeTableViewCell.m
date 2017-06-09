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
    //748839425
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
    [self.contentView sd_addSubviews:@[_titleLable,_contentlabel,_timelabel]];
    _titleLable.font=[UIFont systemFontOfSize:16];
    _titleLable.alpha=.7;
    _titleLable.numberOfLines=0;
    _titleLable.textColor=MAIN_COLOR;
    _contentlabel.font=[UIFont systemFontOfSize:15];
    _contentlabel.alpha=.6;
    _contentlabel.numberOfLines=2;
    _timelabel.font=[UIFont systemFontOfSize:14];
    _timelabel.textAlignment=2;
    _timelabel.alpha=.5;
    
    
    _titleLable.text=@"更年期综合征";
    _contentlabel.text=@"病案详情:异常汗出4月，情绪容易激动，脾气暴躁，情绪容易激动，脾气暴躁，";
    _timelabel.text=@"2017-03-11";
    
    _titleLable.sd_layout
    .leftSpaceToView(self.contentView,15)
    .topSpaceToView(self.contentView,10)
    .heightIs(20);
    [_titleLable setSingleLineAutoResizeWithMaxWidth:200];
    
    _timelabel.sd_layout
    .rightSpaceToView(self.contentView,15)
    .centerYEqualToView(_titleLable)
    .heightRatioToView(_titleLable,1);
    [_timelabel setSingleLineAutoResizeWithMaxWidth:220];
    
    _contentlabel.sd_layout
    .leftEqualToView(_titleLable)
    .rightSpaceToView(self.contentView,15)
    .topSpaceToView(_titleLable,5)
    .heightIs(40);
    
}
-(void)setModel:(ZhongYiModel *)model
{
    _model=model;
    _titleLable.text=model.titlename;
    _contentlabel.attributedText=[ToolClass HTML:model.contentName];
    _contentlabel.text=model.contentName;//[ToolClass HTML:model.contentName];
    _timelabel.text=[ToolClass ConvertStrToTime:[model.timeStr longLongValue]];//;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
