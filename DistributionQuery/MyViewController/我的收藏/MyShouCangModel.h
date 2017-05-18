//
//  MyShouCangModel.h
//  DistributionQuery
//
//  Created by Macx on 17/5/18.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyShouCangModel : NSObject
@property(nonatomic,copy)NSString * titlename;
@property(nonatomic,copy)NSString * typeName;
@property(nonatomic,copy)NSString * imagename;
@property(nonatomic,copy)NSString * targetID;//此ID 并不是每一条的ID
@property(nonatomic,copy)NSString * type;//这是类型，根据类型判断跳转哪个界面的详情（药、病、讲座、医案）
-(id)initWithShangCangDic:(NSDictionary*)dic;
@end
