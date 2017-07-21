//
//  YaoFangContentXQCell.h
//  DistributionQuery
//
//  Created by Macx on 17/5/3.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YaoFangContentXQCell : UITableViewCell
+(instancetype)cellWithTableView:(UITableView*)tableView IndexPath:(NSIndexPath *)indexPath;
@property(nonatomic,strong)UILabel * namelabel;
@property(nonatomic,strong)UILabel * contentlabel;
@property(nonatomic,copy)NSString * text;
@end
