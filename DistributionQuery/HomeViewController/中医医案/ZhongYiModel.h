//
//  ZhongYiModel.h
//  DistributionQuery
//
//  Created by Macx on 17/5/4.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZhongYiModel : NSObject
//中医医案
@property(nonatomic,copy)NSString * titlename;
@property(nonatomic,copy)NSString * contentName;
@property(nonatomic,copy)NSString * zhongYiID;
@property(nonatomic,copy)NSString * timeStr;
-(id)initWithZhongYiDic:(NSDictionary*)dic;
@end
