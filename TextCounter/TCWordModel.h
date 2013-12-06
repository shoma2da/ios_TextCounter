//
//  TCWordModel.h
//  TextCounter
//
//  Created by Shoichi Matsuda on 2013/12/04.
//  Copyright (c) 2013年 Shoichi Matsuda. All rights reserved.
//

#import <Foundation/Foundation.h>
@class TCWordModel;

@interface TCWordModel : NSObject

@property (nonatomic, readonly) NSString *word;
@property (nonatomic, readonly) NSUInteger wordCount;
- (TCWordModel *) initWithWord:word;

@end
