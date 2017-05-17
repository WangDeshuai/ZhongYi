//
//  MedicineXiangQingCell.m
//  DistributionQuery
//
//  Created by Macx on 17/4/28.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import "MedicineXiangQingCell.h"
@interface MedicineXiangQingCell()
@property(nonatomic,strong)UILabel * contentlabel;
@end
@implementation MedicineXiangQingCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
+(instancetype)cellWithTableView:(UITableView*)tableView IndexPath:(NSIndexPath *)indexPath{
    NSString * cellID =[NSString stringWithFormat:@"%lu%lu",(long)indexPath.section,(long)indexPath.row];
    MedicineXiangQingCell * cell =[tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell=[[MedicineXiangQingCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
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
    
    _contentlabel =[UILabel new];
    _namelabel =[UILabel new];
    [self.contentView sd_addSubviews:@[_namelabel,_contentlabel]];
    _namelabel.alpha=.4;
    _namelabel.font=[UIFont systemFontOfSize:15];
    _namelabel.textAlignment=0;
    _contentlabel.font=[UIFont systemFontOfSize:15];
    _contentlabel.alpha=.7;
    _contentlabel.numberOfLines=0;
    
    
    _contentlabel.sd_layout
    .leftSpaceToView(self.contentView,15)
    .topSpaceToView(self.contentView,15)
    .widthIs(ScreenWidth-30)
    .autoHeightRatio(0);
    
    _namelabel.sd_layout
    .leftSpaceToView(self.contentView,7)
    .topSpaceToView(self.contentView,15)
    .heightIs(20);
    [_namelabel setSingleLineAutoResizeWithMaxWidth:200];
//    _contentlabel.sd_layout
//    .leftSpaceToView(self.contentView,15)
//    .topSpaceToView(self.contentView,15)
//    .rightSpaceToView(self.contentView,15)
//    .autoHeightRatio(0);
    [self setupAutoHeightWithBottomView:_contentlabel bottomMargin:15];
}
-(void)setText:(NSString *)text
{
    _text=text;
  //  _contentlabel.text=text;
//    _contentlabel.backgroundColor=[UIColor redColor];
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:5];
//    CGFloat emptylen = self.contentlabel.font.pointSize * 2;
   // paragraphStyle.firstLineHeadIndent = 30;//首行缩进
//    paragraphStyle.headIndent = 30;
    UIColor *color = [UIColor blackColor];
    NSAttributedString *string = [[NSAttributedString alloc] initWithString:text attributes:@{NSForegroundColorAttributeName : color, NSParagraphStyleAttributeName: paragraphStyle}];
    _contentlabel.attributedText = string;
    _contentlabel.isAttributedContent = YES;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
