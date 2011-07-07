//
//  SPManager.h
//  Spectttator
//
//  Created by David Keegan on 6/25/11.
//  Copyright 2011 David Keegan.
//
//  Singleton from http://boredzo.org/blog/archives/2009-06-17/doing-it-wrong
//

#import <Foundation/Foundation.h>
#import "SPShot.h"
#import "SPPlayer.h"
#import "SPPagination.h"

#define SPDebutsList @"debuts"
#define SPEveryoneList @"everyone"
#define SPPopularList @"popular"

/** The `SPManager` class provides a programmatic interface for interacting 
 with the majority of [Dribbble api](http://dribbble.com/api) calls, there are some shot centric 
 methods implemented on the `SPShot` object.
 
 The following snippet demonstrates how to get the last 10 shots a player liked.
 
    #import <Spectttator/Spectttator.h>
    
    NSString *username = @"inscopeapps";
    
    [[SPManager sharedManager] shotsForPlayerLikes:username withBlock:^(NSArray *shots, SPPagination *pagination){
        NSLog(@"Shots %@ likes: %@", username, shots);
    } andPagination:[SPPagination perPage:10]];
 
 This is non-blocking, `NSLog` will run whenever the shot data has finished loading,
 but the block still has access to everything in the scope from where it was defined.
 */

@interface SPManager : NSObject

///----------------------------
/// @name Getting the Shared SPManager Instance
///----------------------------

/// Returns the shared Spectttator manager object.
+ (id)sharedManager;

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
- (void)playerInformationForUsername:(NSString *)username 
                     runOnMainThread:(BOOL)runOnMainThread 
                           withBlock:(void (^)(SPPlayer *))block;

/** 
 Retrieves the list of followers for a player specified by _username_.
 @param username The username of the player.
 @param runOnMainThread Specifies if the passed in block should be run on the main thread.
  If UI elements are being updated in the block this should be `YES`. 
 @param block The block to be executed once the data has been retrieved. 
  An `NSArray` of `SPPlayer` objects and a `SPPagination` objects are passed to the block.
 @see playerFollowers:withBlock:andPagination:
 @see SPPagination
 @see SPPlayer
 */
- (void)playerFollowers:(NSString *)username 
        runOnMainThread:(BOOL)runOnMainThread 
              withBlock:(void (^)(NSArray *, SPPagination *))block;

/** 
 Retrieves the list of followers for a player specified by _username_.
 @param username The username of the player.
 @param runOnMainThread Specifies if the passed in block should be run on the main thread.
  If UI elements are being updated in the block this should be `YES`. 
 @param block The block to be executed once the data has been retrieved. 
  An `NSArray` of `SPPlayer` objects and a `SPPagination` objects are passed to the block.
 @param pagination A NSDictionary with pagination data, the best way to 
  create this dictionary is with the helper functions on `SPPagination`.
 @see playerFollowers:withBlock:
 @see SPPagination
 @see SPPlayer
 */
- (void)playerFollowers:(NSString *)username 
        runOnMainThread:(BOOL)runOnMainThread 
              withBlock:(void (^)(NSArray *, SPPagination *))block 
          andPagination:(NSDictionary *)pagination;

/** 
 Retrieves the list of players followed by the player specified by _username_.
 @param username The username of the player.
 @param runOnMainThread Specifies if the passed in block should be run on the main thread.
  If UI elements are being updated in the block this should be `YES`.  
 @param block The block to be executed once the data has been retrieved. 
  An `NSArray` of `SPPlayer` objects and a `SPPagination` objects are passed to the block.
 @see playerFollowing:withBlock:andPagination:
 @see SPPagination
 @see SPPlayer
 */
- (void)playerFollowing:(NSString *)username 
        runOnMainThread:(BOOL)runOnMainThread
              withBlock:(void (^)(NSArray *, SPPagination *))block;

/** 
 Retrieves the list of followers for a player specified by _username_.
 @param username The username of the player.
 @param runOnMainThread Specifies if the passed in block should be run on the main thread.
  If UI elements are being updated in the block this should be `YES`.  
 @param block The block to be executed once the data has been retrieved. 
  An `NSArray` of `SPPlayer` objects and a `SPPagination` objects are passed to the block.
 @param pagination A NSDictionary with pagination data, the best way to 
  create this dictionary is with the helper functions on `SPPagination`.
 @see playerFollowing:withBlock:
 @see SPPagination
 @see SPPlayer
 */
