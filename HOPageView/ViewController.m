//
//  ViewController.m
//  HOPageScrollView
//
//  Created by Chris on 15/9/29.
//  Copyright © 2015年 www.aoyolo.com 艾悠乐iOS学院. All rights reserved.
//

#import "ViewController.h"
#import "HOPageView.h"
#import "HOPageScrollView.h"
//#import "AFNetworking.h"
//#import "UIImageView+AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "JSONSerialization.h"
#import "NSString+MyString.h"
#import "ImageEffects.h"


#define URL @"http://api.meituan.com/show/v2/movies/shows.json?__skck=c8a86f38931f8d49dbaadc416db7b31e&__skcy=mfaxvpZRj4XLY8K%2FJ49M1DSi5Ls%3D&__skno=B7F7F5F6-228E-4636-9C84-DB34F8E4E10D&__skts=1444235555.176736&__skua=2d647e3cf6ce107ccbeb879dbd9e03ac&__vhost=api.maoyan.com&channelId=1&ci=280&cinema_id=302&client=iphone&clientType=ios&lat=23.11434260232458&lng=112.4944093384744&movieBundleVersion=100&msid=2279D427-23E4-4FBC-AB3C-6DA6FD2100BF2015-10-08-00-00756&net=255&utm_campaign=AmovieBmovie&utm_content=EEF74BE4130356D97AC0077A1ACAC1AE5DA3FBC7A995BBE22E774192EE727F8E&utm_medium=iphone&utm_source=AppStore&utm_term=6.0&uuid=EEF74BE4130356D97AC0077A1ACAC1AE5DA3FBC7A995BBE22E774192EE727F8E&version_name=6.0"



@interface ViewController ()<HOPageScrollViewDataSource>
{
    NSMutableArray *_imagesArray;
    NSMutableArray *_dataArray;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    HOPageView *pageView = [[HOPageView alloc] initWithFrame:CGRectMake(0, 60, [[UIScreen mainScreen] bounds].size.width, 160) delegate:self];
    pageView.padding = 10;
    pageView.scale = .8;
    pageView.cellSize = CGSizeMake(80, 120);
    [self.view addSubview:pageView];

    _imagesArray = [[NSMutableArray alloc]init];
    
    NSDictionary *jsonDic = [@"maoyan" objectFromJsonResource];
    NSArray *imgArray = jsonDic[@"data"][@"movies"];
    for (NSDictionary *dic in imgArray) {
        NSString *imgStr = dic[@"img"];
        [_imagesArray addObject:imgStr];
    }
    [pageView reloadData];
}

- (NSInteger)numberOfPageInPageScrollView:(HOPageScrollView*)pageScrollView{
    return [_imagesArray count];
}

- (UIView *)pageScrollView:(HOPageScrollView*)pageScrollView viewForRowAtIndex:(int)index{
    UIImageView *cell = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 80, 120)];
    cell.tag = 10 + index;
    
    __weak UIImageView *weakCell = cell;
    
    NSString *imgUrl = [_imagesArray[index] getNewUrl];
    
    if (index == 0) {
        [cell sd_setImageWithURL:[NSURL URLWithString:imgUrl] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            HOPageView *pageView = (HOPageView *)pageScrollView.superview;
            pageView.bgImageLayer.contents = (id)[image blurredImageWithSize:weakCell.frame.size].CGImage;
        }];
    }
    else{
        [cell sd_setImageWithURL:[NSURL URLWithString:imgUrl]];
    }
    
    return cell;
}

- (void)pageScrollView:(HOPageScrollView *)pageScrollView didTapPageAtIndex:(NSInteger)index{
    NSLog(@"click cell at %ld",index);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
