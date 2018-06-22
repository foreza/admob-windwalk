//
//  ViewController.m
//  windwalker
//
//  Created by Jason C on 6/22/18.
//  Copyright © 2018 Jason C. All rights reserved.
//

#import "ViewController.h"
@import GoogleMobileAds;

@interface ViewController () <GADInterstitialDelegate>

@property(nonatomic, strong) GADInterstitial *interstitial;
@property (weak, nonatomic) IBOutlet UIButton *showInterstitial;


@end

@implementation ViewController

    NSString *logTag = @"WindWalker~~";

// On view load, we want to preload an interstitial object
- (void)viewDidLoad {
    [super viewDidLoad];
    self.interstitial = [self createAndLoadInterstitial];
}


// TODO: Memory clean up
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



// NOTE: AdMob interstitials are one time use only. We must continue to make new GADInterstitial objects each time.
- (GADInterstitial *)createAndLoadInterstitial {
    
    // Allocate a new interstitial with a sample AdUnitID
    GADInterstitial *interstitial =
    [[GADInterstitial alloc] initWithAdUnitID:@"ca-app-pub-3940256099942544/4411468910"];
    
    // Subscribe this interstitial to delegate callback methods so we can listen for the load / dismissed
    interstitial.delegate = self;
    
    // Create a request in the view scope and load the interstitial with the AdUnitID specified above
    [interstitial loadRequest:[GADRequest request]];
    NSLog(@"%@", [logTag stringByAppendingString:@"viewDidLoad - interstitial load request made"]);

    return interstitial;
}


// This IBAction is triggered on button press.
- (IBAction)doShowInterstitial:(id)sender {
    if (self.interstitial.isReady) {
        [self.interstitial presentFromRootViewController:self];
        NSLog(@"%@", [logTag stringByAppendingString:@"doShowInterstitial - Ad is ready and is shown"]);

    } else {
        NSLog(@"%@", [logTag stringByAppendingString:@"doShowInterstitial - Ad wasn't ready"]);
    }
}


#pragma mark - GADInterstitial Delegate Callback Methods

// This delegate function is called when the interstitial is dismissed
- (void)interstitialDidDismissScreen:(GADInterstitial *)interstitial {
    self.interstitial = [self createAndLoadInterstitial];
    NSLog(@"%@", [logTag stringByAppendingString:@"interstitialDidDismissScreen, call createAndLoadInterstitial"]);
}

/// Tells the delegate an ad request succeeded.
- (void)interstitialDidReceiveAd:(GADInterstitial *)ad {
    NSLog(@"%@", [logTag stringByAppendingString:@"interstitialDidReceiveAd"]);
}

/// Tells the delegate an ad request failed.
- (void)interstitial:(GADInterstitial *)ad
didFailToReceiveAdWithError:(GADRequestError *)error {
    // NSLog(@"interstitial:didFailToReceiveAdWithError: %@", [error localizedDescription]);
    NSLog(@"%@", [logTag stringByAppendingString:@"didFailToReceiveAdWithError"], [error localizedDescription]);

}

/// Tells the delegate that an interstitial will be presented.
- (void)interstitialWillPresentScreen:(GADInterstitial *)ad {
    NSLog(@"%@", [logTag stringByAppendingString:@"interstitialWillPresentScreen"]);

}

/// Tells the delegate the interstitial is to be animated off the screen.
- (void)interstitialWillDismissScreen:(GADInterstitial *)ad {
    NSLog(@"%@", [logTag stringByAppendingString:@"interstitialWillDismissScreen"]);

}

/// Tells the delegate that a user click will open another app
/// (such as the App Store), backgrounding the current app.
- (void)interstitialWillLeaveApplication:(GADInterstitial *)ad {
    NSLog(@"%@", [logTag stringByAppendingString:@"interstitialWillLeaveApplication"]);

}

@end
