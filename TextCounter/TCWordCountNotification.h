//
//  TCWordCountNotification.h
//  TextCounter
//
//  Created by Shoichi Matsuda on 2013/12/03.
//  Copyright (c) 2013年 Shoichi Matsuda. All rights reserved.
//

#import <Foundation/Foundation.h>
@class TCWordModel;

@interface TCWordCountNotification : NSObject

- (TCWordCountNotification *) initWithWord:(TCWordModel*)word;
- (void) show;
- (void) clear;

@end
