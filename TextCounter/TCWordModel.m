//
//  TCWordModel.m
//  TextCounter
//
//  Created by Shoichi Matsuda on 2013/12/04.
//  Copyright (c) 2013年 Shoichi Matsuda. All rights reserved.
//

#import "TCWordModel.h"

@implementation TCWordModel

- (TCWordModel *) initWithWord:word {
    _word = word;
    _wordCount = [word length];
    return self;
}

- (BOOL)isEqual:(id)object {
    if ([object isKindOfClass:[TCWordModel class]]) {
        TCWordModel *argObj = object;
        return [argObj.word isEqualToString:self.word];
    }
    return NO;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"[TCWordModel]%@", _word];
}

@end
