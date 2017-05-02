//
//  MedicineXiangQingCell.h
//  DistributionQuery
//
//  Created by Macx on 17/4/28.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MedicineXiangQingCell : UITableViewCell
+(instancetype)cellWithTableView:(UITableView*)tableView IndexPath:(NSIndexPath *)indexPath;
@property(nonatomic,strong)UILabel * namelabel;
@property(nonatomic,copy)NSString * text;
@end
