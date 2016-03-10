//
//  ViewController.m
//  PartialPagingScrollViewDemo
//
//  Created by ParkByounghyouk on 3/10/16.
//  Copyright © 2016 ParkByounghyouk. All rights reserved.
//

#import "ViewController.h"
#import "PagingScrollView.h"

@interface ViewController () <PagingScrollViewDelegate>

@property (weak, nonatomic) IBOutlet PagingScrollView *pagingScrollView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.pagingScrollView.delegate = self;
    
}

- (CGFloat)horizontalEdgeInsetInPagingScrollView:(PagingScrollView*)pagingScrollView
{
    return 10;
}

- (CGFloat)verticalEdgeInsetInPagingScrollView:(PagingScrollView*)pagingScrollView
{
    return 10;
}

- (CGFloat)distanceBetweenItemsInPagingScrollView:(PagingScrollView*)pagingScrollView
{
    return 3;
}

- (CGFloat)itemWidthInPagingScrollView:(PagingScrollView*)pagingScrollView
{
    return 100;
}

- (UIView*)viewInPagingScrollView:(PagingScrollView*)pagingScrollView atIndex:(NSInteger)index
{
    UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    view.backgroundColor = [UIColor greenColor];
    return view;
}

- (NSInteger)numberOfItemInPagingScrollView:(PagingScrollView*)pagingScrollView
{
    return 10;
}

@end
