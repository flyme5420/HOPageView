//
//  HOPageScrollView.m
//  HOPageScrollView
//
//  Created by Chris on 15/9/29.
//  Copyright © 2015年 www.aoyolo.com 艾悠乐iOS学院. All rights reserved.
//

#import "HOPageScrollView.h"
#import "HOPageView.h"
#import "ImageEffects.h"

@interface HOPageScrollView()<UIScrollViewDelegate>

@property (nonatomic, strong) UITapGestureRecognizer *tapGesture;
@property (nonatomic, strong) NSMutableArray * viewsInPage;
@property (nonatomic, assign) NSInteger numberOfCell;

@end

@implementation HOPageScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initializeValue];
    }
    return self;
}

- (void)initializeValue
{
    self.delegate = self;
    self.clipsToBounds = NO;
    self.pagingEnabled = YES;
    self.leftRightOffset = 0;
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;
    self.autoresizesSubviews = NO;
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.multipleTouchEnabled = NO;
    self.decelerationRate = UIScrollViewDecelerationRateFast;
    [self addGestureRecognizer:self.tapGesture];
    self.backgroundColor = [UIColor clearColor];
    
}

- (void)reloadData
{
//    _cellSize.width = self.frame.size.width - 10 * 2;
//    _cellSize = ;[self.dataSource sizeCellForPageScrollView:self];
    
    _numberOfCell = [self.dataSource numberOfPageInPageScrollView:self];
    
    _leftRightOffset = (self.frame.size.width - _cellSize.width)/2;
    
    float startX = _padding/2;  // _leftRightOffset;
    float topY   = (self.frame.size.height - _cellSize.height)/2;
    
    [[self subviews] makeObjectsPerformSelector: @selector(removeFromSuperview)];
    
    self.viewsInPage = nil;
    self.viewsInPage = [NSMutableArray array];
    
    for (int i = 0; i < _numberOfCell; i ++) {
        UIView * cell = [self.dataSource pageScrollView:self viewForRowAtIndex:i];
        cell.frame = CGRectMake(startX, 0, _cellSize.width, _cellSize.height);
        [self addSubview:cell];
        startX += self.padding + _cellSize.width;
        [self.viewsInPage addObject:cell];
    }
    
    float scrollViewSizeWith = startX - self.padding + (self.frame.size.width - _cellSize.width)/2;
    self.contentSize = CGSizeMake(scrollViewSizeWith, _cellSize.height);
    self.frame = CGRectMake(_leftRightOffset-_padding/2, topY, _cellSize.width+_padding, _cellSize.height);
}

- (UIView*)viewForRowAtIndex:(NSInteger)index
{
    if (index < self.viewsInPage.count) {
        return self.viewsInPage[index];
    }
    return nil;
}

#pragma mark - Properties

- (NSMutableArray*)viewsInPage
{
    if (!_viewsInPage) {
        _viewsInPage = [NSMutableArray array];
    }
    return _viewsInPage;
}

- (UITapGestureRecognizer*)tapGesture
{
    if (!_tapGesture) {
        _tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
    }
    return _tapGesture;
}

#pragma mark - Action

- (void)handleTapGesture:(UITapGestureRecognizer*)tapGesture
{
    CGPoint tapPoint = [tapGesture locationInView:self];
    
    for (UIImageView *view in self.viewsInPage) {
        if (CGRectContainsPoint(view.frame, tapPoint)) {
            NSInteger xInCellNumber = view.tag - 10;
            [self.dataSource pageScrollView:self didTapPageAtIndex:xInCellNumber];
            [self setContentOffset:CGPointMake((_cellSize.width + self.padding) * xInCellNumber, 0) animated:YES];
        }
    }
    
}

- (void)layoutSubviews
{
    CGRect visibleRect;
    visibleRect.origin = self.contentOffset;
    visibleRect.size = self.bounds.size;
    
    for(UIView *view in self.subviews){

        CGRect pageViewFrame = self.superview.frame;
        CGRect newFrame = [self convertRect:view.frame toView:self.superview];
        
        if (CGRectIntersectsRect(newFrame, CGRectMake(0, 0, pageViewFrame.size.width, pageViewFrame.size.height))) {
            
            CGFloat df = view.center.x - _cellSize.width/2 - self.contentOffset.x;
            
            _cellScale = (_cellScale == 0 ? .8 : _cellScale);
            
//            NSLog(@"fabs(df):%f", fabs(df));
            
            CGFloat sx = 1.0 - fabs(df-_padding/2)/(_cellSize.width+_padding)*(1-_cellScale);
//            NSLog(@"sx:%f, df:%f", sx, df);
            CGFloat sx1 =  MAX(sx, _cellScale); //缩小比例不能小于设定值
            
            CATransform3D t = CATransform3DMakeScale(sx1, sx1, 1);
            
            view.layer.transform = t;
        }
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self updateBackgroundImageWithcontentOffset:scrollView.contentOffset.x];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self updateBackgroundImageWithcontentOffset:scrollView.contentOffset.x];
}

- (void)updateBackgroundImageWithcontentOffset:(CGFloat)offsetX
{
    NSInteger pageIndex = (int)offsetX / (int)(_cellSize.width+_padding);
    UIImageView *cellView = _viewsInPage[pageIndex];
    HOPageView *pageView = (HOPageView *)self.superview;
    
    UIImage *img = [cellView.image blurredImageWithSize:_cellSize];
    
    [CATransaction begin];
    [CATransaction setAnimationDuration:1];
    pageView.bgImageLayer.contents = (id)img.CGImage;
    [CATransaction commit];
}

//float transformToValue(float value, int space, float start, float end)
//{
//    NSLog(@"value2:%f", value);
//    float val = fmod(value, space) / space;
//    float newValue = 1 - val * (end - start);
//    return newValue;
//}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
