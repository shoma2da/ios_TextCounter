//
//  TCMainViewController.m
//  TextCounter
//
//  Created by Shoichi Matsuda on 2013/11/30.
//  Copyright (c) 2013年 Shoichi Matsuda. All rights reserved.
//

#import "TCMainViewController.h"

@interface TCMainViewController ()

@end

@implementation TCMainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self viewWordAndCount];
    
    //アプリ再表示時のイベントを補足
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(viewWordAndCount) name:UIApplicationDidBecomeActiveNotification object:nil];
    
    //表示文言の設定
    _notificationDescLabel.text = NSLocalizedString(@"notificationDesc", nil);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWordAndCount {
    //コピーされた文字列を取得
    UIPasteboard *pasteBoard = [UIPasteboard generalPasteboard];
    NSString *copiedString = pasteBoard.string;
    
    //文字数表示
    NSString *countStr = [NSString stringWithFormat:@"%d %@", [copiedString length], NSLocalizedString(@"characters", @"")];
    _countLabel.text = countStr;
    
    //コピー文字列を表示
    if ([copiedString length] == 0) {
        _wordLabel.text = NSLocalizedString(@"hint", @"");
    } else {
        _wordLabel.text = copiedString;
    }
}

@end
