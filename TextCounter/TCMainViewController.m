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
#import "TCWordCountNotification.h"
#import "TCNotificationSettingSwitch.h"
#import "TCTutorialDialog.h"
#import "Flurry.h"
#import "GADBannerView.h"

@interface TCMainViewController () {
    UIBackgroundTaskIdentifier _backgroundTask;
    TCWordModel *_currentWord;
    TCWordCountNotification *_previousNotification;
}

@property (weak, nonatomic) IBOutlet TCNotificationSettingSwitch *settingSwitch;
@property (weak, nonatomic) IBOutlet UILabel *wordCountDescLabel;

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
    
    //ログ収集
    [Flurry logEvent:@"launch"];
    
    [self viewWordAndCount];
    
    //アプリ再表示時のイベントを補足
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(viewWordAndCount) name:UIApplicationDidBecomeActiveNotification object:nil];
    
    //表示文言の設定
    _notificationDescLabel.text = NSLocalizedString(@"notificationDesc", nil);
    _wordCountDescLabel.text = NSLocalizedString(@"characters", @"");
    
    //バックグラウンドでPasteBoardを監視
    if (_settingSwitch.on) {
        [self startBackgroundAction];
    }
    
    //広告=====
    GADBannerView* bannerView = [[GADBannerView alloc]
                   initWithFrame:CGRectMake(0.0,
                                            self.view.frame.size.height -
                                            GAD_SIZE_320x50.height,
                                            GAD_SIZE_320x50.width,
                                            GAD_SIZE_320x50.height)];
    
    bannerView.adUnitID = @"ca-app-pub-8704720300499162/1519566219";
    
    bannerView.rootViewController = self;
    [self.view addSubview:bannerView];
    
    [bannerView loadRequest:[GADRequest request]];
    //==========
    
    //チュートリアル表示
    [[[TCTutorialDialog alloc] init] show];
}

- (void) startBackgroundAction {
    void (^finishAction)() = ^{
        [[UIApplication sharedApplication] endBackgroundTask:_backgroundTask];
        
        //ログ収集
        [Flurry logEvent:@"finish_notification"];
        
        [[[TCFinishWordCountNotification alloc] init] show];
        
        if (_previousNotification) {
            [_previousNotification clear];
        }
    };
    _backgroundTask = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:finishAction];
    [self performSelectorInBackground:@selector(checkPasteBoardChange) withObject:nil];
}

- (void) endBackgroundAction {
    [[UIApplication sharedApplication] endBackgroundTask:_backgroundTask];
}

- (void) checkPasteBoardChange {
    TCPasteboradChecker *checker = [[TCPasteboradChecker alloc] init];
    [checker startCheck:^(TCWordModel *model) {
        //ログ収集
        [Flurry logEvent:@"notification"];
        
        if (_previousNotification) {
            [_previousNotification clear];
        }
        
        _previousNotification = [[TCWordCountNotification alloc] initWithWord:model];
        [_previousNotification show];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onChangeSwitchValue:(id)sender {
    UISwitch *settingSwitch = (UISwitch *)sender;
    
    //バックグラウンド処理の開始、終了
    if (settingSwitch.on) {
        [self startBackgroundAction];
    } else {
        [self endBackgroundAction];
    }
}

- (void) viewWordAndCount {
    _currentWord = [self getWordModel];
    
    //文字数表示
    NSString *countStr = [NSString stringWithFormat:@"%d", _currentWord.wordCount];
    _countLabel.text = countStr;
    
    //コピー文字列を表示
    _wordLabel.text = _currentWord.word;
    if (_currentWord.wordCount == 0) {
        _wordLabel.text = NSLocalizedString(@"hint", @"");
    }
}

- (TCWordModel*) getWordModel {
    UIPasteboard *pasteBoard = [UIPasteboard generalPasteboard];
    return [[TCWordModel alloc] initWithWord:pasteBoard.string];
}

@end
