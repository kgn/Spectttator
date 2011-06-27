//
//  NSAttributedString+Hyperlink.h
//  Spectttator
//
//  Created by David Keegan on 6/26/11.
//  Copyright 2011 InScopeApps {+}. All rights reserved.
//
//  From http://developer.apple.com/library/mac/#qa/qa1487/_index.html
//

#import <Foundation/Foundation.h>

@interface NSAttributedString (Hyperlink)

+(id)hyperlinkFromString:(NSString*)inString withURL:(NSURL*)aURL;

@end
