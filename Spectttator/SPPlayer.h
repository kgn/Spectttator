//
//  SPPlayer.h
//  Spectttator
//
//  Created by David Keegan on 6/26/11.
//  Copyright 2011 InScopeApps {+}. All rights reserved.
//

#import <Foundation/Foundation.h>

/** The `SPPlayer` class provides a programmatic interface for interacting 
 with dribbble players.
 
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
    NSURL *_avatar_url;
    NSString *_location;
    NSString *_twitter_screen_name;
    NSUInteger _drafted_by_player_id;
    NSUInteger _shots_count;
    NSUInteger _draftees_count;
    NSUInteger _followers_count;
    NSUInteger _following_count;
    NSUInteger _comments_count;
    NSUInteger _comments_received_count;
    NSUInteger _likes_count;
    NSUInteger _likes_received_count;
    NSUInteger _rebounds_count;
    NSUInteger _rebounds_received_count;
    NSDate *_created_at;
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
@property (readonly) NSURL *avatar_url;
/// The location of the player.
@property (readonly) NSString *location;
/// The player's twitter name.
@property (readonly) NSString *twitter_screen_name;
/** The id of this player who drafted this player.
 
 If this player was not drafted the value is `NSNotFound`.
 */
@property (readonly) NSUInteger drafted_by_player_id;
/// The number of shots the player has posted.
@property (readonly) NSUInteger shots_count;
/// The number of players the player has drafted.
@property (readonly) NSUInteger draftees_count;
/// The number of people the player follows.
@property (readonly) NSUInteger followers_count;
/// The number of followers the player has.
@property (readonly) NSUInteger following_count;
/// The number of comments the player has posted.
@property (readonly) NSUInteger comments_count;
/// The number of comments the player's shots have received.
@property (readonly) NSUInteger comments_received_count;
/// The number of shots the player has liked.
@property (readonly) NSUInteger likes_count;
/// The number of likes the player's shots have received.
@property (readonly) NSUInteger likes_received_count;
/// The number of rebounds the player has posted.
@property (readonly) NSUInteger rebounds_count;
/// The number of rebounds the player's shots have received.
@property (readonly) NSUInteger rebounds_received_count;
/// The date the player's account was created on.
@property (readonly) NSDate *created_at;

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
 @param block The block to be executed once the data has been retrieved. 
  An `NSImage` object for the avatar is passed to the block.
 */
- (void)avatarWithBlock:(void (^)(NSImage *))block;

@end
