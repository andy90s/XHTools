//
//  XHTimerExtension.m
//  XHTools
//
//  Created by 梁先华 on 2021/8/3.
//

#import "XHTimerExtension.h"

@implementation XHTimerExtension

static NSMutableDictionary *timers_;

+ (void)initialize {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        timers_ = [NSMutableDictionary new];
    });
}

+ (NSString *)executeStart:(NSTimeInterval)start interval:(NSTimeInterval)interval repeats:(BOOL)repeats async:(BOOL)async task:(void (^)(void))task {
    if (!task || start < 0 || interval < 0) {
        NSLog(@"定时器未能启动,参数未满足条件!");
        return nil;
    }
    NSString *name = [NSString stringWithFormat:@"%lu",(unsigned long)timers_.count];
    // 串行队列 主队列
    dispatch_queue_t queue = async ? dispatch_queue_create("xh_timer", DISPATCH_QUEUE_SERIAL) : dispatch_get_main_queue();
    
    // 创建定时器
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, start * NSEC_PER_SEC, interval * NSEC_PER_SEC);
    dispatch_source_set_event_handler(timer, ^{
        task();
        if (!repeats) {
            [self cancelTask:name];
        }
    });
    dispatch_resume(timer);
    timers_[name] = timer;
    return name;
}

+ (void)cancelTask:(NSString *)name {
    if (timers_[name] == nil) {
        NSLog(@"取消定时器失败,未找到对应的key!");
        return;
    }
    dispatch_source_cancel(timers_[name]);
    [timers_ removeObjectForKey:name];
}

@end
