//
//  ViewController.m
//  windwalker
//
//  Created by Jason C on 6/22/18.
//  Copyright © 2018 Jason C. All rights reserved.
//

#import "ViewController.h"
@import GoogleMobileAds;

@interface ViewController () <GADBannerViewDelegate, GADInterstitialDelegate, GADRewardBasedVideoAdDelegate>

@property(nonatomic, strong) GADInterstitial *interstitial;
@property (weak, nonatomic) IBOutlet UIButton *showInterstitial;
@property(nonatomic, strong) GADBannerView *bannerView;




@end

@implementation ViewController

    NSString *logTag = @"WindWalker~~";
    NSString *ADMOB_BANNER = @"ca-app-pub-2877795938017911/9210459939";
    NSString *ADMOB_Interstitial = @"ca-app-pub-2877795938017911/8638494736";
    NSString *ADMOB_Rewarded = @"ca-app-pub-2877795938017911/2241308433";



/*
 Admob Test Banner:         ca-app-pub-2877795938017911/9210459939
 Admob Test Interstitial:   ca-app-pub-2877795938017911/8638494736
 Admob Test Rewarded:       ca-app-pub-2877795938017911/2241308433
 */


// On view load, we want to preload an interstitial object
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Control what we load here as an example:
   
    // TEST BANNER
    self.bannerView = [[GADBannerView alloc]
                       initWithAdSize:kGADAdSizeBanner];
    self.bannerView.adUnitID = ADMOB_BANNER;
    self.bannerView.rootViewController = self;
    self.bannerView.delegate = self;
    [self.bannerView loadRequest:[GADRequest request]];
    [self addBannerViewToView:self.bannerView];
    
    // TEST INTERSTITIAL
    // self.interstitial = [self createAndLoadInterstitial];
    
    // TEST REWARDED
    // [self createAndLoadGADRewardBasedVideoAd];
    
}


// TODO: Memory clean up
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




// Banner Methods and delegate methods

- (void)addBannerViewToView:(UIView *)bannerView {
    bannerView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:bannerView];
    [self.view addConstraints:@[
                                [NSLayoutConstraint constraintWithItem:bannerView
                                                             attribute:NSLayoutAttributeBottom
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self.bottomLayoutGuide
                                                             attribute:NSLayoutAttributeTop
                                                            multiplier:1
                                                              constant:0],
                                [NSLayoutConstraint constraintWithItem:bannerView
                                                             attribute:NSLayoutAttributeCenterX
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self.view
                                                             attribute:NSLayoutAttributeCenterX
                                                            multiplier:1
                                                              constant:0]
                                ]];
}


/// Tells the delegate an ad request loaded an ad.
- (void)adViewDidReceiveAd:(GADBannerView *)adView {
//    NSLog(@"adViewDidReceiveAd");
    NSLog(@"%@", [logTag stringByAppendingString:@"adViewDidReceiveAd"]);

}

/// Tells the delegate an ad request failed.
- (void)adView:(GADBannerView *)adView
didFailToReceiveAdWithError:(GADRequestError *)error {
//    NSLog(@"adView:didFailToReceiveAdWithError: %@", [error localizedDescription]);
    NSLog(@"%@", [logTag stringByAppendingString:@"didFailToReceiveAdWithError"]);

}

/// Tells the delegate that a full-screen view will be presented in response
/// to the user clicking on an ad.
- (void)adViewWillPresentScreen:(GADBannerView *)adView {
    NSLog(@"adViewWillPresentScreen");
    NSLog(@"%@", [logTag stringByAppendingString:@"adViewWillPresentScreen"]);

}

/// Tells the delegate that the full-screen view will be dismissed.
- (void)adViewWillDismissScreen:(GADBannerView *)adView {
    NSLog(@"adViewWillDismissScreen");
    NSLog(@"%@", [logTag stringByAppendingString:@"adViewWillDismissScreen"]);

}

/// Tells the delegate that the full-screen view has been dismissed.
- (void)adViewDidDismissScreen:(GADBannerView *)adView {
    NSLog(@"adViewDidDismissScreen");
    NSLog(@"%@", [logTag stringByAppendingString:@"adViewDidDismissScreen"]);

}

