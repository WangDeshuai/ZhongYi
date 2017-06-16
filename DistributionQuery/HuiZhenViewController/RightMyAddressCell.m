//
//  RightMyAddressCell.m
//  DistributionQuery
//
//  Created by Macx on 16/11/12.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "RightMyAddressCell.h"
@interface RightMyAddressCell()
@property(nonatomic,strong)UILabel * nameLabel;
@end
@implementation RightMyAddressCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
+(instancetype)cellWithTableView:(UITableView*)tableView{
    static NSString * ID =@"right";
    RightMyAddressCell * cell =[tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell =[[RightMyAddressCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}



-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIImageView * bg =[[UIImageView alloc]init];
        bg.image=[UIImage imageNamed:@"bg_dropdown_leftpart"];
        self.backgroundView=bg;
        
        UIImageView * selectbg =[UIImageView new];
        selectbg.image=[UIImage imageNamed:@"bg_dropdown_left_selected"];
        self.selectedBackgroundView=selectbg;
        _nameLabel=[UILabel new];
        if ([ToolClass isiPad]) {
            _nameLabel.font=[UIFont systemFontOfSize:FOUNT_IPAD];
        }else{
            _nameLabel.font=[UIFont systemFontOfSize:15];
        }
        _nameLabel.textAlignment=1;
        _nameLabel.alpha=.7;
//        _nameLabel.backgroundColor=[UIColor yellowColor];
        [self.contentView sd_addSubviews:@[_nameLabel]];
        _nameLabel.sd_layout
        .leftSpaceToView(self.contentView,15)
        .rightSpaceToView(self.contentView,15)
        .autoHeightRatio(0)
        .centerYEqualToView(self.contentView);
    }
    
    
    return self;
}
-(void)setName:(NSString *)name
{
    _name=name;
    _nameLabel.text=name;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
