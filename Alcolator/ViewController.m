//
//  ViewController.m
//  Alcolator
//
//  Created by Coby West on 3/23/15.
//  Copyright (c) 2015 Bloc. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITextFieldDelegate>


@property (weak, nonatomic) UILabel *numberOfBeersLabel;

@property (weak, nonatomic) UIButton *calculateButton;

@property (weak, nonatomic) UITapGestureRecognizer *hideKeyboardTapGestureRecognizer;



@end

@implementation ViewController

-(instancetype) init
{
    self = [super init];
    
    if (self)
    {
        self.title = NSLocalizedString(@"Wine", @"wine" );
    }
    
    [self.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -18)];
    
    return self;
}

- (void)loadView {
    //Allocate and initialize The Overarching View
    self.view = [[UIView alloc] init];
    
    //allocate and initialize the little sub views AND the gesture recognizer
    UITextField *textField =[[UITextField alloc] init];
    UISlider *slider =[[UISlider alloc] init];
    UILabel *label = [[UILabel alloc] init];
    UILabel *numBeersLabel = [[UILabel alloc] init];
    UIButton *button = [[UIButton alloc] init];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    
    
    
    //add each view and the gesture recognizer as subviews in The View
    [self.view addSubview:textField];
    [self.view addSubview:slider];
    [self.view addSubview:label];
    [self.view addSubview:numBeersLabel];
    [self.view addSubview:button];
    [self.view addGestureRecognizer:tap];
    
    
    //Assign the views and gesture recognizer to our properties
    self.beerPercentTextField = textField;
    self.beerCountSlider = slider;
    self.resultsLabel = label;
    self.numberOfBeersLabel = numBeersLabel;
    self.calculateButton = button;
    self.hideKeyboardTapGestureRecognizer = tap;
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    //set the background color to light grey
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    //makes the text field white and sets the delagate
    self.beerPercentTextField.backgroundColor = [UIColor whiteColor];
    self.beerPercentTextField.delegate = self;
    
    //sets the placeholder text
    self.beerPercentTextField.placeholder = NSLocalizedString(@"Alcohol Content Per Beer, 5%" , @"Beer percent placeholder Text");
    
    //sets the minimum and maximum number of beers
    self.beerCountSlider.minimumValue = 1;
    self.beerCountSlider.maximumValue =10;
    
    //calls the let go of slider thing
    [self.beerCountSlider addTarget:self action:@selector(sliderValueDidChange:) forControlEvents:(UIControlEventValueChanged)];
    
    
    //Tells self.calculatebutton that when a finger is lifted from the button while inside the bounds to call self.buttonpressed
    [self.calculateButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    //Sets the button title
    [self.calculateButton setTitle:NSLocalizedString(@"Calculate", @"calculate command") forState:UIControlStateNormal];
    self.calculateButton.backgroundColor = [UIColor blackColor];
    
    //Tells the tap gesture recognizer to call self.tapGestureDidFire when it detects a tap
    [self.hideKeyboardTapGestureRecognizer addTarget:self action:@selector(tapGestureDidFire:)];
    
    //Gets rid of the maximum number of lines on the label
    self.resultsLabel.numberOfLines =0;
    
}

-(void) viewWillAppear:(BOOL)animated
{
    NSLog(@"New view controller selected: %@", self.title);
}

-(void) viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    
    CGFloat viewWidth = screenRect.size.width;
    CGFloat padding = 20;
    CGFloat itemWidth = viewWidth - padding - padding;
    CGFloat itemHeight = 44;
    CGFloat buttonSize = 200;
    CGFloat buttonCenterer = (viewWidth - buttonSize)/2;
    
    self.beerPercentTextField.frame = CGRectMake(padding, itemHeight + padding + padding, itemWidth, itemHeight);
    
    CGFloat bottomOfTextField = CGRectGetMaxY(self.beerPercentTextField.frame);
    self.beerCountSlider.frame = CGRectMake(padding, bottomOfTextField+padding, itemWidth, itemHeight);
    
    
    CGFloat bottomOfSlider = CGRectGetMaxY(self.beerCountSlider.frame);
    self.numberOfBeersLabel.frame = CGRectMake(padding, bottomOfSlider + padding, itemWidth, itemHeight);
    
    CGFloat bottomOfBearsLabel = CGRectGetMaxY(self.numberOfBeersLabel.frame);
    self.resultsLabel.frame = CGRectMake(padding, bottomOfBearsLabel+padding, itemWidth, itemHeight);
    
    
    CGFloat bottomOfLabel = CGRectGetMaxY(self.resultsLabel.frame);
    self.calculateButton.frame = CGRectMake(buttonCenterer, bottomOfLabel+padding, buttonSize, itemHeight);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/* No longer gets called
- (void)textFieldDidChange:(UITextField *)sender {
    //Makes sure its a number
    NSLog(@"Calls function");
    NSString *enteredText = sender.text;
    float enteredNumber = [enteredText floatValue];
    
    if (enteredNumber == 0)
    {
        //user either typed zero or not a number so clear it
        sender.text = nil;
        NSLog(@"Calls if running");
    }
}
*/

- (void)sliderValueDidChange:(NSNotification*)notification {

     int intBeerNumberFromSlider = self.beerCountSlider.value;
     NSString *sliderValue = [NSString stringWithFormat: @"%d beers", intBeerNumberFromSlider];
     self.numberOfBeersLabel.text = sliderValue;
    [self.beerPercentTextField resignFirstResponder];
    [self.tabBarItem setBadgeValue:[NSString stringWithFormat:@"%d", intBeerNumberFromSlider]];
     
    
}

- (void)buttonPressed:(UIButton *)sender {
    [self.beerPercentTextField resignFirstResponder];
    
    int numberOfBeers = self.beerCountSlider.value;
    
    
    int ouncesInOneBeerGlass = 12; //assumes they are 12 oz units of beer
    
    //first calculate the alcohol in the beers
    float percentText = [self.beerPercentTextField.text floatValue];
    float alcoholPercentageOfBeer =  percentText / 100.;
    if (alcoholPercentageOfBeer == 0)
    {
        alcoholPercentageOfBeer = 5/100.;
    }
    
    self.beerPercentTextField.text = [NSString stringWithFormat:@"%.01f %%", alcoholPercentageOfBeer * 100];
/*
    //adds a label for how many beers, updates when the button is pushed
    NSString *sliderValue = [NSString stringWithFormat: @"%d", numberOfBeers];
    self.numberOfBeersLabel.text = sliderValue;
 */
        
    NSLog(@"Alcohol percentage of beer is %.01f", alcoholPercentageOfBeer);
    float ouncesOfAlcoholPerBeer = ouncesInOneBeerGlass * alcoholPercentageOfBeer;
    NSLog(@"ounces of alchohol per beer is %.01f", ouncesOfAlcoholPerBeer);
    float ouncesOfAlcoholTotal = ouncesOfAlcoholPerBeer * numberOfBeers;
    NSLog(@"ounces of alcohol total is %f", ouncesOfAlcoholTotal);
    
    //now figure out how much wine that is
    
    float ouncesInOneWineGlass = 5; //assume the wine glass is 5 oz
    float alcoholPercentageOfWine = 0.13; //assume 13%
    
    float ouncesOfAlcoholPerWineGlass = ouncesInOneWineGlass * alcoholPercentageOfWine;
    float numberOfWineGlassesEquivalent = ouncesOfAlcoholTotal / ouncesOfAlcoholPerWineGlass;
    NSLog(@"number of wine glasses equiv %.01f", numberOfWineGlassesEquivalent);
    
   /*
    //sets it as an int for better viewing, also rounding! - removed, switched the output to a float
    
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
    */
    
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
    
    NSString *resultText = [NSString stringWithFormat:NSLocalizedString(@"%d %@ contains as much alcohol as %.01f %@ of wine.", nil), numberOfBeers, beerText, numberOfWineGlassesEquivalent, wineText];
    self.resultsLabel.text = resultText;
}

- (void)tapGestureDidFire:(UITapGestureRecognizer *)sender {
    [self.beerPercentTextField resignFirstResponder];
}


@end