- (void)playerFollowing:(NSString *)username 
        runOnMainThread:(BOOL)runOnMainThread
              withBlock:(void (^)(NSArray *, SPPagination *))block 
          andPagination:(NSDictionary *)pagination;

/** 
 Retrieves the list of players drafted by the player specified by _username_.
 @param username The username of the player.
 @param runOnMainThread Specifies if the passed in block should be run on the main thread.
  If UI elements are being updated in the block this should be `YES`.   
 @param block The block to be executed once the data has been retrieved. 
  An `NSArray` of `SPPlayer` objects and a `SPPagination` objects are passed to the block.
 @see playerDraftees:withBlock:andPagination:
 @see SPPagination
 @see SPPlayer
 */
- (void)playerDraftees:(NSString *)username 
       runOnMainThread:(BOOL)runOnMainThread 
             withBlock:(void (^)(NSArray *, SPPagination *))block;

/** 
 Retrieves the list of players drafted by the player specified by _username_.
 @param username The username of the player.
 @param runOnMainThread Specifies if the passed in block should be run on the main thread.
  If UI elements are being updated in the block this should be `YES`.   
 @param block The block to be executed once the data has been retrieved. 
  An `NSArray` of `SPPlayer` objects and a `SPPagination` objects are passed to the block.
 @param pagination A NSDictionary with pagination data, the best way to 
  create this dictionary is with the helper functions on `SPPagination`. 
 @see playerDraftees:withBlock:
 @see SPPagination
 @see SPPlayer
 */
- (void)playerDraftees:(NSString *)username 
       runOnMainThread:(BOOL)runOnMainThread 
             withBlock:(void (^)(NSArray *, SPPagination *))block 
         andPagination:(NSDictionary *)pagination;


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
- (void)shotInformationForIdentifier:(NSUInteger)identifier 
                     runOnMainThread:(BOOL)runOnMainThread 
                           withBlock:(void (^)(SPShot *))block;

/** 
 Retrieves the specified list of shots.
 @param list The list to retrieve shots from, must be one of the following values: 
 
 - `SPDebutsList`
 - `SPEveryoneList`
 - `SPPopularList`
 @param runOnMainThread Specifies if the passed in block should be run on the main thread.
  If UI elements are being updated in the block this should be `YES`. 
 @param block The block to be executed once the data has been retrieved. 
  An `NSArray` of `SPShot` objects and a `SPPagination` objects are passed to the block.
 @see shotsForList:withBlock:andPagination:
 @see SPPagination
 @see SPShot
 */
- (void)shotsForList:(NSString *)list 
     runOnMainThread:(BOOL)runOnMainThread 
           withBlock:(void (^)(NSArray *, SPPagination *))block;

/** 
 Retrieves the specified list of shots.
 @param list The list to retrieve shots from, must be one of the following values: 
 
 - `SPDebutsList`
 - `SPEveryoneList`
 - `SPPopularList`
 @param runOnMainThread Specifies if the passed in block should be run on the main thread.
  If UI elements are being updated in the block this should be `YES`. 
 @param block The block to be executed once the data has been retrieved. 
  An `NSArray` of `SPShot` objects and a `SPPagination` objects are passed to the block.
 @param pagination A NSDictionary with pagination data, the best way to 
  create this dictionary is with the helper functions on `SPPagination`.  
 @see shotsForList:withBlock:
 @see SPPagination
 @see SPShot
 */
- (void)shotsForList:(NSString *)list 
     runOnMainThread:(BOOL)runOnMainThread 
           withBlock:(void (^)(NSArray *, SPPagination *))block 
       andPagination:(NSDictionary *)pagination;

/** 
 Retrieves the most recent shots for the player specified by _username_.
 @param username The username of the player.
 @param runOnMainThread Specifies if the passed in block should be run on the main thread.
  If UI elements are being updated in the block this should be `YES`.  
 @param block The block to be executed once the data has been retrieved. 
  An `NSArray` of `SPShot` objects and a `SPPagination` objects are passed to the block.
 @see shotsForPlayer:withBlock:andPagination:
 @see SPPagination
 @see SPShot
 */
