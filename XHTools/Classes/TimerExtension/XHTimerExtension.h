//
//  XHTimerExtension.h
//  XHTools
//
//  Created by 梁先华 on 2021/8/3.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XHTimerExtension : NSObject

/// GCD定时器, 返回任务ID,用于取消任务.
/// @param start 开始时间(s)
/// @param interval 间隔时间(s)
/// @param repeats 是否重复执行
/// @param async 是否异步
/// @param task 任务
+ (NSString *)executeStart:(NSTimeInterval)start
            interval:(NSTimeInterval)interval
             repeats:(BOOL)repeats async:(BOOL)async
                task:(void(^)(void))task;

/// 取消任务
/// @param name 任务ID
+ (void)cancelTask:(NSString *)name;
@end

NS_ASSUME_NONNULL_END
