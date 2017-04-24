//
//  MyTableViewCell.h
//  DistributionQuery
//
//  Created by Macx on 17/4/20.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyTableViewCell : UITableViewCell
+(instancetype)cellWithTableView:(UITableView*)tableView CellID:(NSString*)cellID;
@property(nonatomic,strong)UILabel * namelabel;
@property(nonatomic,strong)UIButton * imageview;
@end
