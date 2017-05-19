//
//  MyTuiGuangCell.h
//  DistributionQuery
//
//  Created by Macx on 17/4/29.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyTuiGuangModel.h"
@interface MyTuiGuangCell : UITableViewCell
+(instancetype)cellWithTableView:(UITableView*)tableView IndexPath:(NSIndexPath *)indexPath;

@property(nonatomic,strong)MyTuiGuangModel * model;
@end
