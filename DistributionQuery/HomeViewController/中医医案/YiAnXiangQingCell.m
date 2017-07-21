//
//  YiAnXiangQingCell.m
//  DistributionQuery
//
//  Created by Macx on 17/5/2.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import "YiAnXiangQingCell.h"
@interface YiAnXiangQingCell()<UIWebViewDelegate>
@property(nonatomic,strong)UILabel * contentLabel;

@end
@implementation YiAnXiangQingCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
+(instancetype)cellWithTableView:(UITableView*)tableView IndexPath:(NSIndexPath *)indexPath{
    NSString * cellID =[NSString stringWithFormat:@"%lu%lu",(long)indexPath.section,(long)indexPath.row];
    YiAnXiangQingCell * cell =[tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell=[[YiAnXiangQingCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
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
    _leftLabel=[UILabel new];
    _contentLabel=[UILabel new];
    _bingAnLab=[UIWebView new];
    [self.contentView sd_addSubviews:@[_leftLabel,_contentLabel,_bingAnLab]];
    _leftLabel.alpha=.5;
    _leftLabel.font=[UIFont systemFontOfSize:15];
    _contentLabel.font=[UIFont systemFontOfSize:15];
    _contentLabel.alpha=.8;
//    _bingAnLab.font=[UIFont systemFontOfSize:15];
//    _bingAnLab.alpha=.8;
    
    
    _leftLabel.sd_layout
    .leftSpaceToView(self.contentView,15)
    .topSpaceToView(self.contentView,15)
    .heightIs(20);
    [_leftLabel setSingleLineAutoResizeWithMaxWidth:120];
    
    _contentLabel.sd_layout
    .rightSpaceToView(self.contentView,15)
    .topSpaceToView(self.contentView,15)
    .leftSpaceToView(self.contentView,15)
    .autoHeightRatio(0);
    
    _bingAnLab.hidden=YES;
    
    _bingAnLab.sd_layout
    .rightSpaceToView(self.contentView,15)
    .topSpaceToView(_leftLabel,5)
    .leftEqualToView(_leftLabel)
    .bottomSpaceToView(self.contentView,0);
    
    [self setupAutoHeightWithBottomView:_contentLabel bottomMargin:15];
    
}
-(void)setText:(NSString *)text
{
    _text=text;
//    _contentLabel.text=text;
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:5];
    UIColor *color = [UIColor blackColor];
    NSAttributedString *string = [[NSAttributedString alloc] initWithString:text attributes:@{NSForegroundColorAttributeName : color, NSParagraphStyleAttributeName: paragraphStyle}];
    _contentLabel.attributedText = string;
    _contentLabel.isAttributedContent = YES;
}
-(void)setText1:(NSString *)text1
{
    _text1=text1;
    _bingAnLab.hidden=NO;
    _bingAnLab.delegate=self;
//    _bingAnLab.attributedText = [ToolClass HTML:text1];
    NSLog(@">>>>>%@",[ToolClass HTML:text1]);
     [self.bingAnLab loadHTMLString:text1 baseURL:nil];
    
    
}
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    
    for (int i =0; i<20; i++) {
        NSString *meta = [NSString stringWithFormat:@"document.getElementsByTagName('img')[%d].style.width = '100%%'", i];
        [webView stringByEvaluatingJavaScriptFromString:meta];
    }
    CGFloat height = [[webView stringByEvaluatingJavaScriptFromString:@"document.body.scrollHeight"] floatValue];
    NSLog(@"输出高度%f",height);
    
    webView.frame = CGRectMake(0, 0, ScreenWidth, height+20);
    UIScrollView *tempView = (UIScrollView *)[webView.subviews objectAtIndex:0];
    tempView.scrollEnabled = NO;
//    改变滚动试图的滑动
//    self.tableView.contentSize = CGSizeMake(ScreenWidth, height+20);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
