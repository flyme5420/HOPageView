//
//  NSString+MyString.m
//  meituan
//
//  Created by Chris on 15/3/17.
//  Copyright (c) 2015年 www.aoyolo.com 艾悠乐iOS学院. All rights reserved.
//

#import "NSString+MyString.h"

@implementation NSString (MyString)

- (NSString *)getNewUrl
{
    NSMutableString *mStr = [[NSMutableString alloc]initWithString:self];
    [mStr replaceOccurrencesOfString:@"w.h" withString:@"800.600" options:NSCaseInsensitiveSearch range:NSMakeRange(0, self.length)];
    return mStr;
}

@end
