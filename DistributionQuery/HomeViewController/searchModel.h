//
//  searchModel.h
//  DistributionQuery
//
//  Created by Macx on 17/6/9.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface searchModel : NSObject
@property(nonatomic,copy)NSString *imageName;
@property(nonatomic,copy)NSString * titleName;
@property(nonatomic,copy)NSString * contentName;
@property(nonatomic,copy)NSString * idd;
@property(nonatomic,copy)NSString * type;
-(id)initWithSearchDic:(NSDictionary*)dic;
@end
