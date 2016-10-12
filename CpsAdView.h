//
//  CpsAdView.h
//  christding
//
//  Created by dj-xxzx-10065 on 16/10/8.
//  Copyright © 2016年 Dong jing Ltd. All rights reserved.
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
    //    UIButton* btn=[[UIButton alloc]init];
    //    [btn setTitle:@"click" forState:UIControlStateNormal];
    //    btn.bounds=CGRectMake(0, 0, 60, 30);
    //    btn.center=self.view.center;
    //    [btn setBackgroundColor:[UIColor blueColor]];
    //    [btn addTarget:self action:@selector(btnaction) forControlEvents:UIControlEventTouchUpInside];
    //    [self.view addSubview:btn];
    //
    //
    //    UIButton* clearbtn=[[UIButton alloc]init];
    //    [clearbtn setTitle:@"clear" forState:UIControlStateNormal];
    //    clearbtn.bounds=CGRectMake(0, 0, 60, 30);
    //    clearbtn.center=CGPointMake(100, 50);
    //    [clearbtn setBackgroundColor:[UIColor orangeColor]];
    //    [clearbtn addTarget:self action:@selector(clearaction) forControlEvents:UIControlEventTouchUpInside];
    //    [self.view addSubview:clearbtn];
//}
//-(void)viewDidAppear:(BOOL)animated{
//    [super viewDidAppear:animated];
//    AFTER(0.5, ^{
//        if (![imgShowControl isTodayHaveShow]) {
//            CpsAdView* adview=[CpsAdView adView];
//                adview.tapblock=^(NSInteger num){
//                NSLog(@"%ld",num);
//            };
//        }
//    });
//}
//-(void)btnaction{
//    if (![imgShowControl isTodayHaveShow]) {
//        CpsAdView* adview=[CpsAdView adView];
//        adview.tapblock=^(NSInteger num){
//            NSLog(@"%ld",num);
//        };
//    }
//
//}
//-(void)clearaction{
//    NSArray* arrs=[kWindow subviews];
//    for (UIView* view in arrs) {
//        if ([view isKindOfClass:[CpsAdView class]]) {
//            [view removeFromSuperview];
//        }
//    }
//    [HUserDefault setObject:@0 forKey:@"previousDay"];
//    [HUserDefault synchronize];
//}



#import <UIKit/UIKit.h>
typedef void(^tapImgofNumber)(NSInteger num);
@interface CpsAdView : UIView
//实例化广告且显示
+(instancetype)adView;
//显示广告页面
-(void)addAdView;
//点击图片后执行具体事项的回调
@property(copy,nonatomic)tapImgofNumber tapblock;
@end