- (void)shotsForPlayer:(NSString *)username 
       runOnMainThread:(BOOL)runOnMainThread 
             withBlock:(void (^)(NSArray *, SPPagination *))block;

/** 
 Retrieves the most recent shots for the player specified by _username_.
 @param username The username of the player.
 @param runOnMainThread Specifies if the passed in block should be run on the main thread.
  If UI elements are being updated in the block this should be `YES`.  
 @param block The block to be executed once the data has been retrieved. 
  An `NSArray` of `SPShot` objects and a `SPPagination` objects are passed to the block.
 @param pagination A NSDictionary with pagination data, the best way to 
  create this dictionary is with the helper functions on `SPPagination`.  
 @see shotsForPlayer:withBlock:
 @see SPPagination
 @see SPShot
 */
- (void)shotsForPlayer:(NSString *)username 
       runOnMainThread:(BOOL)runOnMainThread 
             withBlock:(void (^)(NSArray *, SPPagination *))block 
         andPagination:(NSDictionary *)pagination;


/** 
 Retrieves the most recent shots published by those the player specified by _username_ is following.
 @param username The username of the player.
 @param runOnMainThread Specifies if the passed in block should be run on the main thread.
  If UI elements are being updated in the block this should be `YES`.  
 @param block The block to be executed once the data has been retrieved. 
  An `NSArray` of `SPShot` objects and a `SPPagination` objects are passed to the block.
 @see shotsForPlayerFollowing:withBlock:andPagination:
 @see SPPagination
 @see SPShot
 */
- (void)shotsForPlayerFollowing:(NSString *)username 
                runOnMainThread:(BOOL)runOnMainThread
                      withBlock:(void (^)(NSArray *, SPPagination *))block;

/** 
 Retrieves the most recent shots published by those the player specified by _username_ is following.
 @param username The username of the player.
 @param runOnMainThread Specifies if the passed in block should be run on the main thread.
  If UI elements are being updated in the block this should be `YES`.  
 @param block The block to be executed once the data has been retrieved. 
  An `NSArray` of `SPShot` objects and a `SPPagination` objects are passed to the block.
 @param pagination A NSDictionary with pagination data, the best way to 
  create this dictionary is with the helper functions on `SPPagination`.  
 @see shotsForPlayerFollowing:withBlock:
 @see SPPagination
 @see SPShot
 */
- (void)shotsForPlayerFollowing:(NSString *)username 
                runOnMainThread:(BOOL)runOnMainThread
                      withBlock:(void (^)(NSArray *, SPPagination *))block 
                  andPagination:(NSDictionary *)pagination;

/** 
 Retrieves shots liked by the player specified by _username_.
 @param username The username of the player.
 @param runOnMainThread Specifies if the passed in block should be run on the main thread.
  If UI elements are being updated in the block this should be `YES`.   
 @param block The block to be executed once the data has been retrieved. 
  An `NSArray` of `SPShot` objects and a `SPPagination` objects are passed to the block.
 @see shotsForPlayerLikes:withBlock:andPagination:
 @see SPPagination
 @see SPShot
 */
- (void)shotsForPlayerLikes:(NSString *)username 
            runOnMainThread:(BOOL)runOnMainThread
                  withBlock:(void (^)(NSArray *, SPPagination *))block;

/** 
 Retrieves shots liked by the player specified by _username_.
 @param username The username of the player.
 @param runOnMainThread Specifies if the passed in block should be run on the main thread.
  If UI elements are being updated in the block this should be `YES`.
 @param block The block to be executed once the data has been retrieved. 
  An `NSArray` of `SPShot` objects and a `SPPagination` objects are passed to the block.
 @param pagination A NSDictionary with pagination data, the best way to 
  create this dictionary is with the helper functions on `SPPagination`.  
 @see shotsForPlayerLikes:withBlock:
 @see SPPagination
 @see SPShot
 */
- (void)shotsForPlayerLikes:(NSString *)username 
            runOnMainThread:(BOOL)runOnMainThread
                  withBlock:(void (^)(NSArray *, SPPagination *))block 
              andPagination:(NSDictionary *)pagination;

@end
