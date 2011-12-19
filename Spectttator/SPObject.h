//
//  SPObject.h
//  Spectttator
//
//  Created by David Keegan on 12/19/11.
//  Copyright (c) 2011 David Keegan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SPMethods.h"

@interface SPObject : NSObject

/// The unique id of the object.
@property (readonly, nonatomic) NSUInteger identifier;
/// The date the object was created.
@property (readonly, nonatomic) NSDate *createdAt;

///----------------------------
/// @name Initializing a SPObject Object
///----------------------------

/** 
 Returns a Spectttator object initialized with the given data. 
 
 There is no need to call this method directly, it is used by 
 higher level methods.
 @param dictionary A dictionary of  data.
 @return An initialized `SPObject` object.
 */
- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
