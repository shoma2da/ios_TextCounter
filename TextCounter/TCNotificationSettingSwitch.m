//
//  TCNotificationSettingSwitch.m
//  TextCounter
//
//  Created by Shoichi Matsuda on 2013/12/06.
//  Copyright (c) 2013年 Shoichi Matsuda. All rights reserved.
//

#import "TCNotificationSettingSwitch.h"

@implementation TCNotificationSettingSwitch

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    self.on = YES;
    [self addTarget:self action:@selector(onChangeSwitch:) forControlEvents:UIControlEventValueChanged];
    
    return self;
}

- (void)onChangeSwitch:(UISwitch *)this{
    NSLog(@"change switch value %@", this.on ? @"YES" : @"NO");
}

@end
