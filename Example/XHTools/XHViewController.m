//
//  XHViewController.m
//  XHTools
//
//  Created by andy90s on 08/03/2021.
//  Copyright (c) 2021 andy90s. All rights reserved.
//

#import "XHViewController.h"
#import <XHTools/XHTimerExtension.h>

@interface XHViewController ()

@end

@implementation XHViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    NSString *test = [XHTimerExtension executeStart:-1 interval:2.0 repeats:NO async:NO task:^{
        NSLog(@"执行111,, %@",[NSThread currentThread]);
    }];
    [XHTimerExtension cancelTask:@"ssss"];
    
    [XHTimerExtension executeStart:2.0 interval:2.0 repeats:YES async:NO task:^{
        NSLog(@"执行222,, %@",[NSThread currentThread]);
    }];
    [XHTimerExtension executeStart:2.0 interval:2.0 repeats:YES async:NO task:^{
        NSLog(@"执行333,, %@",[NSThread currentThread]);
    }];
    [XHTimerExtension executeStart:2.0 interval:2.0 repeats:YES async:NO task:^{
        NSLog(@"执行444,, %@",[NSThread currentThread]);
    }];
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
