//
//  CustomAlertFiveCell.m
//  DistributionQuery
//
//  Created by Macx on 17/5/27.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import "CustomAlertFiveCell.h"
@interface CustomAlertFiveCell()
@property(nonatomic,strong)UILabel * namelabel;
@end
@implementation CustomAlertFiveCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
+(instancetype)cellWithTableView:(UITableView*)tableView IndexPath:(NSIndexPath *)indexPath{
    NSString * cellID =[NSString stringWithFormat:@"%lu%lu",(long)indexPath.section,(long)indexPath.row];
    CustomAlertFiveCell * cell =[tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell=[[CustomAlertFiveCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    //cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
//        [self CreatStar];
    }
    return self;
}
-(void)CreatStar{
    _namelabel=[UILabel new];
    _namelabel.font=[UIFont systemFontOfSize:15];
    _namelabel.alpha=.7;
    [self sd_addSubviews:@[_namelabel]];
//    _namelabel.sd_layout
//    .leftSpaceToView(self,10)
//    .rightSpaceToView(self,10)
//    .topSpaceToView(self,10)
//    .autoHeightRatio(0);
    [self setupAutoHeightWithBottomView:_namelabel bottomMargin:10];
    
    
    
}
-(void)setText:(NSString *)text
{
    _text=text;
    _namelabel.text=text;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
