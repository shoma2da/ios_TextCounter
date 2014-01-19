//
//  TCTutorialDialog.m
//  TextCounter
//
//  Created by Shoichi Matsuda on 2014/01/19.
//  Copyright (c) 2014年 Shoichi Matsuda. All rights reserved.
//

#import "TCTutorialDialog.h"

@implementation TCTutorialDialog

static NSString * const KEY_INIT = @"key_init";

- (void) show {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults registerDefaults:@{KEY_INIT:@YES}];
    
    //初めての時だけ何かする
    bool isInit = [defaults boolForKey:KEY_INIT];
    if (isInit == NO) {
        return;
    }
    
    [[[UIAlertView alloc]
     initWithTitle:@"アプリの使い方"
     message:@"コピーしてある文字列の文字数を表示します。他のアプリで文字をコピーしてからアプリを開いてください。"
     delegate:nil
     cancelButtonTitle:nil
     otherButtonTitles:@"OK", nil] show];
    
    //チュートリアルを表示したことを保持しておく
    [defaults setBool:NO forKey:KEY_INIT];
}

@end
