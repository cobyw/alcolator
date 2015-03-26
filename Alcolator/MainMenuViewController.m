//
//  MainMenuViewController.m
//  Alcolator
//
//  Created by Coby West on 3/26/15.
//  Copyright (c) 2015 Bloc. All rights reserved.
//

#import "MainMenuViewController.h"
#import "ViewController.h"
#import "WhiskeyViewController.h"


@interface MainMenuViewController ()

//sets the properties for the two buttons
@property (weak, nonatomic) UIButton *wineButton;
@property (weak, nonatomic) UIButton *whiskeyButton;

@end

@implementation MainMenuViewController

- (void)loadView{
    //creates the actual buttons
    self.wineButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.whiskeyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    //sets the button text
    [self.wineButton setTitle:NSLocalizedString(@"Wine", @"Wine") forState:UIControlStateNormal];
    [self.whiskeyButton setTitle:NSLocalizedString(@"Whiskey", @"Whiskey") forState:UIControlStateNormal];
    
    //sets the button events
    [self.wineButton addTarget:self action:@selector(winePressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.whiskeyButton addTarget:self action:@selector(whiskeyPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    self.view = [[UIView alloc] init];
    
    [self.view addSubview:self.wineButton];
    [self.view addSubview:self.whiskeyButton];
}

-(void) viewDidLoad {
    [super viewDidLoad];
    
    //set background color to light grey
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    /*
    UIFont *bigFont = [UIFont boldSystemFontOfSize:20];
    
    [self.wineButton.titleLabel setFont:bigFont];
    [self.whiskeyButton.titleLabel setFont:bigFont];
    */
     
    self.title = NSLocalizedString(@"Select Alcolator", @"Select Alcolator");

    
}

-(void) viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
    /*
    CGRectDivide(self.view.bounds, &wineButtonFrame, &whiskeyButtonFrame, CGRectGetWidth(self.view.bounds) / 2, CGRectMinXEdge);
    
    self.wineButton.frame = wineButtonFrame;
    self.whiskeyButton.frame = whiskeyButtonFrame;
     */
    CGRect wineButtonFrame, whiskeyButtonFrame;
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    
    CGFloat viewWidth = screenRect.size.width;
    CGFloat viewHeight = screenRect.size.height;
    
    CGFloat buttonWidth = 100;
    CGFloat buttonHeight = 44;
    
    CGFloat horzPadding = (viewWidth - (buttonWidth * 2))/3;
    
    CGFloat vertPadding = (viewHeight - buttonHeight) / 2;
    
    CGFloat secondButtonPadding = (horzPadding *2) + buttonWidth;
    
    wineButtonFrame = CGRectMake(horzPadding, vertPadding, buttonWidth, buttonHeight);
    whiskeyButtonFrame = CGRectMake(secondButtonPadding, vertPadding, buttonWidth, buttonHeight);
    
    self.wineButton.frame = wineButtonFrame;
    self.whiskeyButton.frame = whiskeyButtonFrame;
    
    self.whiskeyButton.backgroundColor = [UIColor blackColor];
    self.wineButton.backgroundColor = [UIColor blackColor];
    
}

-(void)winePressed:(UIButton *) sender{
    ViewController *wineVC = [[ViewController alloc] init];
    [self.navigationController pushViewController:wineVC animated:YES];
    
}

-(void)whiskeyPressed:(UIButton *) sender{
    WhiskeyViewController *whiskeyVC = [[WhiskeyViewController alloc] init];
    [self.navigationController pushViewController:whiskeyVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
