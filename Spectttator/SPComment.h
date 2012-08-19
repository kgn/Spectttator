//
//  SPComment.h
//  Spectttator
//
//  Created by David Keegan on 6/27/11.
//  Copyright 2011 David Keegan.
//

#import <Foundation/Foundation.h>
#import "SPObject.h"

@class SPPlayer;

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

@interface SPComment : SPObject

/// The text of the comment.
@property (copy, nonatomic, readonly) NSString *body;
/// The number of players who liked the comment.
@property (nonatomic, readonly) NSUInteger likesCount;
/** The player who posted the comment.
 @see SPPlayer
 */
@property (retain, nonatomic, readonly) SPPlayer *player;

@end
