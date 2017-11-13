//
//  PartialPagingScrollView.h
//  PartialPagingScrollViewDemo
//
//  Created by ParkByounghyouk on 3/10/16.
//  Copyright © 2016 ParkByounghyouk. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PagingScrollView;

@protocol PagingScrollViewDelegate <NSObject>

@required
- (CGFloat)horizontalEdgeInsetInPagingScrollView:(PagingScrollView*)pagingScrollView;
- (CGFloat)verticalEdgeInsetInPagingScrollView:(PagingScrollView*)pagingScrollView;
- (CGFloat)distanceBetweenItemsInPagingScrollView:(PagingScrollView*)pagingScrollView;
- (CGFloat)itemWidthInPagingScrollView:(PagingScrollView*)pagingScrollView;
- (UIView*)viewInPagingScrollView:(PagingScrollView*)pagingScrollView atIndex:(NSInteger)index;
- (NSInteger)numberOfItemInPagingScrollView:(PagingScrollView*)pagingScrollView;

@end

@interface PagingScrollView : UIView <UIScrollViewDelegate>

@property (weak, nonatomic) id<PagingScrollViewDelegate> delegate;

@end
