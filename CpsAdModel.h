//
//  CpsAdModel.h
//  christding
//
//  Created by dj-xxzx-10065 on 16/10/8.
//  Copyright © 2016年 Dong jing Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
//数据模型
@interface CpsAdModel : NSObject
@property(strong,nonatomic)NSURL* AdImgUrl;
@property(strong,nonatomic)NSURL* AdHtmlUrl;
@property(assign,nonatomic)NSInteger AdCmd;

@end
//网络请求command
@interface imgRequest : NSObject
@property(strong,nonatomic)RACCommand* AdCommand;
@end

//广告显示时间控制
@interface imgShowControl : NSObject
+(BOOL)isTodayHaveShow;
@end