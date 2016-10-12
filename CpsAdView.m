//
//  CpsAdView.m
//  christding
//
//  Created by dj-xxzx-10065 on 16/10/8.
//  Copyright © 2016年 Dong jing Ltd. All rights reserved.
//

#import "CpsAdView.h"
#import "CpsAdImgView.h"
#import "CpsAdModel.h"
#import "MBProgressHUD.h"
#import "SDAutoLayout.h"
#import "MJExtension.h"
#import "SDWebImage/UIImageView+WebCache.h"
static NSString* const PREIMG=@"Previousimage";
@interface CpsAdView()
@property(strong,nonatomic)CpsAdImgView* imgView;
@property(strong,nonatomic)CpsAdModel* model;
@property(strong,nonatomic)imgRequest* reqs;
@end
@implementation CpsAdView
+(instancetype)adView{
    CpsAdView* adview=[[CpsAdView alloc]initWithFrame:CGRectMake(0, 0, HScreenWidth, HScreenHeight)];
    return adview;
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        WEAK
        _reqs=[[imgRequest alloc]init];
        [[[[_reqs.AdCommand executionSignals] switchToLatest] concat:[self dataSignal]]  subscribeNext:^(id x) {
            STRONG
            if ([x isKindOfClass:[NSDictionary class]]) {
                self.model=[CpsAdModel mj_objectWithKeyValues:x];
                [self.imgView.AdImgView sd_setImageWithURL:self.model.AdImgUrl completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                    if (error) {
                        NSLog(@"%@",error.description);
                        //如果载入产生错误无法正常显示，那么就读取上一次缓存的图片
                        [[SDImageCache sharedImageCache] queryDiskCacheForKey:PREIMG done:^(UIImage *image, SDImageCacheType cacheType) {
                            if (image) {
                               self.imgView.AdImgView.image=image;
                            }else{
                                //如果第一次载入失败,则显示自定义图片
                                self.imgView.AdImgView.image=[UIImage imageNamed:@""];
                            }
                            
                        }];
                    }else{
                        //每次正常载入都将图片保持在缓存区
                        [[SDImageCache sharedImageCache] storeImage:image forKey:PREIMG];
                    }
                }];
            }
        }];
        [MBProgressHUD showHUDAddedTo:self animated:YES];
        [[[_reqs.AdCommand executing] skip:1] subscribeNext:^(id x) {
            STRONG
            if ([x boolValue]) {
            }else{
                [MBProgressHUD hideHUDForView:self  animated:YES];
            }
        }];
            [_reqs.AdCommand.errors subscribeNext:^(id x) {
                NSLog(@"请求错误信息:%@",x);
            [MBProgressHUD hideHUDForView:self animated:YES];
            [self removeFromSuperview];
        }];
        [_reqs.AdCommand execute:nil];
    }
    return self;
}


-(RACSignal*)dataSignal{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [self initdata];
        [subscriber sendCompleted];
        return nil;
    }];
}
-(void)initdata{
    UIView* backView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, HScreenWidth, HScreenHeight)];
    backView.backgroundColor=[UIColor colorWithWhite:0.5 alpha:0.5];
    [self sd_addSubviews:@[backView,self.imgView]];
    backView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
    self.imgView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(30, 15, 30, 15));
    WS(weakSelf)
    [self.imgView setCblock:^{
        [weakSelf dismissAdView];
    }];
    [self.imgView setTblock:^{
        [weakSelf dismissAdView];
        weakSelf.tapblock(weakSelf.model.AdCmd); //点击图片回调带执行参数的block
    }];
    [self addAdView];
}

-(CpsAdImgView *)imgView{
    if (!_imgView) {
        _imgView=[[CpsAdImgView alloc]init];
        _imgView.transform=CGAffineTransformScale(CGAffineTransformIdentity, 0.f, 0.f);
    }
    return _imgView;
}
-(CpsAdModel *)model{
    if (!_model) {
        _model=[[CpsAdModel alloc]init];
    }
    return _model;
}
-(void)addAdView{
    [kWindow addSubview:self];
    [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:0.8 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.imgView.transform=CGAffineTransformScale(CGAffineTransformIdentity, 1.0f, 1.0f);
    } completion:^(BOOL finished) {
        CABasicAnimation* base=[self rotation:1.0 degree:M_PI repeatCount:1.0];
        [self.imgView.AdImgView.layer addAnimation:base forKey:@"rotation"];
    }];
    
}

-(CABasicAnimation *)rotation:(float)dur degree:(float)degree  repeatCount:(int)repeatCount{
    CABasicAnimation *theAnimation;
    theAnimation=[CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
    theAnimation.duration=dur;
    theAnimation.cumulative= NO;
    theAnimation.removedOnCompletion = YES;
    theAnimation.fromValue = @(0);
    theAnimation.toValue = @(degree);
    theAnimation.repeatCount=repeatCount;
    theAnimation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    return  theAnimation;
}
-(void)dismissAdView{
    [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.imgView.transform=CGAffineTransformScale(self.imgView.transform, 0.001f, 0.001f);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}
@end
