Spectttator
========

Spectttator is an Objective-C framework for OSX and iOS that uses [Grand Central Dispatch](http://developer.apple.com/library/mac/#documentation/Performance/Reference/GCD_libdispatch_Ref/Reference/reference.html) and [blocks](http://developer.apple.com/library/mac/#documentation/Cocoa/Conceptual/Blocks/Articles/00_Introduction.html) to provide an easy to use, non-blocking, closure style interface to the [Dribbble api](http://dribbble.com/api).

Below is a quick overview of the framework, to get an in depth look check out the [documentation](http://inscopeapps.github.com/Spectttator).

Example
--------

The following snippet demonstrates how to get the last 10 shots a player liked.

    #import <Spectttator/Spectttator.h>
    
    NSString *username = @"inscopeapps";
    
    [[SPManager sharedManager] shotsForPlayerLikes:username withBlock:^(NSArray *shots, SPPagination *pagination){
        NSLog(@"Shots %@ likes: %@", username, shots);
    } andPagination:[SPPagination perPage:10]];

This is non-blocking, `NSLog` will run whenever the shot data has finished loading but the block still has access to everything in the scope from where it was defined.

SpectttatorTest
--------

SpectttatorTest is a sample application that demonstrates how to use Spectttator to create a non-blocking user interface that displays information from Dribbble. It also runs every method, this was used during testing and development and is a great way to see how to use Spectttator.

Check out [this video](http://vimeo.com/25704164) to see SpectttatorTest in action.

![SpectttatorTest](https://github.com/InScopeApps/Spectttator/raw/master/SpectttatorTest/SpectttatorTest.png)

SpectttatorTest-iOS
--------

SpectttatorTest-iOS is a simple iPhone app that demonstrates how to use Spectttator in iOS.

![SpectttatorTest](https://github.com/InScopeApps/Spectttator/raw/master/SpectttatorTest-iOS/SpectttatorTest-iOS.png)

Credits
--------

* The Dribbble team for creating the [web api](http://dribbble.com/api)
* JSON parsing by [SBJson](https://github.com/stig/json-framework)
* Documentation by [appledoc](https://github.com/tomaz/appledoc)

License
--------

Copyright (c) 2011 David Keegan

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
