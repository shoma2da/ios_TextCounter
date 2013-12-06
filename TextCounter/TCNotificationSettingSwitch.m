//
//  TCNotificationSettingSwitch.m
//  TextCounter
//
//  Created by Shoichi Matsuda on 2013/12/06.
//  Copyright (c) 2013年 Shoichi Matsuda. All rights reserved.
//

#import "TCNotificationSettingSwitch.h"

#define DEFAULTS_KEY @"switch_value"

@implementation TCNotificationSettingSwitch

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    self.on = YES;
    [self addTarget:self action:@selector(onChangeSwitch:) forControlEvents:UIControlEventValueChanged];
    
    return self;
}

- (void)onChangeSwitch:(UISwitch *)this{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:this.on forKey:DEFAULTS_KEY];
    [defaults synchronize];
}

@end
