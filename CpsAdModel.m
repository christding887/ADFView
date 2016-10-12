//
//  CpsAdModel.m
//  christding
//
//  Created by dj-xxzx-10065 on 16/10/8.
//  Copyright © 2016年 Dong jing Ltd. All rights reserved.
//

#import "CpsAdModel.h"
#import "RacNetWork.h"
@implementation CpsAdModel

@end


@implementation imgRequest

- (instancetype)init
{
    self = [super init];
    if (self) {
            [self AdCommand];
    }
    return self;
}

-(RACCommand *)AdCommand{
    if (!_AdCommand) {
        _AdCommand=[[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                [RacNetWork post:@"prams" RequestParams:@{} FinishBlock:^(id data) {
                    [subscriber sendNext:data];
                    [subscriber sendCompleted];
                } FailedBlock:^(NSString *error) {
                    NSError* err=[NSError errorWithDomain:@"AdDomain" code:0 userInfo:@{@"Ad":error}];
                    [subscriber sendError:err];
                    [subscriber sendCompleted];
                }];
                return nil;
            }];
        }];
    }
    return _AdCommand;
}

@end
@implementation imgShowControl
+(BOOL)isTodayHaveShow{
    if (![HUserDefault objectForKey:@"previousDay"]||[[HUserDefault objectForKey:@"previousDay"] intValue]!=[[self currentDay] intValue]) {
        [HUserDefault setObject:[self currentDay] forKey:@"previousDay"];
        [HUserDefault synchronize];
        return NO;
    }
    return YES;
}
+(NSNumber*)currentDay{
    NSDate* currentDay=[self LocaleNowDate];
    NSCalendar* cncalendar=[[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents* dacom=[cncalendar components:NSCalendarUnitDay fromDate:currentDay];
    return [NSNumber numberWithInteger:dacom.day];
}
+(NSDate*)LocaleNowDate{
    NSDate* now=[NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:now];
    NSDate *localeDate = [now  dateByAddingTimeInterval: interval];
    return localeDate;
}

@end








