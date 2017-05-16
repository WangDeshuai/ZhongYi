//
//  ScanCodeModel.h
//  DistributionQuery
//
//  Created by Macx on 17/5/7.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ScanCodeModel : NSObject
//病名model
@property(nonatomic,copy)NSString*bingMingName;
@property(nonatomic,copy)NSString*bingMingID;
-(id)initWithBingMingDic:(NSDictionary*)dic;
//病理model
@property(nonatomic,copy)NSString * bingLiName;
@property(nonatomic,copy)NSString * bingLiID;
-(id)initWithBingLiDic:(NSDictionary*)dic;
//舌苔model
@property(nonatomic,copy)NSString * sheTaiName;
@property(nonatomic,copy)NSString * sheTaiID;
-(id)initWithSheTaiDic:(NSDictionary*)dic;

//舌质model
@property(nonatomic,copy)NSString * sheZhiName;
@property(nonatomic,copy)NSString * sheZhiID;
-(id)initWithSheZhiDic:(NSDictionary*)dic;

//脉象model
@property(nonatomic,copy)NSString * maiXiangName;
@property(nonatomic,copy)NSString * maiXiangID;
-(id)initWithMaiXiangDic:(NSDictionary*)dic;

//住宿model
@property(nonatomic,copy)NSString * zhuSuName;
@property(nonatomic,copy)NSString * zhuSuID;
-(id)initWithZhuSuDic:(NSDictionary*)dic;

@end
