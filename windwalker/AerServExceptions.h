//
//  AerServException.h
//  ios-sdk-admob-plugin
//
//  Created by Hall on 10/7/16.
//  Copyright © 2016 Aerserv. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GoogleMobileAds/GoogleMobileAds.h>

@interface AerServExceptions : NSObject

+ (NSError *) InvalidRequest;
+ (NSError *) NoFill;

@end
