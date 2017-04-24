//
//  ScanCodeCell.h
//  DistributionQuery
//
//  Created by Macx on 17/4/21.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScanCodeCell : UITableViewCell
+(instancetype)cellWithTableView:(UITableView*)tableView CellID:(NSString*)cellID;
@property(nonatomic,strong)UIImageView * imageview;
@property(nonatomic,strong)UITextField * textfield;
@property(nonatomic,strong)UITextView * textview;
@end
