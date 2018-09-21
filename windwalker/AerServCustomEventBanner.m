//
//  AerServCustomEventBanner.m
//  ios-sdk-admob-plugin
//
//  Created by Hall on 9/20/16.
//  Copyright © 2016 Aerserv. All rights reserved.
//

#import "AerServCustomEventBanner.h"

#define kLOG_TAG @"AERSERV SDK"

@interface AerServCustomEventBanner() <GADCustomEventBanner, ASAdViewDelegate>

@property (nonatomic, retain) ASAdView *banner;

@end

@implementation AerServCustomEventBanner

@synthesize delegate;

#pragma mark - GADCustomEventBanner
- (void)requestBannerAd:(GADAdSize)adSize
              parameter:(NSString *)serverParameter
                  label:(NSString *)serverLabel
                request:(GADCustomEventRequest *)request {
  
  @try {
    // Parse ServerParameter
    NSString *PLC = [AerServUtils getPLC:serverParameter];
    if (PLC == nil) {
      [self.delegate customEventBanner:self
                             didFailAd:[AerServExceptions InvalidRequest]];
    }
    self.banner = [ASAdView viewWithPlacementID:PLC andAdSize:adSize.size];
    //Banner config
    self.banner.delegate = self;
    self.banner.bannerRefreshTimeInterval = 0;
    self.banner.sizeAdToFit = YES;
    [self.banner loadAd];
  }
  @catch (NSException *e) {
    [self.delegate customEventBanner:self
                           didFailAd:[AerServExceptions InvalidRequest]];
  }
}

#pragma mark - AerServ Banner Delegate
- (UIViewController *)viewControllerForPresentingModalView {
  return [self.delegate viewControllerForPresentingModalView];
}

- (void)adViewDidLoadAd:(ASAdView *)adView {
  [self.delegate customEventBanner:self
                      didReceiveAd:adView];
}

- (void)adViewDidFailToLoadAd:(ASAdView *)adView withError:(NSError *)error {
  [self.delegate customEventBanner:self
                         didFailAd:[AerServExceptions NoFill]];
}

- (void)willPresentModalViewForAd:(ASAdView *)adView {
  [self.delegate customEventBannerWillPresentModal:self];
}

- (void)didDismissModalViewForAd:(ASAdView *)adView {
  [self.delegate customEventBannerDidDismissModal:self];
}

- (void)adWasClicked:(ASAdView *)adView {
  [self.delegate customEventBannerWasClicked:self];
}

- (void)willLeaveApplicatonFromAd:(ASAdView *)adView {
  [self.delegate customEventBannerWillLeaveApplication:self];
}

@end
