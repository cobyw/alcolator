//
//  ViewController.m
//  Alcolator
//
//  Created by Coby West on 3/23/15.
//  Copyright (c) 2015 Bloc. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()


@property (weak, nonatomic) IBOutlet UITextField *beerPercentTextField;

@property (weak, nonatomic) IBOutlet UISlider *beerCountSlider;

@property (weak, nonatomic) IBOutlet UILabel *restultsLabel;

@property (weak, nonatomic) IBOutlet UILabel *numberOfBeersLabel;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)textFieldDidChange:(UITextField *)sender {
    //Makes sure its a number
    NSString *enteredText = sender.text;
    float enteredNumber = [enteredText floatValue];
    
    if (enteredNumber == 0)
    {
        //user either typed zero or not a number so clear it
        sender.text = nil;
    }
}

- (IBAction)sliderValueDidChange:(UISlider *)sender {
    NSLog(@"Slider value changed to %f", sender.value);
    int intBeerNumberFromSlider = sender.value;
    NSString *sliderValue = [NSString stringWithFormat: @"%d", intBeerNumberFromSlider];
    self.numberOfBeersLabel.text = sliderValue;
    [self.beerPercentTextField resignFirstResponder];
}

- (IBAction)buttonPressed:(UIButton *)sender {
    [self.beerPercentTextField resignFirstResponder];
    
    //first calculate the alcohol in the beers
    
    int numberOfBeers = self.beerCountSlider.value;
    int ouncesInOneBeerGlass = 12; //assumes they are 12 oz units of beer
    
    float alcoholPercentageOfBeer = [self.beerPercentTextField.text floatValue] / 100;
    float ouncesOfAlcoholPerBeer = ouncesInOneBeerGlass * alcoholPercentageOfBeer;
    float ouncesOfAlcoholTotal = ouncesOfAlcoholPerBeer * numberOfBeers;
    
    //now figure out how much wine that is
    
    float ouncesInOneWineGlass = 5; //assume the wine glass is 5 oz
    float alcoholPercentageOfWine = 0.13; //assume 13%
    
    float ouncesOfAlcoholPerWineGlass = ouncesInOneWineGlass * alcoholPercentageOfWine;
    float numberOfWineGlassesEquivalent = ouncesOfAlcoholTotal / ouncesOfAlcoholPerWineGlass;
    
    
    //chooses to display the correct string for the number of beers/wine glasses
    NSString *beerText;
    
    if (numberOfBeers ==1)
    {
        beerText = NSLocalizedString(@"beer", @"singluar beer");
    }
    else
    {
        beerText = NSLocalizedString(@"beers", @"plural of beer");
    }
    
    NSString *wineText;
    
    if (numberOfWineGlassesEquivalent == 1)
    {
        wineText = NSLocalizedString(@"glass", @"singular glass");
    }
    else
    {
        wineText = NSLocalizedString(@"glasses", @"plural of glass");
    }
    
    //generate the result text and display it on the label
    
    NSString *resultText = [NSString stringWithFormat:NSLocalizedString(@"%d %@ contains as much alcohol as %.1f %@ of wine.", nil), numberOfBeers, beerText, numberOfWineGlassesEquivalent, wineText];
    self.restultsLabel.text = resultText;
}

- (IBAction)tapGestureDidFire:(UITapGestureRecognizer *)sender {
    [self.beerPercentTextField resignFirstResponder];
}


@end
























