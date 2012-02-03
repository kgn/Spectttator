//
//  SPRequest.h
//  Spectttator
//
//  Created by David Keegan on 6/25/11.
//  Copyright 2011 David Keegan.
//

#import <Foundation/Foundation.h>
#import "SPShot.h"
#import "SPPlayer.h"
#import "SPPagination.h"

#define SPDebutsList @"debuts"
#define SPEveryoneList @"everyone"
#define SPPopularList @"popular"

/** The `SPRequest` class provides a programmatic interface for interacting 
 with the majority of [Dribbble api](http://dribbble.com/api) calls, there are some shot centric 
 methods implemented on the `SPShot` object.
 
 The following snippet demonstrates how to get the last 10 shots a player liked.
 
    #import <Spectttator/Spectttator.h>
    
    NSString *username = @"inscopeapps";
    
    [SPRequest shotsForPlayerLikes:username 
                    withPagination:[SPPagination perPage:10]     
                   runOnMainThread:NO 
                         withBlock:^(NSArray *shots, SPPagination *pagination){
                             NSLog(@"Shot %@ likes: %@", username, shots);
                         }];
 
 This is non-blocking, `NSLog` will run whenever the comment data has finished loading,
 but the block still has access to everything in the scope from where it was defined.
 If the block is updating UI elements make sure to set `runOnMainThread:YES`, the Dribbble 
 requests will still be asynchronous but the passed in block will be executed on the main thread.
 */

@interface SPRequest : NSObject

///----------------------------
/// @name Players
///----------------------------

/** 
 Retrieves profile details for a player specified by _username_.
 @param username The username of the player.
 @param runOnMainThread Specifies if the passed in block should be run on the main thread.
  If UI elements are being updated in the block this should be `YES`.
 @param block The block to be executed once the data has been retrieved. 
  A `SPPlayer` object is passed to the block.
 @see SPPlayer
 */
+ (void)playerInformationForUsername:(NSString *)username 
                     runOnMainThread:(BOOL)runOnMainThread 
                           withBlock:(void (^)(SPPlayer *player))block;

/** 
 Retrieves the list of followers for a player specified by _username_.
 @param username The username of the player.
 @param pagination A NSDictionary with pagination data, the best way to 
  create this dictionary is with the helper functions on `SPPagination`.
  If `nil` the default pagination will be used as defined by the 
  [dribbble api](http://dribbble.com/api#pagination).
 @param runOnMainThread Specifies if the passed in block should be run on the main thread.
  If UI elements are being updated in the block this should be `YES`. 
 @param block The block to be executed once the data has been retrieved. 
  An `NSArray` of `SPPlayer` objects and a `SPPagination` objects are passed to the block.
 @see playerFollowers:withBlock:
 @see SPPagination
 @see SPPlayer
 */
+ (void)playerFollowers:(NSString *)username 
         withPagination:(NSDictionary *)pagination
        runOnMainThread:(BOOL)runOnMainThread 
              withBlock:(void (^)(NSArray *players, SPPagination *pagination))block;

/** 
 Retrieves the list of followers for a player specified by _username_.
 @param username The username of the player.
 @param pagination A NSDictionary with pagination data, the best way to 
  create this dictionary is with the helper functions on `SPPagination`.
  If `nil` the default pagination will be used as defined by the 
  [dribbble api](http://dribbble.com/api#pagination).
 @param runOnMainThread Specifies if the passed in block should be run on the main thread.
  If UI elements are being updated in the block this should be `YES`.  
 @param block The block to be executed once the data has been retrieved. 
  An `NSArray` of `SPPlayer` objects and a `SPPagination` objects are passed to the block.
 @see playerFollowing:withBlock:
 @see SPPagination
 @see SPPlayer
 */
+ (void)playerFollowing:(NSString *)username 
         withPagination:(NSDictionary *)pagination
        runOnMainThread:(BOOL)runOnMainThread
              withBlock:(void (^)(NSArray *players, SPPagination *pagination))block;

/** 
 Retrieves the list of players drafted by the player specified by _username_.
 @param username The username of the player.
 @param pagination A NSDictionary with pagination data, the best way to 
  create this dictionary is with the helper functions on `SPPagination`.
  If `nil` the default pagination will be used as defined by the 
  [dribbble api](http://dribbble.com/api#pagination). 
 @param runOnMainThread Specifies if the passed in block should be run on the main thread.
  If UI elements are being updated in the block this should be `YES`.   
 @param block The block to be executed once the data has been retrieved. 
  An `NSArray` of `SPPlayer` objects and a `SPPagination` objects are passed to the block.
 @see playerDraftees:withBlock:
 @see SPPagination
 @see SPPlayer
 */
