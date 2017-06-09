//
//  MyShouCangCell.m
//  DistributionQuery
//
//  Created by Macx on 17/4/25.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import "MyShouCangCell.h"
@interface MyShouCangCell()
@property(nonatomic,strong)UILabel * namelabel;
@property(nonatomic,strong)UILabel * dextlabel;
@end
@implementation MyShouCangCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
+(instancetype)cellWithTableView:(UITableView*)tableView CellID:(NSString*)cellID{
    MyShouCangCell * cell =[tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell=[[MyShouCangCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //  self.backgroundColor=[UIColor colorWithRed:254/255.0 green:251/255.0 blue:224/255.0 alpha:1];
        [self CreatStar];
    }
    return self;
}
-(void)CreatStar{
    _imageview=[UIImageView new];
    _namelabel=[UILabel new];
    _dextlabel=[UILabel new];
    [self.contentView sd_addSubviews:@[_imageview,_namelabel,_dextlabel]];
    
    _namelabel.font=[UIFont systemFontOfSize:16];
    _namelabel.textAlignment=0;
    _dextlabel.font=[UIFont systemFontOfSize:14];
    _dextlabel.textAlignment=0;
    _dextlabel.alpha=.6;
    
    _namelabel.text=@"艾叶";
    _dextlabel.text=@"药";
//    _namelabel.backgroundColor=[UIColor redColor];
//    _dextlabel.backgroundColor=[UIColor yellowColor];
    //图片
    _imageview.sd_layout
    .leftSpaceToView(self.contentView,15)
    .centerYEqualToView(self.contentView)
    .widthIs(28)
    .heightIs(28);
    //标题
    _namelabel.sd_layout
    .leftSpaceToView(_imageview,20)
    .topSpaceToView(self.contentView,10)
    .heightIs(20)
    .rightSpaceToView(self.contentView,15);
    //副标题
    _dextlabel.sd_layout
    .leftEqualToView(_namelabel)
    .topSpaceToView(_namelabel,5)
    .widthRatioToView(_namelabel,1)
    .heightIs(20);
    
}
-(void)setModel:(MyShouCangModel *)model
{
    _model=model;
    
    _namelabel.text=model.titlename;
    _imageview.image=[UIImage imageNamed:model.imagename];
    _dextlabel.text=model.typeName;
    
    
}
-(void)setSearMd:(searchModel *)searMd
{
    _searMd=searMd;
    _namelabel.text=searMd.titleName;
    _imageview.image=[UIImage imageNamed:searMd.imageName];
    _dextlabel.text=searMd.contentName;
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
