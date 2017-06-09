//
//  CustomAlertFiveCell.h
//  DistributionQuery
//
//  Created by Macx on 17/5/27.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomAlertFiveCell : UITableViewCell
+(instancetype)cellWithTableView:(UITableView*)tableView IndexPath:(NSIndexPath *)indexPath;
@property(nonatomic,copy)NSString * text;
@end
