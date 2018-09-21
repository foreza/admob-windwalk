//
//  AerServCustomEventRewardedInterstitial.m
//  ios-sdk-admob-plugin
//
//  Created by Hall on 9/29/16.
//  Copyright © 2016 Aerserv. All rights reserved.
//

#import "AerServCustomEventRewardedInterstitial.h"

#define kServerParameter @"parameter"
#define kVCAmount @"rewardAmount"
#define kVCName @"name"
#define kSDKSleepAfterInitSecond 1.0f

@interface AerServCustomEventRewardedInterstitial() <ASInterstitialViewControllerDelegate>

@property(nonatomic, strong) ASInterstitialViewController *interstitial;
@property(nonatomic, weak) id<GADMRewardBasedVideoAdNetworkConnector> _connector;
@property(nonatomic, strong) GADAdReward *reward;
@property(nonatomic, assign) BOOL adLoaded;

@end

@implementation AerServCustomEventRewardedInterstitial

#pragma mark - GADMRewardBasedVideoAdNetworkAdapter
+ (NSString *)adapterVersion {
  return @"1.0.0";
}

+ (Class<GADAdNetworkExtras>)networkExtrasClass {
  return [AerservExtras class];
}

- (instancetype)initWithRewardBasedVideoAdNetworkConnector:(id<GADMRewardBasedVideoAdNetworkConnector>)connector {
  if(!connector) {
    return nil;
  }
  self = [super init];
  if (self) {
    self._connector = connector;
  }
  return self;
}

- (void)setUp {
  // Parser Server Parameter
  NSString *siteId = [AerServUtils getSiteId:[self._connector.credentials objectForKey:kServerParameter]];
  
  // Initialize the AerServSDK if SiteID is avaliable
  if(siteId != nil) {
    [AerServSDK initializeWithAppID:siteId];
    [NSThread sleepForTimeInterval:kSDKSleepAfterInitSecond];
  }
  [self._connector adapterDidSetUpRewardBasedVideoAd:self];
}

- (void)requestRewardBasedVideoAd {
  @try {
    self.adLoaded = NO;
    
    NSString *plc = [AerServUtils getPLC:[self._connector.credentials objectForKey:kServerParameter]];
    if(plc == nil) {
      [self._connector adapter:self didFailToLoadRewardBasedVideoAdwithError:[AerServExceptions InvalidRequest]];
    }
      
    self.interstitial = [ASInterstitialViewController viewControllerForPlacementID:plc
                                                                      withDelegate:self];
    
    // Interstitial config
    self.interstitial.isPreload = YES;
    if(((AerservExtras *) [self._connector networkExtras]).userId != nil) {
      self.interstitial.userId = ((AerservExtras *) [self._connector networkExtras]).userId;
    }
    [self.interstitial loadAd];
  }
  @catch (NSException *e) {
    [self._connector adapter:self didFailToLoadRewardBasedVideoAdwithError:[AerServExceptions InvalidRequest]];
  }
}

- (void)presentRewardBasedVideoAdWithRootViewController:(UIViewController *)viewController {
  if(self.adLoaded) {
    [self.interstitial showFromViewController:viewController];
  } else {
    NSLog(@"Ad is not ready.");
  }
}

- (void)stopBeingDelegate {
  self._connector = nil;
  self.interstitial = nil;
}

#pragma mark - Aerserv Interstitial Delegate
- (void)interstitialViewControllerDidPreloadAd:(ASInterstitialViewController *)viewController {
  [self._connector adapterDidReceiveRewardBasedVideoAd:self];
  self.adLoaded = YES;
}

-(void)interstitialViewControllerAdFailedToLoad:(ASInterstitialViewController *)viewController
                                      withError:(NSError *)error {
  self.adLoaded = NO;
  [self._connector adapter:self didFailToLoadRewardBasedVideoAdwithError:[AerServExceptions NoFill]];
}

- (void)interstitialViewControllerDidAppear:(ASInterstitialViewController *)viewController {
  [self._connector adapterDidOpenRewardBasedVideoAd:self];
  self.adLoaded = NO;
}

-(void)interstitialViewControllerDidDisappear:(ASInterstitialViewController *)viewController {
  [self._connector adapterDidCloseRewardBasedVideoAd:self];
}

- (void)interstitialViewControllerAdWasTouched:(ASInterstitialViewController *)viewController {
  [self._connector adapterDidGetAdClick:self];
  [self._connector adapterWillLeaveApplication:self];
}

-(void)interstitialViewControllerDidVirtualCurrencyLoad:(ASInterstitialViewController *)viewController
                                                 vcData:(NSDictionary *)vcData {
  self.reward = [[GADAdReward alloc] initWithRewardType:[vcData objectForKey:kVCName]
                                           rewardAmount:[vcData objectForKey:kVCAmount]];
}

-(void)interstitialViewControllerDidVirtualCurrencyReward:(ASInterstitialViewController *)viewController
                                                   vcData:(NSDictionary *)vcData {
  [self._connector adapter:self
   didRewardUserWithReward:self.reward];
}

@end
