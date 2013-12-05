//
//  TCMainViewController.m
//  TextCounter
//
//  Created by Shoichi Matsuda on 2013/11/30.
//  Copyright (c) 2013年 Shoichi Matsuda. All rights reserved.
//

#import "TCMainViewController.h"
#import "TCWordModel.h"
#import "TCFinishWordCountNotification.h"
#import "TCPasteboradChecker.h"

@interface TCMainViewController () {
    UIBackgroundTaskIdentifier _backgroundTask;
    TCWordModel *_currentWord;
    UILocalNotification *_previousNotification;
}

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
    
    //バックグラウンドでPasteBoardを監視
    void (^finishAction)() = ^{
        [[UIApplication sharedApplication] endBackgroundTask:_backgroundTask];
        
        [[[TCFinishWordCountNotification alloc] init] show];
        
        if (_previousNotification) {
            [[UIApplication sharedApplication] cancelLocalNotification:_previousNotification];
        }
    };
    _backgroundTask = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:finishAction];
    [self performSelectorInBackground:@selector(checkPasteBoardChange) withObject:nil];
}

- (void) checkPasteBoardChange {
    TCPasteboradChecker *checker = [[TCPasteboradChecker alloc] init];
    [checker startCheck:^(TCWordModel *model) {
        UILocalNotification *notification = [[UILocalNotification alloc] init];
        notification.alertBody =[NSString stringWithFormat:@"%d %@ : %@", _currentWord.wordCount, NSLocalizedString(@"characters", @""), _currentWord.word];
        notification.alertAction = @"Open";
        notification.soundName = UILocalNotificationDefaultSoundName;
        [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
        
        if (_previousNotification) {
            [[UIApplication sharedApplication] cancelLocalNotification:_previousNotification];
        }
        
        _previousNotification = notification;
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWordAndCount {
    _currentWord = [self getWordModel];
    
    //文字数表示
    NSString *countStr = [NSString stringWithFormat:@"%d %@", _currentWord.wordCount, NSLocalizedString(@"characters", @"")];
    _countLabel.text = countStr;
    
    //コピー文字列を表示
    if (_currentWord.wordCount == 0) {
        _wordLabel.text = NSLocalizedString(@"hint", @"");
    } else {
        _wordLabel.text = _currentWord.word;
    }
    
}

- (TCWordModel*) getWordModel {
    UIPasteboard *pasteBoard = [UIPasteboard generalPasteboard];
    return [[TCWordModel alloc] initWithWord:pasteBoard.string];
}

@end
