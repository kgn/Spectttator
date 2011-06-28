//
//  SPComment.h
//  Spectttator
//
//  Created by David Keegan on 6/27/11.
//  Copyright 2011 InScopeApps {+}. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SPPlayer.h"

/** The `SPComment` class provides a programmatic interface for interacting 
 with dribbble comments.
 
 The following snippet demonstrates how to retrieve comments for a shot.
 
    #import <Spectttator/Spectttator.h>
     
    [[SPManager sharedManager] shotInformationForIdentifier:199295 withBlock:^(SPShot *shot){
        NSLog(@"Shot Information: %@", shot);
        [shot commentsWithBlock:^(NSArray *comments, SPPagination *pagination){
            NSLog(@"Comments for '%@': %@", shot.title, comments);
        }];        
    }];
 
 This is non-blocking, `NSLog` will run whenever the shot data has finished loading but the 
 block still has access to everything in the scope from where it was defined.
 */

@interface SPComment : NSObject{
    NSUInteger _identifier;
    NSString *_body;
    NSUInteger _likes_count;
    NSDate *_created_at;
    SPPlayer *_player;
}

/// The unique id number of the comment.
@property (readonly) NSUInteger identifier;
/// The body text of the comment.
@property (readonly) NSString *body;
/// The number of players who liked the comment.
@property (readonly) NSUInteger likes_count;
/// The date the comment was created.
@property (readonly) NSDate *created_at;
/** The player who posted the comment.
 @see SPPlayer
 */
@property (readonly) SPPlayer *player;

///----------------------------
/// @name Initializing a SPComment Object
///----------------------------

/** 
 Returns a `SPComment` object initialized with the given comment data. 
 
 There is no need to call this method directly, it is used by 
 higher level methods like `[SPShot commentsWithBlock:]`.
 @param dictionary A dictionary of comment data.
 @return An initialized `SPComment` object.
 */
- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