/// Tells the delegate that a user click will open another app (such as
/// the App Store), backgrounding the current app.
- (void)adViewWillLeaveApplication:(GADBannerView *)adView {
    NSLog(@"adViewWillLeaveApplication");
    NSLog(@"%@", [logTag stringByAppendingString:@"adViewWillLeaveApplication"]);

}



// NOTE: AdMob interstitials are one time use only. We must continue to make new GADInterstitial objects each time.
- (GADInterstitial *)createAndLoadInterstitial {
    
    // Allocate a new interstitial with a sample AdUnitID
    GADInterstitial *interstitial =
    [[GADInterstitial alloc] initWithAdUnitID:ADMOB_Interstitial];
    
    // Subscribe this interstitial to delegate callback methods so we can listen for the load / dismissed
    interstitial.delegate = self;
    
    // Create a request in the view scope and load the interstitial with the AdUnitID specified above
    [interstitial loadRequest:[GADRequest request]];
    NSLog(@"%@", [logTag stringByAppendingString:@"viewDidLoad - interstitial load request made"]);

    return interstitial;
    
}


-(void)createAndLoadGADRewardBasedVideoAd {
    [GADRewardBasedVideoAd sharedInstance].delegate = self;
    [[GADRewardBasedVideoAd sharedInstance] loadRequest:[GADRequest request]
                                           withAdUnitID:ADMOB_Rewarded];
}

// This IBAction is triggered on button press.
- (IBAction)doShowInterstitial:(id)sender {
    
    // IfGADRewardBasedVideoAd
    if ([[GADRewardBasedVideoAd sharedInstance] isReady]) {
        [[GADRewardBasedVideoAd sharedInstance] presentFromRootViewController:self];
        NSLog(@"%@", [logTag stringByAppendingString:@"doShowInterstitial - Ad is ready and is shown"]);

    } else {
        NSLog(@"%@", [logTag stringByAppendingString:@"doShowInterstitial - Ad wasn't ready"]);
    }
    
    // Ifinterstitial
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
     NSLog(@"interstitial:didFailToReceiveAdWithError: %@", [error localizedDescription]);
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


#pragma mark - GADInterstitial Delegate Callback Methods


- (void)rewardBasedVideoAd:(GADRewardBasedVideoAd *)rewardBasedVideoAd
   didRewardUserWithReward:(GADAdReward *)reward {
    NSString *rewardMessage =
    [NSString stringWithFormat:@"Reward received with currency %@ , amount %lf",
     reward.type,
     [reward.amount doubleValue]];
    NSLog(rewardMessage);
}

- (void)rewardBasedVideoAdDidReceiveAd:(GADRewardBasedVideoAd *)rewardBasedVideoAd {
    NSLog(@"Reward based video ad is received.");
}

- (void)rewardBasedVideoAdDidOpen:(GADRewardBasedVideoAd *)rewardBasedVideoAd {
    NSLog(@"Opened reward based video ad.");
}

- (void)rewardBasedVideoAdDidStartPlaying:(GADRewardBasedVideoAd *)rewardBasedVideoAd {
    NSLog(@"Reward based video ad started playing.");
}

- (void)rewardBasedVideoAdDidCompletePlaying:(GADRewardBasedVideoAd *)rewardBasedVideoAd {
    NSLog(@"Reward based video ad has completed.");
}

- (void)rewardBasedVideoAdDidClose:(GADRewardBasedVideoAd *)rewardBasedVideoAd {
    NSLog(@"Reward based video ad is closed.");
}

- (void)rewardBasedVideoAdWillLeaveApplication:(GADRewardBasedVideoAd *)rewardBasedVideoAd {
    NSLog(@"Reward based video ad will leave application.");
}

- (void)rewardBasedVideoAd:(GADRewardBasedVideoAd *)rewardBasedVideoAd
    didFailToLoadWithError:(NSError *)error {
    NSLog(@"Reward based video ad failed to load.");
}

@end
