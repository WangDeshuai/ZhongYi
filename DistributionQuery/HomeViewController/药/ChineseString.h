//
//  ChineseString.h
//  YZX_ChineseSorting
//
//  Created by Suilongkeji on 13-10-29.
//  Copyright (c) 2013年 Suilongkeji. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "pinyin.h"

@interface ChineseString : NSObject
@property(retain,nonatomic)NSString *string;
@property(retain,nonatomic)NSString *pinYin;

//-----  返回tableview右方indexArray
+(NSMutableArray*)IndexArray:(NSArray*)stringArr;

//-----  返回联系人
//正常的
+(NSMutableArray*)LetterSortArray:(NSArray*)stringArr;
//分组的mdArray(把model分类)
+(NSMutableArray*)LetterSortArray:(NSArray*)stringArr NsArr:(NSMutableArray*)mdArray;
//去掉了特殊符号，否则图片地址就显示不全了
+(NSMutableArray*)LetterSortArray2:(NSArray*)stringArr;

///----------------------
//返回一组字母排序数组(中英混排)
+(NSMutableArray*)SortArray:(NSArray*)stringArr;

@end
