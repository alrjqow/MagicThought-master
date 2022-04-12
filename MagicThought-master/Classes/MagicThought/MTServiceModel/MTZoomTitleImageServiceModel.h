//
//  MTZoomTitleImageServiceModel.h
//  XHProject
//
//  Created by apple on 2021/9/9.
//

#import "MTServiceModel.h"


@interface MTZoomTitleImageServiceModel : MTServiceModel

-(void)setTitleImageZoomWithLayout:(void (^)(UIImageView* imageView))layout;

-(void)setTitleImageZoom:(NSString*)image;

-(void)setTopZoomWithColor:(UIColor *)backgroundColor BaseHeight:(CGFloat)baseHeight;

-(void)setBottomZoomWithColor:(UIColor*)backgroundColor;

-(void)setShadowCardViewWithLayout:(void (^)(UIView* shadowCardView))layout;

-(void)scrollViewDidScroll:(UIScrollView *)scrollView;

@end

