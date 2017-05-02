//
//  MedicineCell.h
//  DistributionQuery
//
//  Created by Macx on 17/4/27.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MedicineModel.h"
@interface MedicineCell : UITableViewCell
+(instancetype)cellWithTableView:(UITableView*)tableView IndexPath:(NSIndexPath *)indexPath;
//@property(nonatomic,strong)MedicineModel * model;
@property(nonatomic,strong)UILabel * titleLabel;
@property(nonatomic,strong)UIImageView * imageview;
@property(nonatomic,strong)UILabel * dexLabel;
@end
