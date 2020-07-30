//
//  ViewController.m
//  MQGradientProgress
//
//  Created by 小马 on 2017/7/24.
//  Copyright © 2017年 maqi. All rights reserved.
//

#import "ViewController.h"
#import "MQGradientProgressView.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //显示全部颜色
    MQGradientProgressView *progressView2 = [[MQGradientProgressView alloc] initWithFrame:CGRectMake(0, 0, 300, 10)];
    progressView2.center = CGPointMake(self.view.center.x, self.view.center.y - 50);
    progressView2.alwaysShowAllColor = YES;
    CGFloat progress2 = 0.8;
    progressView2.progress = progress2;
    progressView2.colorArr = @[MQRGBColor(108, 171, 200), MQRGBColor(0, 0, 0), MQRGBColor(255, 207, 42)];
    [self.view addSubview:progressView2];
    
    MQGradientProgressView *progressView1 = [[MQGradientProgressView alloc] initWithFrame:CGRectMake(0, 0, 300, 10)];
    progressView1.center = self.view.center;
    CGFloat progress1 = 1;
    progressView1.progress = progress1;
    progressView1.colorArr = @[MQRGBColor(108, 171, 200), MQRGBColor(0, 0, 0), MQRGBColor(255, 207, 42)];
    [self.view addSubview:progressView1];
    
    //按照进度显示
    MQGradientProgressView *progressView = [[MQGradientProgressView alloc] initWithFrame:CGRectMake(0, 0, 300, 10)];
    progressView.center = CGPointMake(self.view.center.x, self.view.center.y + 50);
    progressView.alwaysShowAllColor = NO;
    CGFloat progress = 0.8;
    progressView.progress = progress;
    progressView.colorArr = @[MQRGBColor(108, 171, 200), MQRGBColor(0, 0, 0), MQRGBColor(255, 207, 42)];
    [self.view addSubview:progressView];
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
