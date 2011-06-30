//
//  SPShot.h
//  Spectttator
//
//  Created by David Keegan on 6/26/11.
//  Copyright 2011 InScopeApps {+}. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SPPagination.h"
#import "SPPlayer.h"

/** The `SPShot` class provides a programmatic interface for interacting 
 with Dribbble shots.
 
 The following snippet demonstrates how to retrieve a shot from an id and then get rebounds and comments on the shot.
 
    #import <Spectttator/Spectttator.h>
    
    [[SPManager sharedManager] shotInformationForIdentifier:199295 withBlock:^(SPShot *shot){
        NSLog(@"Shot Information: %@", shot);
        [shot reboundsWithBlock:^(NSArray *rebounds, SPPagination *pagination){
            NSLog(@"Rebounds for '%@': %@", shot.title, rebounds);
        }];
        [shot commentsWithBlock:^(NSArray *comments, SPPagination *pagination){
            NSLog(@"Comments for '%@': %@", shot.title, comments);
        }];        
    }];
 
 This is non-blocking, `NSLog` will run whenever the shot data has finished loading,
 but the block still has access to everything in the scope from where it was defined.
 */

@interface SPShot : NSObject {
    NSUInteger _identifier;
    NSString *_title;
    NSURL *_url;
    NSURL *_shortUrl;
    NSURL *_imageUrl;
    NSURL *_imageTeaserUrl;
    NSUInteger _width;
    NSUInteger _height;
    NSUInteger _viewsCount;
    NSUInteger _likesCount;
    NSUInteger _commentsCount;
    NSUInteger _reboundsCount;
    NSUInteger _reboundSourceId;
    NSDate *_createdAt;
    SPPlayer *_player;
}

/// The unique id of the shot.
@property (readonly) NSUInteger identifier;
/// The title of the shot.
@property (readonly) NSString *title;
/// The full url to the shot.
@property (readonly) NSURL *url;
/// The short url to the shot.
@property (readonly) NSURL *shortUrl;
/// The url to the shot's image.
@property (readonly) NSURL *imageUrl;
/// The url to the shot's teaser image.
@property (readonly) NSURL *imageTeaserUrl;
/// The width of the shot.
@property (readonly) NSUInteger width;
/// The height of the shot.
@property (readonly) NSUInteger height;
/// The number of views the shot has.
@property (readonly) NSUInteger viewsCount;
/// The number of likes the shot has.
@property (readonly) NSUInteger likesCount;
/// The number of comments the shot has.
@property (readonly) NSUInteger commentsCount;
/// The number of rebounds the shot has.
@property (readonly) NSUInteger reboundsCount;
/** The id of this shot this shot is a rebound of. 

 If it is not a rebound this value is `NSNotFound`.
 */
@property (readonly) NSUInteger reboundSourceId;
/// The date the shot was created on.
@property (readonly) NSDate *createdAt;
/** The player who posted the shot.
 @see SPPlayer
 */
@property (readonly) SPPlayer *player;

///----------------------------
/// @name Initializing a SPShot Object
///----------------------------

/** 
 Returns a Spetttator shot object initialized with the given shot data. 
 
 There is no need to call this method directly, it is used by 
  higher level methods like `[SPManager shotsForList:withBlock:]`.
 @param dictionary A dictionary of shot data.
 @return An initialized `SPShot` object.
 */
- (id)initWithDictionary:(NSDictionary *)dictionary;

///----------------------------
/// @name Retrieving Images
///----------------------------

/** 
 Retrieves the shot's image.
 @param block The block to be executed once the data has been retrieved. 
  Depending on the platform an `NSImage` or `UIImage object for the 
  shot is passed to the block.
 */
#if (TARGET_IPHONE_SIMULATOR || TARGET_OS_IPHONE)
- (void)imageWithBlock:(void (^)(UIImage *))block;
#else
- (void)imageWithBlock:(void (^)(NSImage *))block;
#endif

/** 
 Retrieves the shot's teaser image.
 @param block The block to be executed once the data has been retrieved. 
  Depending on the platform an `NSImage` or `UIImage object for the 
  teaser is passed to the block.
 */
#if (TARGET_IPHONE_SIMULATOR || TARGET_OS_IPHONE)
- (void)imageTeaserWithBlock:(void (^)(UIImage *))block;
#else
- (void)imageTeaserWithBlock:(void (^)(NSImage *))block;
#endif

///----------------------------
/// @name Rebounds and Comments
///----------------------------

/** 
 Retrieves the set of rebounds (shots in response to a shot) for the shot.
 @param block The block to be executed once the data has been retrieved. 
  An `NSArray` of `SPShot` objects and a `SPPagination` objects are passed to the block.
 @see reboundsWithBlock:withBlock:andPagination:
 @see SPPagination
 */
- (void)reboundsWithBlock:(void (^)(NSArray *, SPPagination *))block;

/** 
 Retrieves the set of rebounds (shots in response to a shot) for the shot.
 @param block The block to be executed once the data has been retrieved. 
  An `NSArray` of `SPShot` objects and a `SPPagination` objects are passed to the block.
 @param pagination A NSDictionary with pagination data, the best way to 
  create this dictionary is with the helper functions on `SPPagination`.
 @see reboundsWithBlock:withBlock:
 @see SPPagination
 */
- (void)reboundsWithBlock:(void (^)(NSArray *, SPPagination *))block andPagination:(NSDictionary *)pagination;

/** 
 Retrieves the set of comments for the shot.
 @param block The block to be executed once the data has been retrieved. 
  An `NSArray` of `SPComment` objects and a `SPPagination` objects are passed to the block.
 @see reboundsWithBlock:withBlock:andPagination:
 @see SPComment
 @see SPPagination
 */
- (void)commentsWithBlock:(void (^)(NSArray *, SPPagination *))block;

/** 
 Retrieves the set of rebounds (shots in response to a shot) for the shot.
 @param block The block to be executed once the data has been retrieved. 
  An `NSArray` of `SPComment` objects and a `SPPagination` objects are passed to the block.
 @param pagination A `NSDictionary` with pagination data, the best way to 
  create this dictionary is with the helper functions on `SPPagination`.
 @see commentsWithBlock:withBlock:
 @see SPComment
 @see SPPagination
 */
- (void)commentsWithBlock:(void (^)(NSArray *, SPPagination *))block andPagination:(NSDictionary *)pagination;

@end
