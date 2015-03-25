//
//  ViewController.m
//  Alcolator
//
//  Created by Coby West on 3/23/15.
//  Copyright (c) 2015 Bloc. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITextFieldDelegate>


@property (weak, nonatomic) UITextField *beerPercentTextField;

@property (weak, nonatomic) UISlider *beerCountSlider;

@property (weak, nonatomic) UILabel *resultsLabel;

@property (weak, nonatomic) UILabel *numberOfBeersLabel;

@property (weak, nonatomic) UIButton *calculateButton;

@property (weak, nonatomic) UITapGestureRecognizer *hideKeyboardTapGestureRecognizer;


@end

@implementation ViewController

- (void)loadView {
    //Allocate and initialize The Overarching View
    self.view = [[UIView alloc] init];
    
    //allocate and initialize the little sub views AND the gesture recognizer
    UITextField *textField =[[UITextField alloc] init];
    UISlider *slider =[[UISlider alloc] init];
    UILabel *label = [[UILabel alloc] init];
    UIButton *button = [[UIButton alloc] init];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    
    //add each view and the gesture recognizer as subviews in The View
    [self.view addSubview:textField];
    [self.view addSubview:slider];
    [self.view addSubview:label];
    [self.view addSubview:button];
    [self.view addGestureRecognizer:tap];
    
    //Assign the views and gesture recognizer to our properties
    self.beerPercentTextField = textField;
    self.beerCountSlider = slider;
    self.resultsLabel = label;
    self.calculateButton = button;
    self.hideKeyboardTapGestureRecognizer = tap;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //set the background color to light grey
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    // not sure what this is doing, something about deligating the textfield to the view?
    self.beerPercentTextField.delegate = self;
    
    //sets the placeholder text
    self.beerPercentTextField.placeholder = NSLocalizedString(@"Alcohol Content Per Beer" , @"Beer percent placeholder Text");
    
    self.beerPercentTextField.text = @"Test string here!";
    
    //sets the minimum and maximum number of beers
    self.beerCountSlider.minimumValue = 1;
    self.beerCountSlider.maximumValue =10;
    
    //Tells self.calculatebutton that when a finger is lifted from the button while inside the bounds to call self.buttonpressed
    [self.calculateButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    //Sets the button title
    [self.calculateButton setTitle:NSLocalizedString(@"Calculate", @"calculate command") forState:UIControlStateNormal];
    
    //Tells the tap gesture recognizer to call self.tapGestureDidFire when it detects a tap
    [self.hideKeyboardTapGestureRecognizer addTarget:self action:@selector(tapGestureDidFire:)];
    
    //Gets rid of the maximum number of lines on the label
    self.resultsLabel.numberOfLines =0;
}

-(void) viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    CGFloat viewWidth =320;
    CGFloat padding = 20;
    CGFloat itemWidth = viewWidth - padding - padding;
    CGFloat itemHeight = 44;
    
    self.beerPercentTextField.frame = CGRectMake(padding, padding, itemWidth, itemHeight);
    
    CGFloat bottomOfTextField = CGRectGetMaxY(self.beerPercentTextField.frame);
    self.beerCountSlider.frame = CGRectMake(padding, bottomOfTextField+padding, itemWidth, itemHeight);
    
    CGFloat bottomOfSlider = CGRectGetMaxY(self.beerCountSlider.frame);
    self.resultsLabel.frame = CGRectMake(padding, bottomOfSlider+padding, itemWidth, itemHeight);
    
    CGFloat bottomOfLabel = CGRectGetMaxY(self.resultsLabel.frame);
    self.calculateButton.frame = CGRectMake(padding, bottomOfLabel+padding, itemWidth, itemHeight);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)textFieldDidChange:(UITextField *)sender {
    //Makes sure its a number
    NSString *enteredText = sender.text;
    float enteredNumber = [enteredText floatValue];
    
    if (enteredNumber == 0)
    {
        //user either typed zero or not a number so clear it
        sender.text = nil;
    }
}

- (void)sliderValueDidChange:(UISlider *)sender {
    NSLog(@"Slider value changed to %f", sender.value);
    //this isnt getting called?
    int intBeerNumberFromSlider = sender.value;
    NSString *sliderValue = [NSString stringWithFormat: @"%d", intBeerNumberFromSlider];
    self.numberOfBeersLabel.text = sliderValue;
    [self.beerPercentTextField resignFirstResponder];

}

- (void)buttonPressed:(UIButton *)sender {
    [self.beerPercentTextField resignFirstResponder];
    
    //first calculate the alcohol in the beers
    
    int numberOfBeers = self.beerCountSlider.value;
    int ouncesInOneBeerGlass = 12; //assumes they are 12 oz units of beer
    
    float alcoholPercentageOfBeer = /*[self.beerPercentTextField.text floatValue]*/5 / 100.;
    NSLog(@"Alcohol percentage of beer is %f", alcoholPercentageOfBeer);
    float ouncesOfAlcoholPerBeer = ouncesInOneBeerGlass * alcoholPercentageOfBeer;
    NSLog(@"ounces of alchohol per beer is %f", ouncesOfAlcoholPerBeer);
    float ouncesOfAlcoholTotal = ouncesOfAlcoholPerBeer * numberOfBeers;
    NSLog(@"ounces of alcohol total is %f", ouncesOfAlcoholTotal);
    
    //now figure out how much wine that is
    
    float ouncesInOneWineGlass = 5; //assume the wine glass is 5 oz
    float alcoholPercentageOfWine = 0.13; //assume 13%
    
    float ouncesOfAlcoholPerWineGlass = ouncesInOneWineGlass * alcoholPercentageOfWine;
    float numberOfWineGlassesEquivalent = ouncesOfAlcoholTotal / ouncesOfAlcoholPerWineGlass;
    NSLog(@"number of wine glasses equic %f", numberOfWineGlassesEquivalent);
    
    //sets it as an int for better viewing, also rounding!
    int wineGlassesEquiv = numberOfWineGlassesEquivalent;
    float remainderWine = numberOfWineGlassesEquivalent - wineGlassesEquiv;
    NSLog(@"remainderWine is %f", remainderWine);
    //rounds up if the remaining wine is greater than .5
    if (remainderWine >=.5)
    {
        wineGlassesEquiv++;
        NSLog(@"The wine glasses round up!");
        
    }
    NSLog(@"wine glassses as an int %d", wineGlassesEquiv);
    
    
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
    
    if (wineGlassesEquiv == 1)
    {
        wineText = NSLocalizedString(@"glass", @"singular glass");
    }
    else
    {
        wineText = NSLocalizedString(@"glasses", @"plural of glass");
    }
    
    //generate the result text and display it on the label
    
    NSString *resultText = [NSString stringWithFormat:NSLocalizedString(@"%d %@ contains as much alcohol as %d %@ of wine.", nil), numberOfBeers, beerText, wineGlassesEquiv, wineText];
    self.resultsLabel.text = resultText;
}

- (void)tapGestureDidFire:(UITapGestureRecognizer *)sender {
    [self.beerPercentTextField resignFirstResponder];
}


@end
























