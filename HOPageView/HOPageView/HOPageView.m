//
//  HOPageView.m
//  HOPageScrollView
//
//  Created by Chris on 15/9/29.
//  Copyright © 2015年 www.aoyolo.com 艾悠乐iOS学院. All rights reserved.
//

#import "HOPageView.h"
#import "HOPageScrollView.h"

@interface HOPageView ()
@property (nonatomic, strong) HOPageScrollView *pageScrollView;
@end

@implementation HOPageView

- (instancetype)initWithFrame:(CGRect)frame delegate:(id)delegate
{
    self = [super initWithFrame:frame];
    if (self) {
        _bgImageLayer = [CALayer layer];
        _bgImageLayer.backgroundColor = [UIColor redColor].CGColor;
        _bgImageLayer.frame = self.bounds;
//        _bgImageLayer.position = CGPointMake(CGRectGetWidth(self.bounds)/2, CGRectGetHeight(self.bounds)/2);
        [self.layer addSublayer:_bgImageLayer];
  
        //iOS8
//        UIVisualEffectView *effectView = [[UIVisualEffectView alloc]initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
//        effectView.frame = self.bounds;
//        [self addSubview:effectView];
        //iOS7 vImage
        
        _pageScrollView = [[HOPageScrollView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame))];
        _pageScrollView.dataSource = delegate;
        [self addSubview:_pageScrollView];
        
        self.backgroundColor = [UIColor blueColor];
    }
    return self;
}

- (void)setPadding:(CGFloat)padding
{
    _pageScrollView.padding = padding;
}

- (void)setScale:(CGFloat)cellScale
{
    _pageScrollView.cellScale = cellScale;
}

- (void)setCellSize:(CGSize)cellSize
{
    _pageScrollView.cellSize = cellSize;
}

- (void)reloadData
{
    [_pageScrollView reloadData];
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    if (CGRectContainsPoint(CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)), point)) {
        return self.pageScrollView;
    }
    return [super hitTest:point withEvent:event];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
