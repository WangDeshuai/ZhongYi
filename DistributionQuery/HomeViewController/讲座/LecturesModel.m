//
//  LecturesModel.m
//  DistributionQuery
//
//  Created by Macx on 17/5/7.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import "LecturesModel.h"

@implementation LecturesModel
-(id)initWithJiangZuoDic:(NSDictionary*)dic{
    self=[super init];
    if (self) {
        _title=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"title"]]];
        _time=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"createTime"]]];
         _jiangZuoID=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"id"]]];
         _imageurl=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"filePath"]]];
    }
    
    return self;
}
@end
