//
//  AerServCustomEventInterstitial.m
//  ios-sdk-admob-plugin
//
//  Created by Hall on 9/20/16.
//  Copyright © 2016 Aerserv. All rights reserved.
//

#import "AerServCustomEventInterstitial.h"

#define kLOG_TAG @"AERSERV SDK"

@interface AerServCustomEventInterstitial() <GADCustomEventInterstitial, ASInterstitialViewControllerDelegate>

@property(nonatomic, retain) ASInterstitialViewController* adController;
@property(nonatomic, assign) BOOL adLoaded;

@end

@implementation AerServCustomEventInterstitial

@synthesize delegate;

#pragma mark - GADCustomEventInterstitial
- (void)requestInterstitialAdWithParameter:(NSString *)serverParameter
                                     label:(NSString *)serverLabel
                                   request:(GADCustomEventRequest *)request {
  
  @try {
  // Parse ServerParameter
  NSString* PLC = [AerServUtils getPLC:serverParameter];
  if (PLC == nil) {
    [self.delegate customEventInterstitial:self
                                 didFailAd:[AerServExceptions InvalidRequest]];
  }
  self.adController = [ASInterstitialViewController viewControllerForPlacementID:PLC
                                                                    withDelegate:self];
    
  //Interstitial config
  self.adController.isPreload = YES;
    
  //Loading Request
  [self.adController loadAd];
  }
  @catch (NSException *e) {
   [self.delegate customEventInterstitial:self
                                didFailAd:[AerServExceptions InvalidRequest]];
  }
}

- (void)presentFromRootViewController:(UIViewController *)rootViewController {
  if(self.adLoaded) {
    [self.adController showFromViewController:rootViewController];
  } else {
    NSLog(@"Ad is not ready.");
  }
}

#pragma mark - AerServ Interstitial Delegate
- (void)interstitialViewControllerDidPreloadAd:(ASInterstitialViewController *)viewController {
  self.adLoaded = YES;
  [self.delegate customEventInterstitialDidReceiveAd:self];
}

- (void)interstitialViewControllerAdFailedToLoad:(ASInterstitialViewController *)viewController
                                       withError:(NSError *)error; {
  self.adLoaded = NO;
  [self.delegate customEventInterstitial:self
                               didFailAd:[AerServExceptions InvalidRequest]];
}

- (void)interstitialViewControllerWillAppear:(ASInterstitialViewController *)viewController {
  [self.delegate customEventInterstitialWillPresent:self];
}

- (void)interstitialViewControllerWillDisappear:(ASInterstitialViewController *)viewController {
  self.adLoaded = NO;
  [self.delegate customEventInterstitialWillDismiss:self];
}

- (void)interstitialViewControllerDidDisappear:(ASInterstitialViewController *)viewController {
  [self.delegate customEventInterstitialDidDismiss:self];
}

- (void)interstitialViewControllerAdWasTouched:(ASInterstitialViewController *)viewController {
  [self.delegate customEventInterstitialWasClicked:self];
  [self.delegate customEventInterstitialWillLeaveApplication:self];
}

@end
