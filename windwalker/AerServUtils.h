//
//  AerServUtils.h
//  ios-sdk-admob-plugin
//
//  Created by Hall on 9/24/16.
//  Copyright © 2016 Aerserv. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AerServUtils : NSObject
  + (NSString *)getPLC:(NSString*) serverParameter;
+ (NSString *)getSiteId:(NSString *) serverParameter;
@end
