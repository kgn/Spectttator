//
//  SpectttatorTestAppDelegate.h
//  SpectttatorTest
//
//  Created by David Keegan on 6/25/11.
//  Copyright 2011 David Keegan.
//

#import <Cocoa/Cocoa.h>

@interface SpectttatorTestAppDelegate : NSObject <NSApplicationDelegate, NSTextViewDelegate>

@property (strong, nonatomic) IBOutlet NSWindow *window;
@property (strong, nonatomic) IBOutlet NSProgressIndicator *spinner;
@property (strong, nonatomic) IBOutlet NSTextField *username;
@property (strong, nonatomic) IBOutlet NSTextView *shots;
@property (strong, nonatomic) IBOutlet NSPopUpButton *listPopup;
@property (strong, nonatomic) IBOutlet NSTextView *listShots;
@property (strong, nonatomic) IBOutlet NSImageView *lastPlayerShot;
@property (strong, nonatomic) IBOutlet NSImageView *lastListShot;
@property (strong, nonatomic) IBOutlet NSImageView *avatar;
@property BOOL userUpdating, listUpdating;

- (IBAction)userChanged:(id)sender;
- (IBAction)listChanged:(id)sender;

@end
