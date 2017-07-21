//
//  BingMingXiangQingCell.h
//  DistributionQuery
//
//  Created by Macx on 17/5/3.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BingMingXiangQingCell : UITableViewCell
+(instancetype)cellWithTableView:(UITableView*)tableView IndexPath:(NSIndexPath *)indexPath;
@property(nonatomic,strong)UILabel * titleLabel;
@property(nonatomic,copy)NSString * text;
@property(nonatomic,copy)NSString * text1;

@property(nonatomic,strong)UILabel * junLabel;
@property(nonatomic,strong)UILabel * chenLabel;
@property(nonatomic,strong)UILabel * zuoLabel;
@property(nonatomic,strong)UILabel * shiLabel;
@end
