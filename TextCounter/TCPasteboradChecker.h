//
//  TCPasteboradChecker.h
//  TextCounter
//
//  Created by Shoichi Matsuda on 2013/12/05.
//  Copyright (c) 2013年 Shoichi Matsuda. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TCWordModel;

@interface TCPasteboradChecker : NSObject

- (void) startCheck:(void(^)(TCWordModel *wordModel))callback;

@end
