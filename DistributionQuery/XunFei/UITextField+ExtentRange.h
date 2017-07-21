//
//  UITextField+ExtentRange.h
//  DistributionQuery
//
//  Created by Macx on 17/7/19.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (ExtentRange)
- (NSRange)selectedRange;

- (void)setSelectedRange:(NSRange)range;
@end
