//
//  SPShot.h
//  Spectttator
//
//  Created by David Keegan on 6/26/11.
//  Copyright 2011 David Keegan.
//

#import <Foundation/Foundation.h>
#import "SPObject.h"

@class SPPagination;
@class SPPlayer;

/** The `SPShot` class provides a programmatic interface for interacting 
 with Dribbble shots.
 
 The following snippet demonstrates how to retrieve a shot from an id and then get rebounds and comments on the shot.
 
    #import <Spectttator/Spectttator.h>
    
    [SPRequest shotInformationForIdentifier:199295 runOnMainThread:NO withBlock:^(SPShot *shot){
        NSLog(@"Shot Information: %@", shot);
        [shot reboundsWithPagination:nil 
                     runOnMainThread:NO 
                           withBlock:^(NSArray *rebounds, SPPagination *pagination){
                               NSLog(@"Rebounds for '%@': %@", shot.title, rebounds);
                           }];
        [shot commentsWithPagination:nil 
                     runOnMainThread:NO 
                           withBlock:^(NSArray *comments, SPPagination *pagination){
                               NSLog(@"Comments for '%@': %@", shot.title, comments);
                           }];
    }];
 
 This is non-blocking, `NSLog` will run whenever the comment data has finished loading,
 but the block still has access to everything in the scope from where it was defined.
 If the block is updating UI elements make sure to set `runOnMainThread:YES`, the Dribbble 
 requests will still be asynchronous but the passed in block will be executed on the main thread.
 */

@interface SPShot : SPObject

/// The title of the shot.
@property (strong, nonatomic, readonly) NSString *title;
/// The full url to the shot.
@property (strong, nonatomic, readonly) NSURL *url;
/// The short url to the shot.
@property (strong, nonatomic, readonly) NSURL *shortUrl;
/// The url to the shot's image.
@property (strong, nonatomic, readonly) NSURL *imageUrl;
/// The url to the shot's teaser image.
@property (strong, nonatomic, readonly) NSURL *imageTeaserUrl;
/// The width of the shot.
@property (nonatomic, readonly) NSUInteger width;
/// The height of the shot.
@property (nonatomic, readonly) NSUInteger height;
/// The number of views the shot has.
@property (nonatomic, readonly) NSUInteger viewsCount;
/// The number of likes the shot has.
@property (nonatomic, readonly) NSUInteger likesCount;
/// The number of comments the shot has.
@property (nonatomic, readonly) NSUInteger commentsCount;
/// The number of rebounds the shot has.
@property (nonatomic, readonly) NSUInteger reboundsCount;
/** The id of this shot this shot is a rebound of. 

 If it is not a rebound this value is `NSNotFound`.
 */
@property (nonatomic, readonly) NSUInteger reboundSourceId;
/** The player who posted the shot.
 @see SPPlayer
 */
@property (strong, nonatomic, readonly) SPPlayer *player;


///----------------------------
/// @name Retrieving Images
///----------------------------

/** 
 Retrieves the shot's image.
 @param runOnMainThread Specifies if the passed in block should be run on the main thread.
  If UI elements are being updated in the block this should be `YES`.  
 @param block The block to be executed once the data has been retrieved. 
  Depending on the platform an `NSImage` or `UIImage` object for the 
  shot is passed to the block.
 */
- (void)imageRunOnMainThread:(BOOL)runOnMainThread 
                   withBlock:(void (^)(SPImage *image))block;

/** 
 Retrieves the shot's teaser image.
 @param runOnMainThread Specifies if the passed in block should be run on the main thread.
  If UI elements are being updated in the block this should be `YES`.   
 @param block The block to be executed once the data has been retrieved. 
  Depending on the platform an `NSImage` or `UIImage` object for the 
  teaser is passed to the block.
 */
- (void)imageTeaserRunOnMainThread:(BOOL)runOnMainThread 
                         withBlock:(void (^)(SPImage *image))block;

///----------------------------
/// @name Rebounds and Comments
///----------------------------

/** 
 Retrieves the set of rebounds (shots in response to a shot) for the shot.
 @param pagination A NSDictionary with pagination data, the best way to 
  create this dictionary is with the helper functions on `SPPagination`.
  If `nil` the default pagination will be used as defined by the 
  [dribbble api](http://dribbble.com/api#pagination).    
 @param runOnMainThread Specifies if the passed in block should be run on the main thread.
  If UI elements are being updated in the block this should be `YES`. 
 @param block The block to be executed once the data has been retrieved. 
  An `NSArray` of `SPShot` objects and a `SPPagination` objects are passed to the block.
 @see reboundsWithBlock:withBlock:
 @see SPPagination
 */
- (void)reboundsWithPagination:(NSDictionary *)pagination
               runOnMainThread:(BOOL)runOnMainThread 
                     withBlock:(void (^)(NSArray *shots, SPPagination *pagination))block;

/** 
 Retrieves the set of rebounds (shots in response to a shot) for the shot.
 @param pagination A NSDictionary with pagination data, the best way to 
  create this dictionary is with the helper functions on `SPPagination`.
  If `nil` the default pagination will be used as defined by the 
  [dribbble api](http://dribbble.com/api#pagination).    
 @param runOnMainThread Specifies if the passed in block should be run on the main thread.
  If UI elements are being updated in the block this should be `YES`.  
 @param block The block to be executed once the data has been retrieved. 
  An `NSArray` of `SPComment` objects and a `SPPagination` objects are passed to the block.
 @param pagination A `NSDictionary` with pagination data, the best way to 
  create this dictionary is with the helper functions on `SPPagination`.
 @see commentsWithBlock:withBlock:
 @see SPComment
 @see SPPagination
 */
- (void)commentsWithPagination:(NSDictionary *)pagination
               runOnMainThread:(BOOL)runOnMainThread 
                     withBlock:(void (^)(NSArray *comments, SPPagination *pagination))block;

@end
