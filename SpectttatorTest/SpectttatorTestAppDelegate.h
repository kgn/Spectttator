//
//  SpectttatorTestAppDelegate.h
//  SpectttatorTest
//
//  Created by David Keegan on 6/25/11.
//  Copyright 2011 David Keegan.
//

#import <Cocoa/Cocoa.h>

@interface SpectttatorTestAppDelegate : NSObject <NSApplicationDelegate, NSTextViewDelegate>

@property (retain, nonatomic) IBOutlet NSWindow *window;
@property (retain, nonatomic) IBOutlet NSProgressIndicator *spinner;
@property (retain, nonatomic) IBOutlet NSTextField *username;
@property (retain, nonatomic) IBOutlet NSTextView *shots;
@property (retain, nonatomic) IBOutlet NSPopUpButton *listPopup;
@property (retain, nonatomic) IBOutlet NSTextView *listShots;
@property (retain, nonatomic) IBOutlet NSImageView *lastPlayerShot;
@property (retain, nonatomic) IBOutlet NSImageView *lastListShot;
@property (retain, nonatomic) IBOutlet NSImageView *avatar;
@property BOOL userUpdating, listUpdating;

- (IBAction)userChanged:(id)sender;
- (IBAction)listChanged:(id)sender;

@end
