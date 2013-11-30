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
    
    UIPasteboard *pasteBoard = [UIPasteboard generalPasteboard];
    NSString *copiedString = pasteBoard.string;
    
    //文字数表示
    NSString *countStr = [NSString stringWithFormat:@"%d文字", [copiedString length]];
    _countLabel.text = countStr;
    
    //コピー文字列を表示
    _wordLabel.text = copiedString;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end