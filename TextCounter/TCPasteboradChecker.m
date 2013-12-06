//
//  TCPasteboradChecker.m
//  TextCounter
//
//  Created by Shoichi Matsuda on 2013/12/05.
//  Copyright (c) 2013年 Shoichi Matsuda. All rights reserved.
//

#import "TCPasteboradChecker.h"
#import "TCWordModel.h"

@implementation TCPasteboradChecker {
    TCWordModel *_currentWord;
}

- (void)startCheck:(void (^)(TCWordModel *))callback {
    for (int i = 0; i < 15 * 60; i++) { //15分はチェックを続ける
        [NSThread sleepForTimeInterval:1];
        
        TCWordModel *newString = [self getWordModel];
        if (newString == NULL) {
            return;
        }
        
        if ([_currentWord isEqual:newString]) {
        } else {
            _currentWord = newString;
            callback(newString);
        }
    }
}

- (TCWordModel*) getWordModel {
    UIPasteboard *pasteBoard = [UIPasteboard generalPasteboard];
    if (pasteBoard.string == NULL) {
        return NULL;
    }
    return [[TCWordModel alloc] initWithWord:pasteBoard.string];
}

@end
