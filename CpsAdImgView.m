//
//  CpsAdImgView.m
//  christding
//
//  Created by dj-xxzx-10065 on 16/10/8.
//  Copyright © 2016年 Dong jing Ltd. All rights reserved.
//

#import "CpsAdImgView.h"
#import "SDAutoLayout.h"
static float const WidthCloseBtn=50.0;
@interface CpsAdImgView()
@end
@implementation CpsAdImgView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}
-(void)initUI{
    [self sd_addSubviews:@[self.AdImgView,self.closeBtn]];
    self.AdImgView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(WidthCloseBtn/2, WidthCloseBtn/2, WidthCloseBtn/2, WidthCloseBtn/2));
    self.closeBtn.sd_layout.topSpaceToView(self,0).rightSpaceToView(self,0).heightIs(WidthCloseBtn).widthIs(WidthCloseBtn);

}
-(UIImageView *)AdImgView{
    if (!_AdImgView) {
        _AdImgView=[[UIImageView alloc]init];
        _AdImgView.userInteractionEnabled=YES;
        _AdImgView.layer.borderWidth=1.0;
        _AdImgView.layer.borderColor=[UIColor blackColor].CGColor;
        _AdImgView.layer.masksToBounds=YES;
        [_AdImgView setContentMode:UIViewContentModeScaleToFill];
        UITapGestureRecognizer* tap=[[UITapGestureRecognizer alloc]init];
        [tap addTarget:self action:@selector(tapAction:)];
        [_AdImgView addGestureRecognizer:tap];
    
    }
    return _AdImgView;
}
-(UIButton *)closeBtn{
    if (!_closeBtn) {
        _closeBtn=[[UIButton alloc]init];
        _closeBtn.selected=NO;
        [_closeBtn setBackgroundImage:[UIImage imageNamed:@"btn_close_normal"] forState:UIControlStateNormal];
        WEAK
        [[_closeBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            STRONG
            if (self.cblock) {
                self.cblock();
            }
        }];
        
    }
    return _closeBtn;
}
-(void)setCblock:(closeBlock)cblock{
    _cblock=cblock;
}
-(void)tapAction:(UITapGestureRecognizer*)tap{
    if (self.tblock) {
        self.tblock();
    }
}
-(void)setTblock:(tapBlock)tblock{
    _tblock=tblock;
}

@end
