//
//  MyTableViewCell.m
//  DistributionQuery
//
//  Created by Macx on 17/4/20.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import "MyTableViewCell.h"

@implementation MyTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
+(instancetype)cellWithTableView:(UITableView*)tableView CellID:(NSString*)cellID{
    MyTableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell=[[MyTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
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
    
    
    _imageview=[UIButton buttonWithType:UIButtonTypeCustom];
    _namelabel=[UILabel new];
    [self.contentView sd_addSubviews:@[_imageview,_namelabel]];
    
    _namelabel.alpha=.6;
    _namelabel.textAlignment=0;
    _namelabel.font=[UIFont systemFontOfSize:15];
//    _namelabel.backgroundColor=[UIColor redColor];
    
//    _imageview.backgroundColor=[UIColor greenColor];
    _imageview.sd_layout
    .leftSpaceToView(self.contentView,15)
    .centerYEqualToView(self.contentView)
    .widthIs(20)
    .heightIs(20);
    
    _namelabel.sd_layout
    .leftSpaceToView(_imageview,5)
    .centerYEqualToView(_imageview)
    .heightIs(20);
    [_namelabel setSingleLineAutoResizeWithMaxWidth:220];
    
    if ([ToolClass isiPad]) {
        _namelabel.font=[UIFont systemFontOfSize:17];
        _namelabel.alpha=.5;
        _imageview.sd_layout
        .widthIs(30)
        .heightIs(30);
    }
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
