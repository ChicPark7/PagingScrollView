//
//  PartialPagingScrollView.m
//  PartialPagingScrollViewDemo
//
//  Created by ParkByounghyouk on 3/10/16.
//  Copyright © 2016 ParkByounghyouk. All rights reserved.
//

#import "PagingScrollView.h"

@interface PagingScrollView()

@property (nonatomic, strong) UIScrollView* scrollView;
@property (nonatomic, strong) NSMutableArray* itemViewArray;

@end

@implementation PagingScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initProperties];
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initProperties];
    }
    
    return self;
}

- (void)initProperties
{
    self.itemViewArray = [NSMutableArray new];

    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.delegate = self;
    self.scrollView.decelerationRate = 0.1;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    [self addSubview:self.scrollView];
}

- (void)setDelegate:(id<PagingScrollViewDelegate>)delegate
{
    _delegate = delegate;
    for (UIView* itemView in self.itemViewArray) {
        [itemView removeFromSuperview];
    }
    [self.itemViewArray removeAllObjects];
    for (int i = 0; i < [self.delegate numberOfItemInPagingScrollView:self]; i++) {
        UIView* item = [self.delegate viewInPagingScrollView:self atIndex:i];
        [self.scrollView addSubview:item];
        [self.itemViewArray addObject:item];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.scrollView.frame = self.bounds;
    CGFloat itemWidth = [self.delegate itemWidthInPagingScrollView:self];
    CGFloat distance = [self.delegate distanceBetweenItemsInPagingScrollView:self];
    CGFloat horEdgeInset = [self.delegate horizontalEdgeInsetInPagingScrollView:self];
    CGFloat verEdgeInset = [self.delegate verticalEdgeInsetInPagingScrollView:self];
    for (int i = 0; i < self.itemViewArray.count; i++) {
        UIView* item = [self.itemViewArray objectAtIndex:i];
        CGFloat x = horEdgeInset + (itemWidth + distance) * i;
        CGFloat y = verEdgeInset;
        CGRect itemFrame = item.frame;
        itemFrame.origin = CGPointMake(x, y);
        [item setFrame:itemFrame];
    }
    [self.scrollView setContentSize:CGSizeMake((itemWidth + distance) * self.itemViewArray.count + horEdgeInset * 2 - distance,
                                               self.scrollView.frame.size.height)];
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    if (scrollView.contentSize.width - scrollView.frame.size.width > (*targetContentOffset).x + 1 && (*targetContentOffset).x > 1) {
        CGPoint oldOffset = *targetContentOffset;
        CGFloat newOffset = oldOffset.x;

        CGFloat itemWidth = [self.delegate itemWidthInPagingScrollView:self];
        CGFloat distance = [self.delegate distanceBetweenItemsInPagingScrollView:self];
        CGFloat horEdgeInset = [self.delegate horizontalEdgeInsetInPagingScrollView:self];

        NSInteger targetIndex = ((*targetContentOffset).x - horEdgeInset + itemWidth / 2) / (itemWidth + distance);
        
        newOffset = horEdgeInset / 2 + (itemWidth + distance) * targetIndex;
        *targetContentOffset = CGPointMake(newOffset, oldOffset.y);
    }
}

@end
