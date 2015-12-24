//
//  HOPageView.h
//  HOPageScrollView
//
//  Created by Chris on 15/9/29.
//  Copyright © 2015年 www.aoyolo.com 艾悠乐iOS学院. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HOPageScrollView;

@interface HOPageView : UIView

@property (nonatomic, assign) CGFloat padding; //水平间隔
@property (nonatomic, assign) CGFloat scale; //cell的缩小比例
@property (nonatomic, assign) CGSize cellSize;
@property (nonatomic, strong) CALayer *bgImageLayer;

- (instancetype)initWithFrame:(CGRect)frame delegate:(id)delegate;
- (void)reloadData;

@end