+ (void)playerDraftees:(NSString *)username 
        withPagination:(NSDictionary *)pagination
       runOnMainThread:(BOOL)runOnMainThread 
             withBlock:(void (^)(NSArray *players, SPPagination *pagination))block;


///----------------------------
/// @name Shots
///----------------------------

/** 
 Retrieves details for a shot specified by _id_.
 @param identifier The shot identifier number.
 @param runOnMainThread Specifies if the passed in block should be run on the main thread.
  If UI elements are being updated in the block this should be `YES`. 
 @param block The block to be executed once the data has been retrieved. 
  A `SPShot` object is passed to the block.
 @see SPShot
 */
+ (void)shotInformationForIdentifier:(NSUInteger)identifier 
                     runOnMainThread:(BOOL)runOnMainThread 
                           withBlock:(void (^)(SPShot *shot))block;

/** 
 Retrieves the specified list of shots.
 @param list The list to retrieve shots from, must be one of the following values: 
 
 - `SPDebutsList`
 - `SPEveryoneList`
 - `SPPopularList`
 @param pagination A NSDictionary with pagination data, the best way to 
  create this dictionary is with the helper functions on `SPPagination`.
  If `nil` the default pagination will be used as defined by the 
  [dribbble api](http://dribbble.com/api#pagination).  
 @param runOnMainThread Specifies if the passed in block should be run on the main thread.
  If UI elements are being updated in the block this should be `YES`. 
 @param block The block to be executed once the data has been retrieved. 
  An `NSArray` of `SPShot` objects and a `SPPagination` objects are passed to the block.
 @see shotsForList:withBlock:
 @see SPPagination
 @see SPShot
 */
+ (void)shotsForList:(NSString *)list 
      withPagination:(NSDictionary *)pagination
     runOnMainThread:(BOOL)runOnMainThread 
           withBlock:(void (^)(NSArray *shots, SPPagination *pagination))block;

/** 
 Retrieves the most recent shots for the player specified by _username_.
 @param username The username of the player.
 @param pagination A NSDictionary with pagination data, the best way to 
  create this dictionary is with the helper functions on `SPPagination`.
  If `nil` the default pagination will be used as defined by the 
  [dribbble api](http://dribbble.com/api#pagination).   
 @param runOnMainThread Specifies if the passed in block should be run on the main thread.
  If UI elements are being updated in the block this should be `YES`.  
 @param block The block to be executed once the data has been retrieved. 
  An `NSArray` of `SPShot` objects and a `SPPagination` objects are passed to the block.
 @see shotsForPlayer:withBlock:
 @see SPPagination
 @see SPShot
 */
+ (void)shotsForPlayer:(NSString *)username 
        withPagination:(NSDictionary *)pagination
       runOnMainThread:(BOOL)runOnMainThread 
             withBlock:(void (^)(NSArray *shots, SPPagination *pagination))block;

/** 
 Retrieves the most recent shots published by those the player specified by _username_ is following.
 @param username The username of the player.
 @param pagination A NSDictionary with pagination data, the best way to 
  create this dictionary is with the helper functions on `SPPagination`.
  If `nil` the default pagination will be used as defined by the 
  [dribbble api](http://dribbble.com/api#pagination).   
 @param runOnMainThread Specifies if the passed in block should be run on the main thread.
  If UI elements are being updated in the block this should be `YES`.  
 @param block The block to be executed once the data has been retrieved. 
  An `NSArray` of `SPShot` objects and a `SPPagination` objects are passed to the block. 
 @see shotsForPlayerFollowing:withBlock:
 @see SPPagination
 @see SPShot
 */
+ (void)shotsForPlayerFollowing:(NSString *)username 
                 withPagination:(NSDictionary *)pagination
                runOnMainThread:(BOOL)runOnMainThread
                      withBlock:(void (^)(NSArray *shots, SPPagination *pagination))block;

/** 
 Retrieves shots liked by the player specified by _username_.
 @param username The username of the player.
 @param pagination A NSDictionary with pagination data, the best way to 
  create this dictionary is with the helper functions on `SPPagination`.
  If `nil` the default pagination will be used as defined by the 
  [dribbble api](http://dribbble.com/api#pagination).    
 @param runOnMainThread Specifies if the passed in block should be run on the main thread.
  If UI elements are being updated in the block this should be `YES`.
 @param block The block to be executed once the data has been retrieved. 
  An `NSArray` of `SPShot` objects and a `SPPagination` objects are passed to the block.
 @see shotsForPlayerLikes:withBlock:
 @see SPPagination
 @see SPShot
 */
+ (void)shotsForPlayerLikes:(NSString *)username 
             withPagination:(NSDictionary *)pagination
            runOnMainThread:(BOOL)runOnMainThread
                  withBlock:(void (^)(NSArray *shots, SPPagination *pagination))block;

@end
