//
//  MQGradientProgressView.h
//  MQGradientProgress
//
//  Created by 小马 on 2017/7/24.
//  Copyright © 2017年 maqi. All rights reserved.
//

#import <UIKit/UIKit.h>

#define MQRGBColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

@interface MQGradientProgressView : UIView

/**
 *  进度条背景颜色  默认是 （230, 244, 245）
 */
@property (nonatomic, strong) UIColor *bgProgressColor;

/**
 *  进度条渐变颜色数组，目前最多支持3种颜色
 *  默认是 @[(id)MQRGBColor(252, 244, 77).CGColor,(id)MQRGBColor(252, 93, 59).CGColor]
 */
@property (nonatomic, strong) NSArray<UIColor *> *colorArr;

/**
 *  进度 默认是0.65
 */
@property (nonatomic, assign) CGFloat progress;

/** 不管progress为多少，进度条上始终展示全部颜色 默认YES */
@property (nonatomic, assign) BOOL alwaysShowAllColor;

@end
