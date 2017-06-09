//
//  ScanCodeCell.m
//  DistributionQuery
//
//  Created by Macx on 17/4/21.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import "ScanCodeCell.h"

@implementation ScanCodeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
+(instancetype)cellWithTableView:(UITableView*)tableView CellID:(NSString*)cellID{
    ScanCodeCell * cell =[tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell=[[ScanCodeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
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
    _imageview=[[UIImageView alloc]init];
    _textfield=[UITextField new];
    _textview=[UITextView new];
    [self.contentView sd_addSubviews:@[_imageview,_textfield,_textview]];
    _textfield.font=[UIFont systemFontOfSize:15];
//    _imageview.backgroundColor=[UIColor greenColor];
//    _textfield.backgroundColor=[UIColor redColor];
    _textfield.enabled=NO;
    _textview.hidden=YES;
    
    
    
    _imageview.sd_layout
    .leftSpaceToView(self.contentView,15)
    .centerYEqualToView(self.contentView)
    .widthIs(16)
    .heightIs(16);
    
    _textfield.sd_layout
    .leftSpaceToView(_imageview,10)
    .centerYEqualToView(_imageview)
    .rightSpaceToView(self.contentView,15)
    .heightIs(20);
    
    _textview.sd_layout
    .leftSpaceToView(self.contentView,30)
    .topSpaceToView(_textfield,5)
    .bottomSpaceToView(self.contentView,5)
    .rightSpaceToView(self.contentView,15);
    
   
    
    //插入一行
    _insertBtn=[UIButton buttonWithType:UIButtonTypeCustom];
//    _insertBtn.backgroundColor=[UIColor redColor];
    _insertBtn.hidden=YES;
    [self.contentView sd_addSubviews:@[_insertBtn]];
    _insertBtn.sd_layout
    .rightSpaceToView(self.contentView,15)
    .centerYEqualToView(self.contentView)
    .widthIs(50)
    .heightIs(50);
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
