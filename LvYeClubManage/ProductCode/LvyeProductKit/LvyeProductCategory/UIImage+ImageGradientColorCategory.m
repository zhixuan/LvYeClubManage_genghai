//
//  UIImage+ImageGradientColorCategory.m
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2018/8/21.
//  Copyright © 2018年 Beijing Lvye Shijie Information Technology Co.,Ltd. All rights reserved.
//

#import "UIImage+ImageGradientColorCategory.h"

@implementation UIImage (ImageGradientColorCategory)


+ (instancetype)initWithGradientColorWithDirection:(GradientColorStyle)style size:(CGSize)size startColor:(UIColor *)start endColor:(UIColor *)end{
    
    if (CGSizeEqualToSize(size, CGSizeZero) || !start || !end) {
        return [super alloc];
    }
    
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(0, 0, size.width, size.height);
    CGPoint startPoint = CGPointZero;
    if (style == GradientColorDownwardDiagonalStyle) {
        startPoint = CGPointMake(0.0, 1.0);
    }
    gradientLayer.startPoint = startPoint;
    CGPoint endPoint = CGPointZero;
    switch (style) {
        case GradientColorHorizontalStyle:
            endPoint = CGPointMake(1.0, 0.0);
            break;
        case GradientColorVerticalStyle:
            endPoint = CGPointMake(0.0, 1.0);
            break;
        case GradientColorUpwardStyle:
            endPoint = CGPointMake(1.0, 1.0);
            break;
        case GradientColorDownwardDiagonalStyle:
            endPoint = CGPointMake(1.0, 0.0);
            break;
        default:
            startPoint = CGPointMake(0.0, 1.0);
            break;
    }
    
    gradientLayer.endPoint = endPoint;
    gradientLayer.colors = @[(__bridge id)start.CGColor, (__bridge id)end.CGColor];
    UIGraphicsBeginImageContext(size);
    [gradientLayer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage*image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


+ (UIColor *)colorWithGradientColorImageWithDirection:(GradientColorStyle)style size:(CGSize)size startColor:(UIColor *)start endColor:(UIColor *)end{
    UIImage *image = [self initWithGradientColorWithDirection:style size:size startColor:start endColor:end];
    return [UIColor colorWithPatternImage:image];
}

- (UIImage *)thumbScaleImageWithPoint:(CGPoint)point size:(CGSize)size{
    CGImageRef cgRef = self.CGImage;
    CGImageRef imageRef = CGImageCreateWithImageInRect(cgRef, CGRectMake(point.x,point.y, size.width, size.height));
    UIImage *thumbScale = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    return thumbScale;
}
@end
