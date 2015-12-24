//
//  HOPageScrollView.h
//  HOPageScrollView
//
//  Created by Chris on 15/9/29.
//  Copyright © 2015年 www.aoyolo.com 艾悠乐iOS学院. All rights reserved.
//

#import <UIKit/UIKit.h>

//#define ACTIVE_DISTANCE 240
//#define ZOOM_FACTOR 0.3

@class HOPageScrollView;

@protocol HOPageScrollViewDataSource <UIScrollViewDelegate>
@required
- (UIView*)pageScrollView:(HOPageScrollView *)pageScrollView viewForRowAtIndex:(int)index;
- (NSInteger)numberOfPageInPageScrollView:(HOPageScrollView*)pageScrollView;
@optional
- (void)pageScrollView:(HOPageScrollView *)pageScrollView didTapPageAtIndex:(NSInteger)index;
@end

@interface HOPageScrollView : UIScrollView

@property (nonatomic, assign) CGSize  cellSize;

@property (nonatomic, assign) CGFloat padding;
@property (nonatomic, assign) CGFloat cellScale;
@property (nonatomic, assign) float leftRightOffset;
@property (nonatomic, strong) UIImageView* backgroundView;
@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, strong) NSArray* visibleCell;
@property (nonatomic, strong) NSMutableSet* cacheCells;
@property (nonatomic, strong) NSMutableDictionary* visibleCellsMap;
@property (nonatomic, assign) CGFloat pageViewWith;

@property (nonatomic, weak) id<HOPageScrollViewDataSource> dataSource;

- (void)reloadData;
- (UIView*)viewForRowAtIndex:(NSInteger)index;

@end
