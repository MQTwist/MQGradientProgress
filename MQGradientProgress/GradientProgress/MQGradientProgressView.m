//
//  MQGradientProgressView.m
//  MQGradientProgress
//
//  Created by 小马 on 2017/7/24.
//  Copyright © 2017年 maqi. All rights reserved.
//

#import "MQGradientProgressView.h"





@interface MQGradientProgressView ()

@property (nonatomic, strong) CALayer *bgLayer;
@property (nonatomic, strong) CAGradientLayer *gradientLayer;


@end

#define DefaultColor @[MQRGBColor(252, 244, 77), MQRGBColor(252, 93, 59)]

@implementation MQGradientProgressView

#pragma mark -
#pragma mark - GET ---> view

- (CALayer *)bgLayer {
    if (!_bgLayer) {
        _bgLayer = [CALayer layer];
        //一般不用frame，因为不支持隐式动画
        _bgLayer.bounds = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        _bgLayer.anchorPoint = CGPointMake(0, 0);
        _bgLayer.backgroundColor = self.bgProgressColor.CGColor;
        _bgLayer.cornerRadius = self.frame.size.height / 2.;
        [self.layer addSublayer:_bgLayer];
    }
    return _bgLayer;
}

- (CAGradientLayer *)gradientLayer {
    if (!_gradientLayer) {
        _gradientLayer = [CAGradientLayer layer];
        _gradientLayer.bounds = CGRectMake(0, 0, self.frame.size.width * self.progress, self.frame.size.height);
        _gradientLayer.startPoint = CGPointMake(0, 0.5);
        _gradientLayer.endPoint = CGPointMake(1, 0.5);
        _gradientLayer.anchorPoint = CGPointMake(0, 0);
        NSArray *colorArr = self.colorArr;
        _gradientLayer.colors = colorArr;
        _gradientLayer.cornerRadius = self.frame.size.height / 2.;
        [self.layer addSublayer:_gradientLayer];
    }
    return _gradientLayer;
}

#pragma mark -
#pragma mark - SET ---> data

- (void)setProgress:(CGFloat)progress {
    _progress = progress;
    [self updateView];
}

- (void)setColorArr:(NSArray *)colorArr {
    _colorArr = colorArr;
    [self updateView];
}

#pragma mark -
#pragma mark - init

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self config];
        [self simulateViewDidLoad];
        self.colorArr = DefaultColor;
        self.progress = 0.65;
    }
    return self;
}

- (void)simulateViewDidLoad {
    [self addSubViewTree];
}

- (void)config {
    self.alwaysShowAllColor = YES;
    self.bgProgressColor = MQRGBColor(230., 244., 245.);
}

- (void)addSubViewTree {
    [self bgLayer];
    [self gradientLayer];
}

- (void)updateView {
    self.gradientLayer.bounds = CGRectMake(0, 0, self.frame.size.width * self.progress, self.frame.size.height);
    self.gradientLayer.colors = [self calcColor];
}

- (NSArray *)calcColor {
    if (self.colorArr.count < 2) {
        return [self colorToCGColor];
    }
    if (self.alwaysShowAllColor || self.progress <= 0) {
        return [self colorToCGColor];
    }
    NSMutableArray *arr = [NSMutableArray array];
    switch (self.colorArr.count) {
        case 2: {
            UIColor *lColor = self.colorArr[0];
            UIColor *rColor = self.colorArr[1];
            [arr addObject:(id)lColor.CGColor];
            CGFloat d_r = [self calcRGBDifferenceWithColor:lColor otherColor:rColor index:0];
            CGFloat d_g = [self calcRGBDifferenceWithColor:lColor otherColor:rColor index:1];
            CGFloat d_b = [self calcRGBDifferenceWithColor:lColor otherColor:rColor index:2];
            [arr addObject:(id)[UIColor colorWithRed:[self colorOfRGBWithColor:lColor index:0] + d_r * self.progress green:[self colorOfRGBWithColor:lColor index:1] + d_g * self.progress blue:[self colorOfRGBWithColor:lColor index:2] + d_b * self.progress alpha:1].CGColor];
            break;
        }
        case 3: {
            UIColor *lColor = self.colorArr[0];
            UIColor *mColor = self.colorArr[1];
            UIColor *rColor = self.colorArr[2];
            [arr addObject:(id)lColor.CGColor];
            if (self.progress <= 0.5) {
                CGFloat d_r = [self calcRGBDifferenceWithColor:lColor otherColor:mColor index:0];
                CGFloat d_g = [self calcRGBDifferenceWithColor:lColor otherColor:mColor index:1];
                CGFloat d_b = [self calcRGBDifferenceWithColor:lColor otherColor:mColor index:2];
                CGFloat progress = self.progress / 0.5;
                [arr addObject:(id)[UIColor colorWithRed:[self colorOfRGBWithColor:lColor index:0] + d_r * progress green:[self colorOfRGBWithColor:lColor index:1] + d_g * progress blue:[self colorOfRGBWithColor:lColor index:2] + d_b * progress alpha:1].CGColor];
            }else {
                [arr addObject:(id)mColor.CGColor];
                CGFloat d_r = [self calcRGBDifferenceWithColor:mColor otherColor:rColor index:0];
                CGFloat d_g = [self calcRGBDifferenceWithColor:mColor otherColor:rColor index:1];
                CGFloat d_b = [self calcRGBDifferenceWithColor:mColor otherColor:rColor index:2];
                CGFloat progress = (self.progress - 0.5) / 0.5;
                [arr addObject:(id)[UIColor colorWithRed:[self colorOfRGBWithColor:mColor index:0] + d_r * progress green:[self colorOfRGBWithColor:mColor index:1] + d_g * progress blue:[self colorOfRGBWithColor:mColor index:2] + d_b * progress alpha:1].CGColor];
                self.gradientLayer.locations = @[@0, @(0.5 / self.progress),@1];
            }
            
            break;
        }
        default:
            [arr addObjectsFromArray:[self colorToCGColor]];
            break;
    }
    return arr;
}

- (NSArray *)colorToCGColor {
    NSMutableArray *arr = [NSMutableArray array];
    for (NSInteger i = 0; i < self.colorArr.count; i++) {
        UIColor *color = self.colorArr[i];
        [arr addObject:(id)color.CGColor];
    }
    return arr;
}

/** 计算RGB的差 0:R 1:G 2:B*/
- (CGFloat)calcRGBDifferenceWithColor:(UIColor *)color otherColor:(UIColor *)otherColor index:(NSInteger)index {
    if (index > 2) {
        return 0;
    }
    const CGFloat *components = CGColorGetComponents(color.CGColor);
    const CGFloat *otherComponents = CGColorGetComponents(otherColor.CGColor);
    return otherComponents[index] - components[index];
}

/** 获取对应的RGB */
- (CGFloat)colorOfRGBWithColor:(UIColor *)color index:(NSInteger)index {
    if (index > 2) {
        return 0;
    }
    const CGFloat *components = CGColorGetComponents(color.CGColor);
    return components[index];
}

@end
