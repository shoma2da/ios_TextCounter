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
}

- (TCWordCountNotification *)initWithWord:(id)word {
    _wordModel = word;
    return self;
}

- (void)show {
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    notification.alertBody =[NSString stringWithFormat:@"%d %@ : %@", _wordModel.wordCount, NSLocalizedString(@"characters", @""), _wordModel.word];
    notification.alertAction = @"Open";
    notification.soundName = UILocalNotificationDefaultSoundName;
    [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
    
}

@end
