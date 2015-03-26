//
//  WhiskeyViewController.m
//  Alcolator
//
//  Created by Coby West on 3/25/15.
//  Copyright (c) 2015 Bloc. All rights reserved.
//

#import "WhiskeyViewController.h"

@interface WhiskeyViewController ()

@end

@implementation WhiskeyViewController

- (void)buttonPressed:(UIButton *)sender;
{
    [self.beerPercentTextField resignFirstResponder];
    
    int numberOfBeers = self.beerCountSlider.value;
    int ouncesInOneBeerGlass =12;
    
    float alcoholPercentageOfBeer = [self.beerPercentTextField.text floatValue] /100.;
    float ouncesOfAlcoholPerBeer = ouncesInOneBeerGlass * alcoholPercentageOfBeer;
    float ouncesOfAlcoholTotal = ouncesOfAlcoholPerBeer * numberOfBeers;
    
    float ouncesInOneWhiskeyGlass = 1;
    float alcoholPercentageOfWhiskey = 0.4;
    
    float ouncesOfAlcoholPerWhiskeyGlass = ouncesInOneWhiskeyGlass * alcoholPercentageOfWhiskey;
    float numberOfWhiskeyGlassesForEquivalentAlcoholAmount = ouncesOfAlcoholTotal / ouncesOfAlcoholPerWhiskeyGlass;
    int equivWhiskeyGlassInt = numberOfWhiskeyGlassesForEquivalentAlcoholAmount;
    
    float remainderWhiskey = numberOfWhiskeyGlassesForEquivalentAlcoholAmount - equivWhiskeyGlassInt;
    //rounds up if the remaining wine is greater than .5
    if (remainderWhiskey >=.5)
    {
        equivWhiskeyGlassInt++;
        
    }
    
    
    NSString *beerText;
    
    if (numberOfBeers ==1)
    {
        beerText = NSLocalizedString(@"beer", @"singluar beer");
    }
    else
    {
        beerText = NSLocalizedString(@"beers", @"plural of beer");
    }
    
    NSString *whiskeyText;
    
    if (equivWhiskeyGlassInt == 1)
    {
        whiskeyText = NSLocalizedString(@"shot", @"singular shot");
    }
    else
    {
        whiskeyText = NSLocalizedString(@"shots", @"plural of shot");
    }
    
    NSString *resultText = [NSString stringWithFormat:NSLocalizedString(@"%d %@ contains as much alcohol as %d %@ of whiskey.", nil), numberOfBeers, beerText, equivWhiskeyGlassInt, whiskeyText];
    self.resultsLabel.text = resultText;
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
