//
//  YaoFangModel.h
//  DistributionQuery
//
//  Created by Macx on 17/5/2.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YaoFangModel : NSObject
//药方列表页
@property(nonatomic,copy)NSString * name;
@property(nonatomic,copy)NSString * yaoID;
-(id)initWithYaoListViewDic:(NSDictionary*)dic;
//药方分类
@property(nonatomic,copy)NSString *yaoFangClass;
@property(nonatomic,copy)NSString * yaoClassID;
-(id)initWithYaoClassViewDic:(NSDictionary*)dic;
@end
