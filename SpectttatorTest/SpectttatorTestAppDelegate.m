//
//  SpectttatorTestAppDelegate.m
//  SpectttatorTest
//
//  Created by David Keegan on 6/25/11.
//  Copyright 2011 David Keegan.
//

#import "SpectttatorTestAppDelegate.h"
#import "NSAttributedString+Hyperlink.h"
#import <Spectttator/Spectttator.h>

@implementation SpectttatorTestAppDelegate

@synthesize window = _window;
@synthesize spinner = _spinner;
@synthesize username = _username;
@synthesize shots = _shots;
@synthesize listPopup = _listPopup;
@synthesize listShots = _listShots;
@synthesize lastPlayerShot = _lastPlayerShot;
@synthesize lastListShot = _lastListShot;
@synthesize avatar = _avatar;
@synthesize userUpdating = _userUpdating;
@synthesize listUpdating = _listUpdating;

- (void)applicationDidFinishLaunching:(NSNotification *)notification{
    NSString *username = @"inscopeapps";
    
    //populate the ui
    [self.username setStringValue:username];
    [self userChanged:self.username];
    [self listChanged:self.listPopup];
    
    //run commands that don't appear in the ui
    [[SPManager sharedManager] shotInformationForIdentifier:199295 runOnMainThread:NO withBlock:^(SPShot *shot){
        NSLog(@"Shot Information: %@", shot);
        [shot reboundsRunOnMainThread:NO withBlock:^(NSArray *rebounds, SPPagination *pagination){
            NSLog(@"Rebounds for '%@': %@", shot.title, rebounds);
        }];
        [shot commentsRunOnMainThread:NO withBlock:^(NSArray *comments, SPPagination *pagination){
            NSLog(@"Comments for '%@': %@", shot.title, comments);
        }];
    }];
    
    [[SPManager sharedManager] playerInformationForUsername:username 
                                            runOnMainThread:NO 
                                                  withBlock:^(SPPlayer *player){
                                                      NSLog(@"Player information for %@: %@", username, player);
                                                  }];
    
    [[SPManager sharedManager] playerFollowers:@"simplebits" 
                               runOnMainThread:NO 
                                     withBlock:^(NSArray *players, SPPagination *pagination){
                                         NSLog(@"Players following %@: %@", username, players);
                                     } 
                                 andPagination:[SPPagination page:2 perPage:20]];
    
    [[SPManager sharedManager] shotsForPlayerFollowing:username 
                                       runOnMainThread:NO
                                             withBlock:^(NSArray *shots, SPPagination *pagination){
                                                 NSLog(@"Shot by player %@ is following: %@", username, shots);
                                             }]; 
    
    [[SPManager sharedManager] shotsForPlayerLikes:username 
                                   runOnMainThread:NO 
                                         withBlock:^(NSArray *shots, SPPagination *pagination){
                                             NSLog(@"Shot %@ likes: %@", username, shots);
                                         } andPagination:[SPPagination perPage:10]];
    
    [[SPManager sharedManager] playerFollowing:username 
                               runOnMainThread:NO
                                     withBlock:^(NSArray *shots, SPPagination *pagination){
                                         NSLog(@"Shot %@ likes: %@", username, shots);
                                     } 
                                 andPagination:[SPPagination page:2]];
    
    [[SPManager sharedManager] playerDraftees:username 
                              runOnMainThread:NO
                                    withBlock:^(NSArray *players, SPPagination *pagination){
                                        NSLog(@"Players %@ drafted: %@", username, players);
                                    }];
}

#pragma mark -
#pragma mark Actions

// These actions actions get data from dribbble then
// update the UI on the main thread with runOnMainThread:YES

- (IBAction)userChanged:(id)sender{
    NSString *user = [sender stringValue];
    [self.shots setString:@""];  
    [self.lastPlayerShot setImage:nil];
    [self.avatar setImage:nil];
    if(![user length]){
        return;
    }
    
    [self.spinner startAnimation:nil];
    [self.username setEnabled:NO];
    self.userUpdating = YES;
    
    //get shots from player
    [[SPManager sharedManager] shotsForPlayer:user 
                              runOnMainThread:YES
                                    withBlock:^(NSArray *shots, SPPagination *pagination){
        NSLog(@"Received shot data for %@", user);
        NSLog(@"With pagination: %@", pagination);
        
        //get the last shot uploaded by the player
        if([shots count]){
            [[shots objectAtIndex:0] imageRunOnMainThread:YES withBlock:^(NSImage *image){
                [self.lastPlayerShot setImage:image];
            }];
        }
        
        //get the player's avatar
        if([shots count]){
            [[[shots objectAtIndex:0] player] avatarRunOnMainThread:YES withBlock:^(NSImage *image){
                [self.avatar setImage:image];
            }];       
        }
        
        NSAutoreleasePool *pool =  [[NSAutoreleasePool alloc] init];
            for(SPShot *shot in shots){
                NSString *string = [NSString stringWithFormat:@"%@\n", shot.title];
                NSMutableAttributedString *shotString = [NSAttributedString hyperlinkFromString:string 
                                                                                        withURL:shot.url];
                    [[self.shots textStorage] appendAttributedString:shotString];
            }
        [pool drain];
        
        self.userUpdating = NO;
        if(!self.listUpdating){
            [self.spinner stopAnimation:nil];
        }
        [self.username setEnabled:YES];
    } andPagination:[SPPagination perPage:20]];
}

- (IBAction)listChanged:(id)sender {
    NSString *list = [[sender titleOfSelectedItem] lowercaseString];
    [self.listShots setString:@""];
    [self.lastListShot setImage:nil];
    [self.spinner startAnimation:nil];
    [self.listPopup setEnabled:NO];
    self.listUpdating = YES;
    
    //get shots from a list
    [[SPManager sharedManager] shotsForList:list 
                            runOnMainThread:YES 
                                  withBlock:^(NSArray *shots, SPPagination *pagination){
        NSLog(@"Received list data for %@", list);
        NSLog(@"With pagination: %@", pagination);
        
        //get the last shot uploaded to the list
        if([shots count]){
            [[shots objectAtIndex:0] imageRunOnMainThread:NO withBlock:^(NSImage *image){
                [self.lastListShot setImage:image];
            }];       
        }
        
        NSAutoreleasePool *pool =  [[NSAutoreleasePool alloc] init];
            for(SPShot *shot in shots){
                NSString *string = [NSString stringWithFormat:@"%@\n", shot.title];
                NSMutableAttributedString *shotString = [NSAttributedString hyperlinkFromString:string 
                                                                                        withURL:shot.url];
                    [[self.listShots textStorage] appendAttributedString:shotString];
            }
        [pool drain];
        
        self.listUpdating = NO;
        if(!self.userUpdating){
            [self.spinner stopAnimation:nil];
        }
        [self.listPopup setEnabled:YES];
    }];    
}

@end
