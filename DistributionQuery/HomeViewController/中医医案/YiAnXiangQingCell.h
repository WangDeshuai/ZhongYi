//
//  YiAnXiangQingCell.h
//  DistributionQuery
//
//  Created by Macx on 17/5/2.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YiAnXiangQingCell : UITableViewCell
+(instancetype)cellWithTableView:(UITableView*)tableView IndexPath:(NSIndexPath *)indexPath;
@property(nonatomic,strong)UILabel * leftLabel;
@property(nonatomic,copy)NSString * text;//其它label
@property(nonatomic,copy)NSString * text1;//病案详情
@end
