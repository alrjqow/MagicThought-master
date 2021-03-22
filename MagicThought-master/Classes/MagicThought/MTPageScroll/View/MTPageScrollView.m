//
//  MTPageScrollView.m
//  QXProject
//
//  Created by monda on 2020/4/13.
//  Copyright © 2020 monda. All rights reserved.
//

#import "MTPageScrollView.h"
#import "MTPageScrollViewModel.h"

@implementation MTPageScrollView

-(NSString *)viewModelClass{return @"MTPageScrollViewModel";}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    if([self.viewModel respondsToSelector:@selector(gestureRecognizer:shouldRecognizeSimultaneouslyWithGestureRecognizer:)])
        return [self.viewModel gestureRecognizer:gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:otherGestureRecognizer];
    
    return false;
}

@end

@implementation MTPageScrollViewX

-(NSString *)viewModelClass{return @"MTPageScrollViewModel";}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    if([self.viewModel respondsToSelector:@selector(gestureRecognizer:shouldRecognizeSimultaneouslyWithGestureRecognizer:)])
        return [self.viewModel gestureRecognizer:gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:otherGestureRecognizer];
    
    return false;
}

@end










@implementation MTPageScrollListView

-(NSString *)viewModelClass{return @"MTPageScrollListViewModel";}

@end

@implementation MTPageScrollListViewX

-(NSString *)viewModelClass{return @"MTPageScrollListViewModel";}

@end







@implementation UIScrollView (MTPageControllModel)

-(void)setMt_pageControllModel:(MTPageControllModel *)mt_pageControllModel
{
    ((MTPageScrollViewBaseViewModel*)self.viewModel).model = mt_pageControllModel;
}

-(MTPageControllModel *)mt_pageControllModel
{
    return ((MTPageScrollViewBaseViewModel*)self.viewModel).model;
}

@end
