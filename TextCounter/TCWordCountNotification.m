//
//  TCWordCountNotification.m
//  TextCounter
//
//  Created by Shoichi Matsuda on 2013/12/03.
//  Copyright (c) 2013年 Shoichi Matsuda. All rights reserved.
//

#import "TCWordCountNotification.h"
#import "TCWordModel.h"

@implementation TCWordCountNotification {
    TCWordModel *_wordModel;
    UILocalNotification *_notification;
}

- (TCWordCountNotification *)initWithWord:(id)word {
    _wordModel = word;
    return self;
}

- (void)show {
    _notification = [[UILocalNotification alloc] init];
    _notification.alertBody =[NSString stringWithFormat:@"%d %@ : %@", _wordModel.wordCount, NSLocalizedString(@"characters", @""), _wordModel.word];
    _notification.alertAction = @"Open";
    _notification.soundName = UILocalNotificationDefaultSoundName;
    [[UIApplication sharedApplication] presentLocalNotificationNow:_notification];
    
}

- (void)clear {
    [[UIApplication sharedApplication] cancelLocalNotification:_notification];
}

@end
