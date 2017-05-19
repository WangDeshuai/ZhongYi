//
//  MyTuiGuangCell.m
//  DistributionQuery
//
//  Created by Macx on 17/4/29.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import "MyTuiGuangCell.h"

@interface MyTuiGuangCell()
@property(nonatomic,strong)UIImageView * leftImage;
@property(nonatomic,strong)UILabel * titlelabel;
@property(nonatomic,strong)UILabel * dexlable;
@property(nonatomic,strong)UILabel * sexlabel;
@property(nonatomic,strong)UILabel * timelable;
@end
@implementation MyTuiGuangCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
+(instancetype)cellWithTableView:(UITableView*)tableView IndexPath:(NSIndexPath *)indexPath{
    NSString * cellID =[NSString stringWithFormat:@"%lu%lu",(long)indexPath.section,(long)indexPath.row];
    MyTuiGuangCell * cell =[tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell=[[MyTuiGuangCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
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
    _titlelabel=[UILabel new];
    _dexlable=[UILabel new];
    _timelable=[UILabel new];
    _sexlabel=[UILabel new];
    _leftImage=[UIImageView new];
    
    [self.contentView sd_addSubviews:@[_leftImage,_titlelabel,_sexlabel,_dexlable,_timelable]];
    
    
    //属性
    _titlelabel.alpha=.6;
    _titlelabel.font=[UIFont systemFontOfSize:16];
    _sexlabel.alpha=.6;
    _sexlabel.font=[UIFont systemFontOfSize:14];
    _dexlable.alpha=.6;
    _dexlable.font=[UIFont systemFontOfSize:14];
    _timelable.alpha=.4;
    _timelable.font=[UIFont systemFontOfSize:14];
    _sexlabel.textAlignment=2;
    //值
    _titlelabel.text=@"刘医生";
    _dexlable.text=@"18333152832";
    _sexlabel.text=@"邀请码:254129672";
    _timelable.text=@"2017-04-24";
    _leftImage.image=[UIImage imageNamed:@"mytg_pic"];
    
    _leftImage.sd_layout
    .centerYEqualToView(self.contentView)
    .leftSpaceToView(self.contentView,15)
    .widthIs(50)
    .heightIs(50);
    
    
    _titlelabel.sd_layout
    .leftSpaceToView(_leftImage,15)
    .topSpaceToView(self.contentView,10)
    .heightIs(20);
    [_titlelabel setSingleLineAutoResizeWithMaxWidth:200];
    
    _sexlabel.sd_layout
    .rightSpaceToView(self.contentView,10)
    .centerYEqualToView(_titlelabel)
    .heightRatioToView(_titlelabel,1);
    [_sexlabel setSingleLineAutoResizeWithMaxWidth:ScreenWidth-100];

    
    _dexlable.sd_layout
    .leftEqualToView(_titlelabel)
    .topSpaceToView(_titlelabel,10)
    .heightRatioToView(_titlelabel,1);
    [_dexlable setSingleLineAutoResizeWithMaxWidth:ScreenWidth-100];
    
    _timelable.sd_layout
    .rightEqualToView(_sexlabel)
    .centerYEqualToView(_dexlable)
    .heightRatioToView(_titlelabel,1);
    [_timelable setSingleLineAutoResizeWithMaxWidth:200];
}

-(void)setModel:(MyTuiGuangModel *)model

{
    _model=model;
    _titlelabel.text=model.titlename;
    _dexlable.text=model.phonename;
    _sexlabel.text=[NSString stringWithFormat:@"邀请码:%@",model.yaoQingMa];
    _timelable.text=[ToolClass ConvertStrToTime:[model.timename longLongValue]];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
