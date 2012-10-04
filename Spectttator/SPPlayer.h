//
//  SPPlayer.h
//  Spectttator
//
//  Created by David Keegan on 6/26/11.
//  Copyright 2011 David Keegan.
//

#import <Foundation/Foundation.h>
#import "SPObject.h"

/** The `SPPlayer` class provides a programmatic interface for interacting 
 with Dribbble players.
 
 The following snippet demonstrates how to retrieve information about a player by their username.
 
    #import <Spectttator/Spectttator.h>

    NSString *username = @"inscopeapps";

    [SPRequest playerInformationForUsername:username 
                            runOnMainThread:NO 
                                  withBlock:^(SPPlayer *player){
                                      NSLog(@"Player information for %@: %@", username, player);
                                  }];
 
 This is non-blocking, `NSLog` will run whenever the comment data has finished loading,
 but the block still has access to everything in the scope from where it was defined.
 If the block is updating UI elements make sure to set `runOnMainThread:YES`, the Dribbble 
 requests will still be asynchronous but the passed in block will be executed on the main thread. 
 */

@interface SPPlayer : SPObject

/// The real name of the player.
@property (strong, nonatomic, readonly) NSString *name;
/// The username of the player.
@property (strong, nonatomic, readonly) NSString *username;
/// The url of the player's profile.
@property (strong, nonatomic, readonly) NSURL *url;
/// The url of the player's avatar.
@property (strong, nonatomic, readonly) NSURL *avatarUrl;
/// The location of the player.
@property (strong, nonatomic, readonly) NSString *location;
/// The player's twitter name.
@property (strong, nonatomic, readonly) NSString *twitterScreenName;
/** The id of this player who drafted this player.
 
 If this player was not drafted the value is `NSNotFound`.
 */
@property (nonatomic, readonly) NSUInteger draftedByPlayerId;
/// The number of shots the player has posted.
@property (nonatomic, readonly) NSUInteger shotsCount;
/// The number of players the player has drafted.
@property (nonatomic, readonly) NSUInteger drafteesCount;
/// The number of people the player follows.
@property (nonatomic, readonly) NSUInteger followersCount;
/// The number of followers the player has.
@property (nonatomic, readonly) NSUInteger followingCount;
/// The number of comments the player has posted.
@property (nonatomic, readonly) NSUInteger commentsCount;
/// The number of comments the player's shots have received.
@property (nonatomic, readonly) NSUInteger commentsReceivedCount;
/// The number of shots the player has liked.
@property (nonatomic, readonly) NSUInteger likesCount;
/// The number of likes the player's shots have received.
@property (nonatomic, readonly) NSUInteger likesReceivedCount;
/// The number of rebounds the player has posted.
@property (nonatomic, readonly) NSUInteger reboundsCount;
/// The number of rebounds the player's shots have received.
@property (nonatomic, readonly) NSUInteger reboundsReceivedCount;

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
                    withBlock:(void (^)(SPImage *image))block;

@end
