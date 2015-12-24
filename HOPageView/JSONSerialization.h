//
//  JSONSerialization.h
//  HOPageScrollView
//
//  Created by Chris on 15/10/8.
//  Copyright © 2015年 www.aoyolo.com 艾悠乐iOS学院. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (JSONSerialization)

@end

@interface NSString (JSONSerialization)
- (NSDictionary *)objectFromJsonResource;
@end