//
//  SPComment.h
//  Spectttator
//
//  Created by David Keegan on 6/27/11.
//  Copyright 2011 David Keegan.
//

#import <Foundation/Foundation.h>
#import "SPPlayer.h"

/** The `SPComment` class provides a programmatic interface for interacting 
 with Dribbble comments.
 
 The following snippet demonstrates how to retrieve comments for a shot.
 
    #import <Spectttator/Spectttator.h>
     
    [SPRequest shotInformationForIdentifier:199295 runOnMainThread:NO withBlock:^(SPShot *shot){
        [shot commentsWithPagination:nil runOnMainThread:NO withBlock:^(NSArray *comments, SPPagination *pagination){
            NSLog(@"Comments for '%@': %@", shot.title, comments);
        }];
    }];
 
 This is non-blocking, `NSLog` will run whenever the comment data has finished loading,
 but the block still has access to everything in the scope from where it was defined.
 If the block is updating UI elements make sure to set `runOnMainThread:YES`, the Dribbble 
 requests will still be asynchronous but the passed in block will be executed on the main thread.
 */

@interface SPComment : NSObject

/// The unique id of the comment.
@property (readonly) NSUInteger identifier;
/// The text of the comment.
@property (readonly) NSString *body;
/// The number of players who liked the comment.
@property (readonly) NSUInteger likesCount;
/// The date the comment was created.
@property (readonly) NSDate *createdAt;
/** The player who posted the comment.
 @see SPPlayer
 */
@property (readonly) SPPlayer *player;

///----------------------------
/// @name Initializing a SPComment Object
///----------------------------

/** 
 Returns a Spectttator comment object initialized with the given comment data. 
 
 There is no need to call this method directly, it is used by 
 higher level methods like 
 `[SPShot commentsWithPagination:runOnMainThread:withBlock:]`.
 @param dictionary A dictionary of comment data.
 @return An initialized `SPComment` object.
 */
- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
