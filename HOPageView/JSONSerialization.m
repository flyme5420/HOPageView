//
//  JSONSerialization.m
//  HOPageScrollView
//
//  Created by Chris on 15/10/8.
//  Copyright © 2015年 www.aoyolo.com 艾悠乐iOS学院. All rights reserved.
//

#import "JSONSerialization.h"

@implementation NSData (JSONSerialization)

- (NSDictionary *)objectFromJsonData
{
    NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:self options:NSJSONReadingAllowFragments error:nil];
    return jsonDic;
}

@end

@implementation NSString (JSONSerialization)

- (NSDictionary *)objectFromJsonString
{
    NSData *jsonData = [self dataUsingEncoding:NSUTF8StringEncoding];
    return [jsonData objectFromJsonData];
}

- (NSDictionary *)objectFromJsonResource
{
    NSURL *jsonurl = [[NSBundle mainBundle]URLForResource:self withExtension:@"json"];
    NSString *jsonStr = [[NSString alloc]initWithContentsOfURL:jsonurl encoding:NSUTF8StringEncoding error:nil];
    return [jsonStr objectFromJsonString];
}

@end