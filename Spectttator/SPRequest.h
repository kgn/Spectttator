//
//  SPRequest.h
//  Spectttator
//
//  Created by David Keegan on 6/27/11.
//  Copyright 2011 David Keegan.
//

#import <Foundation/Foundation.h>
#import "SBJson.h"

@interface SPRequest : NSObject

+ (SBJsonParser *)parser;
+ (NSOperationQueue *)operationQueue;
+ (NSString *)pagination:(NSDictionary *)pagination;
+ (id)dataFromUrl:(NSURL *)url;

@end
