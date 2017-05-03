//
//  BingMingXiangQingCell.m
//  DistributionQuery
//
//  Created by Macx on 17/5/3.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import "BingMingXiangQingCell.h"

@interface BingMingXiangQingCell ()
@property(nonatomic,strong)UILabel * contentLabel;
@property(nonatomic,strong)UIImageView * image1;
@end


@implementation BingMingXiangQingCell




+(instancetype)cellWithTableView:(UITableView*)tableView IndexPath:(NSIndexPath *)indexPath{
    NSString * cellID =[NSString stringWithFormat:@"%lu%lu",(long)indexPath.section,(long)indexPath.row];
    BingMingXiangQingCell * cell =[tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell=[[BingMingXiangQingCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
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
    _contentLabel=[UILabel new];
    _image1=[UIImageView new];
    [self.contentView sd_addSubviews:@[_titleLabel,_contentLabel,_image1]];
    
    _titleLabel.textColor=MAIN_COLOR;
    _titleLabel.font=[UIFont systemFontOfSize:16];
    _titleLabel.alpha=.7;
    _contentLabel.alpha=.6;
    _contentLabel.font=[UIFont systemFontOfSize:14];
    _image1.backgroundColor=MAIN_COLOR;
    
    _image1.sd_layout
    .leftSpaceToView(self.contentView,15)
    .topSpaceToView(self.contentView,10)
    .heightIs(10)
    .widthIs(1);
    
    _titleLabel.sd_layout
    .leftSpaceToView(_image1,15)
    .centerYEqualToView(_image1)
    .heightIs(20);
    [_titleLabel setSingleLineAutoResizeWithMaxWidth:120];
    
    _contentLabel.sd_layout
    .leftEqualToView(_titleLabel)
    .topSpaceToView(_titleLabel,15)
    .rightSpaceToView(self.contentView,15)
    .autoHeightRatio(0);
    
    [self setupAutoHeightWithBottomView:_contentLabel bottomMargin:10];
    
    
}
-(void)setText:(NSString *)text
{
    _text=text;
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:5];
    UIColor *color = [UIColor blackColor];
    NSAttributedString *string = [[NSAttributedString alloc] initWithString:text attributes:@{NSForegroundColorAttributeName : color, NSParagraphStyleAttributeName: paragraphStyle}];
    _contentLabel.attributedText = string;
    _contentLabel.isAttributedContent = YES;
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
