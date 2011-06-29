//
//  SPPagination.h
//  Spectttator
//
//  Created by David Keegan on 6/26/11.
//  Copyright 2011 InScopeApps {+}. All rights reserved.
//

#import <Foundation/Foundation.h>

/** Most dribbble api calls take `page` and `per_page` to define which page of 
 data to return and how many items should be contained in the return. 
 In Spectttator this can be defined by passing a dictionary with `page`
 and `per_page` to the `andPagination:` parameter. 
 `SPPagination` contains helper functions for creating this dictionary.
 
 The `SPPagination` class is used in two ways. First it provides helper functions for creating 
 pagination dictionary to pass to methods. Secondly it provides an object that is passed to blocks, 
 this object contains the returned pagination information: `page`, `pages`, `perPage`, `total`.

    #import <Spectttator/Spectttator.h>

    NSString *username = @"inscopeapps";

    [[SPManager sharedManager] shotsForPlayer:user withBlock:^(NSArray *shots, SPPagination *pagination){
        NSLog(@"Received shot data for %@", user);
        NSLog(@"With pagination: %@", pagination);
    } andPagination:[SPPagination perPage:20]];
 */

@interface SPPagination : NSObject{
    NSUInteger _page;
    NSUInteger _pages;
    NSUInteger _perPage;
    NSUInteger _total;
}

/// The current page number.
@property(readonly) NSUInteger page;
/// The total number of pages.
@property(readonly) NSUInteger pages;
/// The number of items per-page.
@property(readonly) NSUInteger perPage;
/// The total number of items.
@property(readonly) NSUInteger total;

///----------------------------
/// @name Initializing a SPPagination Object
///----------------------------

/** 
 Returns an autoreleased `SPPagination` object initialized with the given pagination data. 
 
 There is no need to call this method directly, higher level
 methods use this to return pagination data to blocks.
 @param dictionary A dictionary of comment data.
 @return An autoreleased `SPPagination` object.
 @see initWithDictionary:
 @see [SPManager shotsForPlayerLikes:withBlock:]
 */
+ (id)paginationWithDictionary:(NSDictionary *)dictionary;

/** 
 Returns a Spectttator pagination object initialized with the given pagination data. 
 
 There is no need to call this method directly, higher level
 methods use this to return pagination data to blocks.
 @param dictionary A dictionary of comment data.
 @return An initialized `SPPagination` object.
 @see [SPManager shotsForPlayerLikes:withBlock:]
 */
- (id)initWithDictionary:(NSDictionary *)dictionary;

///----------------------------
/// @name Pagination Dictionary
///----------------------------

/** 
 A helper method for creating a pagination dictionary.
 @param page The page number.
 @return A pagination dictionary with the specified `page` value.
 @see page:perPage:
 */
+ (NSDictionary *)page:(NSUInteger)page;

/** 
 A helper method for creating a pagination dictionary.
 @param perPage The number of items per-page.
 @return A pagination dictionary with the specified `per_page` value.
 @see page:perPage:
 */
+ (NSDictionary *)perPage:(NSUInteger)perPage;

/** 
 A helper method for creating a pagination dictionary.
 @param page The page number.
 @param perPage The number of items per-page.
 @return A pagination dictionary with the specified `page` and `per_page` values.
 @see page:perPage:
 */
+ (NSDictionary *)page:(NSUInteger)page perPage:(NSUInteger)perPage;

@end
