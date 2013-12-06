//
//  TCFinishWordCountNotification.m
//  TextCounter
//
//  Created by Shoichi Matsuda on 2013/12/05.
//  Copyright (c) 2013年 Shoichi Matsuda. All rights reserved.
//

#import "TCFinishWordCountNotification.h"

@implementation TCFinishWordCountNotification

- (void)show {
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    notification.alertBody = NSLocalizedString(@"finish_message", nil);
    notification.alertAction = @"Open";
    notification.soundName = UILocalNotificationDefaultSoundName;
    
    [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
}

@end
