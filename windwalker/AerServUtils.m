//
//  AerServUtils.m
//  ios-sdk-admob-plugin
//
//  Created by Hall on 9/24/16.
//  Copyright © 2016 Aerserv. All rights reserved.
//

#import "AerServUtils.h"

#define kPLCKey @"placement"
#define kTimeoutKey @"timeoutMillis"
#define kSiteId @"siteId"
#define kAppId @"appId"

@interface AerServUtils()

@end

@implementation AerServUtils

+ (NSString *)getPLC:(NSString *) serverParameter {
  if([serverParameter integerValue]) {
    return serverParameter;
  }
  NSData* data = [serverParameter dataUsingEncoding:NSUTF8StringEncoding];
  NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
  return [json objectForKey:kPLCKey];
}

+ (NSString *)getSiteId:(NSString *) serverParameter {
  NSData* data = [serverParameter dataUsingEncoding:NSUTF8StringEncoding];
  NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
  if([json objectForKey:kAppId]) {
    return [json objectForKey:kAppId];
  } else {
    return [json objectForKey:kSiteId];
  }
  return nil;
}

@end
