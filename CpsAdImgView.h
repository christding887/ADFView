//
//  CpsAdImgView.h
//  christding
//
//  Created by dj-xxzx-10065 on 16/10/8.
//  Copyright © 2016年 Dong jing Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^closeBlock)();
typedef void(^tapBlock)();
@interface CpsAdImgView : UIView
@property(strong,nonatomic)UIButton* closeBtn;
@property(strong,nonatomic)UIImageView* AdImgView;
@property(copy,nonatomic)closeBlock cblock;
@property(copy,nonatomic)tapBlock tblock;
@end
