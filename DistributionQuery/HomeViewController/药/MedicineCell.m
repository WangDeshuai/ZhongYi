//
//  MedicineCell.m
//  DistributionQuery
//
//  Created by Macx on 17/4/27.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import "MedicineCell.h"
@interface MedicineCell()

@end
@implementation MedicineCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
+(instancetype)cellWithTableView:(UITableView*)tableView IndexPath:(NSIndexPath *)indexPath{
    NSString * cellID =[NSString stringWithFormat:@"%lu%lu",(long)indexPath.section,(long)indexPath.row];
    MedicineCell * cell =[tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell=[[MedicineCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
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
    _titleLabel=[UILabel new];
    _imageview=[UIImageView new];
    _dexLabel=[UILabel new];
    [self.contentView sd_addSubviews:@[_titleLabel,_imageview,_dexLabel]];
//    _titleLabel.backgroundColor=[UIColor redColor];
//    _dexLabel.backgroundColor=[UIColor yellowColor];
//    _imageview.backgroundColor=[UIColor magentaColor];
    
    
    //属性
    _titleLabel.font=[UIFont systemFontOfSize:17];
    _titleLabel.alpha=.8;
    _dexLabel.font=[UIFont systemFontOfSize:14];
    _dexLabel.alpha=.6;
    
    _imageview.sd_layout
    .leftSpaceToView(self.contentView,10)
    .centerYEqualToView(self.contentView)
    .widthIs(60)
    .heightIs(60);
    
    _titleLabel.sd_layout
    .leftSpaceToView(_imageview,10)
    .rightSpaceToView(self.contentView,10)
    .topSpaceToView(self.contentView,15)
    .heightIs(25);
    
    _dexLabel.sd_layout
    .leftEqualToView(_titleLabel)
    .topSpaceToView(_titleLabel,5)
    .rightSpaceToView(self.contentView,15)
    .heightRatioToView(_titleLabel,1);
    
}
//-(void)setModel:(MedicineModel *)model
//{
//    _model=model;
////    _titleLabel.text=model.yaoTitleName;
//    _dexLabel.text=model.yaoDexName;
//    [_imageview setImageWithURL:[NSURL URLWithString:model.yaoImageName] placeholderImage:[UIImage imageNamed:@"yao_zw"]];
//    
//    
//}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
