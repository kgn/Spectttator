//
//  SpectttatorTestAppDelegate.h
//  SpectttatorTest
//
//  Created by David Keegan on 6/25/11.
//  Copyright 2011 InScopeApps {+}. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface SpectttatorTestAppDelegate : NSObject <NSApplicationDelegate, NSTextViewDelegate> {
    NSWindow *_window;
    NSProgressIndicator *_spinner;
    NSTextField *_username;
    NSTextView *_shots;
    NSPopUpButton *_listPopup;
    NSTextView *_listShots;
    NSImageView *_lastPlayerShot;
    NSImageView *_lastListShot;
    NSImageView *_avatar;
    BOOL _userUpdating, _listUpdating;
}

@property (assign) IBOutlet NSWindow *window;
@property (assign) IBOutlet NSProgressIndicator *spinner;
@property (assign) IBOutlet NSTextField *username;
@property (assign) IBOutlet NSTextView *shots;
@property (assign) IBOutlet NSPopUpButton *listPopup;
@property (assign) IBOutlet NSTextView *listShots;
@property (assign) IBOutlet NSImageView *lastPlayerShot;
@property (assign) IBOutlet NSImageView *lastListShot;
@property (assign) IBOutlet NSImageView *avatar;
@property BOOL userUpdating, listUpdating;

- (IBAction)userChanged:(id)sender;
- (IBAction)listChanged:(id)sender;

@end
