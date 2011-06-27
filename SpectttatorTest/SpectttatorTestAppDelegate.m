//
//  SpectttatorTestAppDelegate.m
//  SpectttatorTest
//
//  Created by David Keegan on 6/25/11.
//  Copyright 2011 InScopeApps {+}. All rights reserved.
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
@synthesize userUpdating = _userUpdating;
@synthesize listUpdating = _listUpdating;

- (void)applicationDidFinishLaunching:(NSNotification *)notification{
    NSString *username = @"inscopeapps";
    
    //populate the ui
    [self.username setStringValue:username];
    [self userChanged:self.username];
    [self listChanged:self.listPopup];
    
    //run commands that don't appear in the ui
    [[SPManager sharedManager] shotInformationForIdentifier:199295 withBlock:^(SPShot *shot){
        NSLog(@"Shot Information: %@", shot);
        [shot reboundsWithBlock:^(NSArray *rebounds, SPPagination *pagination){
            NSLog(@"Rebounds for '%@': %@", shot.title, rebounds);
        }];
        [shot commentsWithBlock:^(NSArray *comments, SPPagination *pagination){
            NSLog(@"Comments for '%@': %@", shot.title, comments);
        }];        
    }];
    
    [[SPManager sharedManager] playerInformationForUsername:username withBlock:^(SPPlayer *player){
        NSLog(@"Player information for %@: %@", username, player);
    }];
    
    [[SPManager sharedManager] playerFollowers:@"simplebits" withBlock:^(NSArray *players, SPPagination *pagination){
        NSLog(@"Players following %@: %@", username, players);
    } andPagination:[SPPagination page:2 perPage:20]];
    
    [[SPManager sharedManager] shotsForPlayerFollowing:username withBlock:^(NSArray *shots, SPPagination *pagination){
        NSLog(@"Shot by player %@ is following: %@", username, shots);
    }]; 
    
    [[SPManager sharedManager] shotsForPlayerLikes:username withBlock:^(NSArray *shots, SPPagination *pagination){
        NSLog(@"Shot %@ likes: %@", username, shots);
    } andPagination:[SPPagination page:10]];
    
    [[SPManager sharedManager] playerFollowing:username withBlock:^(NSArray *shots, SPPagination *pagination){
        NSLog(@"Shot %@ likes: %@", username, shots);
    } andPagination:[SPPagination page:2]];
    
    [[SPManager sharedManager] playerDraftees:username withBlock:^(NSArray *players, SPPagination *pagination){
        NSLog(@"Players %@ drafted: %@", username, players);
    }];
}

- (IBAction)userChanged:(id)sender{
    NSString *user = [sender stringValue];
    [self.shots setString:@""];  
    if(![user length]){
        return;
    }
    [self.spinner startAnimation:nil];
    [self.username setEnabled:NO];
    self.userUpdating = YES;
    
    //get shots from player
    [[SPManager sharedManager] shotsForPlayer:user withBlock:^(NSArray *shots, SPPagination *pagination){
        NSLog(@"Recieved shot data for %@", user);
        NSLog(@"With pagination: %@", pagination);
        @autoreleasepool {
            for(SPShot *shot in shots){
                NSString *string = [NSString stringWithFormat:@"%@\n", shot.title];
                NSMutableAttributedString *shotString = [NSAttributedString hyperlinkFromString:string withURL:shot.url];
                [[self.shots textStorage] appendAttributedString:shotString];
            }
        }
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
    [self.spinner startAnimation:nil];
    [self.listPopup setEnabled:NO];
    self.listUpdating = YES;
    
    //get shots from a list
    [[SPManager sharedManager] shotsForList:list withBlock:^(NSArray *shots, SPPagination *pagination){
        NSLog(@"Recieved list data for %@", list);
        NSLog(@"With pagination: %@", pagination);
        @autoreleasepool {
            for(SPShot *shot in shots){
                NSString *string = [NSString stringWithFormat:@"%@\n", shot.title];
                NSMutableAttributedString *shotString = [NSAttributedString hyperlinkFromString:string withURL:shot.url];
                [[self.listShots textStorage] appendAttributedString:shotString];
            }
        }
        self.listUpdating = NO;
        if(!self.userUpdating){
            [self.spinner stopAnimation:nil];
        }
        [self.listPopup setEnabled:YES];
    }];    
}

@end
