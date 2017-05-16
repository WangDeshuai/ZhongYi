//
//  LecturesModel.h
//  DistributionQuery
//
//  Created by Macx on 17/5/7.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LecturesModel : NSObject
@property(nonatomic,copy)NSString * title;
@property(nonatomic,copy)NSString * time;
@property(nonatomic,copy)NSString * jiangZuoID;
@property(nonatomic,copy)NSString * imageurl;
-(id)initWithJiangZuoDic:(NSDictionary*)dic;
@end
