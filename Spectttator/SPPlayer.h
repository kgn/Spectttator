//
//  SPPlayer.h
//  Spectttator
//
//  Created by David Keegan on 6/26/11.
//  Copyright 2011 David Keegan.
//

#import <Foundation/Foundation.h>

/** The `SPPlayer` class provides a programmatic interface for interacting 
 with Dribbble players.
 
 The following snippet demonstrates how to retrieve information about a player by their username.
 
    #import <Spectttator/Spectttator.h>

    NSString *username = @"inscopeapps";

    [[SPManager sharedManager] playerInformationForUsername:username withBlock:^(SPPlayer *player){
        NSLog(@"Player information for %@: %@", username, player);
    }];
 
 This is non-blocking, `NSLog` will run whenever the shot data has finished loading,
 but the block still has access to everything in the scope from where it was defined.
 */

@interface SPPlayer : NSObject {
    NSUInteger _identifier;
    NSString *_name;
    NSString *_username;
    NSURL *_url;
    NSURL *_avatarUrl;
    NSString *_location;
    NSString *_twitterScreenName;
    NSUInteger _draftedByPlayerId;
    NSUInteger _shotsCount;
    NSUInteger _drafteesCount;
    NSUInteger _followersCount;
    NSUInteger _followingCount;
    NSUInteger _commentsCount;
    NSUInteger _commentsReceivedCount;
    NSUInteger _likesCount;
    NSUInteger _likesReceivedCount;
    NSUInteger _reboundsCount;
    NSUInteger _reboundsReceivedCount;
    NSDate *_createdAt;
}

/// The unique id of the player.
@property (readonly) NSUInteger identifier;
/// The real name of the player.
@property (readonly) NSString *name;
/// The username of the player.
@property (readonly) NSString *username;
/// The url of the player's profile.
@property (readonly) NSURL *url;
/// The url of the player's avatar.
@property (readonly) NSURL *avatarUrl;
/// The location of the player.
@property (readonly) NSString *location;
/// The player's twitter name.
@property (readonly) NSString *twitterScreenName;
/** The id of this player who drafted this player.
 
 If this player was not drafted the value is `NSNotFound`.
 */
@property (readonly) NSUInteger draftedByPlayerId;
/// The number of shots the player has posted.
@property (readonly) NSUInteger shotsCount;
/// The number of players the player has drafted.
@property (readonly) NSUInteger drafteesCount;
/// The number of people the player follows.
@property (readonly) NSUInteger followersCount;
/// The number of followers the player has.
@property (readonly) NSUInteger followingCount;
/// The number of comments the player has posted.
@property (readonly) NSUInteger commentsCount;
/// The number of comments the player's shots have received.
@property (readonly) NSUInteger commentsReceivedCount;
/// The number of shots the player has liked.
@property (readonly) NSUInteger likesCount;
/// The number of likes the player's shots have received.
@property (readonly) NSUInteger likesReceivedCount;
/// The number of rebounds the player has posted.
@property (readonly) NSUInteger reboundsCount;
/// The number of rebounds the player's shots have received.
@property (readonly) NSUInteger reboundsReceivedCount;
/// The date the player's account was created on.
@property (readonly) NSDate *createdAt;

///----------------------------
/// @name Initializing a SPPlayer Object
///----------------------------

/** 
 Returns a Spectttator player object initialized with the given player data. 
 
 There is no need to call this method directly, it is used by 
  higher level methods like `[SPManager playerInformationForUsername:withBlock:]`.
 @param dictionary A dictionary of player data.
 @return An initialized `SPPlayer` object.
 */
- (id)initWithDictionary:(NSDictionary *)dictionary;

///----------------------------
/// @name Avatar
///----------------------------

/** 
 Retrieves the player's avatar.
 @param runOnMainThread Specifies if the passed in block should be run on the main thread.
  If UI elements are being updated in the block this should be `YES`.  
 @param block The block to be executed once the data has been retrieved. 
  Depending on the platform an `NSImage` or `UIImage` object for the 
  avatar is passed to the block.
 */
- (void)avatarRunOnMainThread:(BOOL)runOnMainThread 
                    withBlock:(void (^)(
#if TARGET_OS_IPHONE
                                        UIImage *
#else
                                        NSImage *
#endif
                                        ))block;

@end
