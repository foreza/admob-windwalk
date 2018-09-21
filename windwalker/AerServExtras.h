//
//  AerservExtras.h
//  ios-sdk-admob-plugin
//
//  Created by Hall on 10/5/16.
//  Copyright © 2016 Aerserv. All rights reserved.
//

#import <GoogleMobileAds/GoogleMobileAds.h>

@interface AerservExtras : NSObject<GADAdNetworkExtras>
  @property(nonatomic, assign) NSString *userId;
@end
