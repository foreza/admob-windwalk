//
//  AerServExceptions.m
//  ios-sdk-admob-plugin
//
//  Created by Hall on 10/7/16.
//  Copyright © 2016 Aerserv. All rights reserved.
//

#import "AerServExceptions.h"

@interface AerServExceptions ()

@end

@implementation AerServExceptions

+ (NSError *)InvalidRequest {
  return [[NSError alloc] initWithDomain:kGADErrorDomain
                                    code:kGADErrorInvalidRequest
                                userInfo:@{NSLocalizedDescriptionKey:@"The ad request is invalid. The localizedFailureReason error description will have more details. Typically this is because the ad did not have the ad unit ID or root view controller set."}];
}

+ (NSError *)NoFill {
  return [[NSError alloc] initWithDomain:kGADErrorDomain
                                    code:kGADErrorNoFill
                                userInfo:@{NSLocalizedDescriptionKey:@"The ad request was successful, but no ad was returned."}];
}

@end
