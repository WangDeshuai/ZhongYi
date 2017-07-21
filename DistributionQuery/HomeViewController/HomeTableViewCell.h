//
//  HomeTableViewCell.h
//  DistributionQuery
//
//  Created by Macx on 17/5/2.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZhongYiModel.h"
@interface HomeTableViewCell : UITableViewCell
+(instancetype)cellWithTableView:(UITableView*)tableView IndexPath:(NSIndexPath *)indexPath;
@property(nonatomic,strong)ZhongYiModel * model;
@end
/*

 */
