//
//  AerServCustomEventRewardedInterstitial.h
//  ios-sdk-admob-plugin
//
//  Created by Hall on 9/29/16.
//  Copyright © 2016 Aerserv. All rights reserved.
//

#import <AerServSDK/AerServSDK.h>
#import <Foundation/Foundation.h>
#import <GoogleMobileAds/GoogleMobileAds.h>
#import "AerServExceptions.h"
#import "AerServExtras.h"
#import "AerServUtils.h"

@interface AerServCustomEventRewardedInterstitial : NSObject <GADMRewardBasedVideoAdNetworkAdapter>
+ (Class<GADAdNetworkExtras>) networkExtrasClass;
@end
