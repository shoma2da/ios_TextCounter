//
//  TCMainViewController.h
//  TextCounter
//
//  Created by Shoichi Matsuda on 2013/11/30.
//  Copyright (c) 2013年 Shoichi Matsuda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TCMainViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UITextView *wordLabel;
@property (weak, nonatomic) IBOutlet UILabel *notificationDescLabel;

@end
