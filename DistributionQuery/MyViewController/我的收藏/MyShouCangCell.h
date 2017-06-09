//
//  MyShouCangCell.h
//  DistributionQuery
//
//  Created by Macx on 17/4/25.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyShouCangModel.h"
#import "searchModel.h"
@interface MyShouCangCell : UITableViewCell
+(instancetype)cellWithTableView:(UITableView*)tableView CellID:(NSString*)cellID;
@property(nonatomic,strong)UIImageView * imageview;
@property(nonatomic,strong)MyShouCangModel * model;
@property(nonatomic,strong)searchModel * searMd;
@end
