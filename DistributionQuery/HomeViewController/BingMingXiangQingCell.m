//
//  BingMingXiangQingCell.m
//  DistributionQuery
//
//  Created by Macx on 17/5/3.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import "BingMingXiangQingCell.h"

@interface BingMingXiangQingCell ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UILabel * contentLabel;
@property(nonatomic,strong)UIImageView * image1;
@property(nonatomic,strong)NSArray * nameArr;
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
    _nameArr=@[@"【君药】",@"【臣药】",@"【佐药】",@"【使药】"];
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
    .heightIs(15)
    .widthIs(2);
    
    _titleLabel.sd_layout
    .leftSpaceToView(_image1,10)
    .centerYEqualToView(_image1)
    .heightIs(20);
    [_titleLabel setSingleLineAutoResizeWithMaxWidth:120];
    
    _contentLabel.sd_layout
    .leftEqualToView(_titleLabel)
    .topSpaceToView(_titleLabel,10)
    .rightSpaceToView(self.contentView,15)
    .autoHeightRatio(0);
    
    [self CreatTabelView];
    [self setupAutoHeightWithBottomView:_contentLabel bottomMargin:15];
    
    
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


#pragma mark --创建表格
-(void)CreatTabelView{
    if (!_tableView) {
       // _tableView=[[UITableView alloc]initWithFrame:CGRectMake(15, 30, ScreenWidth-30, 100) style:UITableViewStylePlain];
        _tableView=[UITableView new];
    }
    _tableView.tableFooterView=[UIView new];
    _tableView.backgroundColor=BG_COLOR;
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.hidden=YES;
    _tableView.keyboardDismissMode=UIScrollViewKeyboardDismissModeOnDrag;
    
    [self.contentView sd_addSubviews:@[_tableView]];
    _tableView.sd_layout
    .leftSpaceToView(self.contentView,0)
    .rightSpaceToView(self.contentView,0)
    .topSpaceToView(self.contentView,30)
    .bottomSpaceToView(self.contentView,0);
    
    
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _nameArr.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        UILabel * leftlab =[UILabel new];
        leftlab.tag=1;
        [cell sd_addSubviews:@[leftlab]];
    }
    NSLog(@"youma%lu",_junArr.count);
    UILabel * leftlab =[cell viewWithTag:1];
    leftlab.sd_layout
    .leftSpaceToView(cell,15)
    .widthIs(70)
    .centerYEqualToView(cell)
    .heightIs(20);
    [leftlab setSingleLineAutoResizeWithMaxWidth:100];
    leftlab.textAlignment=1;
    leftlab.font=[UIFont systemFontOfSize:13];
    leftlab.alpha=.6;
    leftlab.text=_nameArr[indexPath.row];
    return cell;
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
