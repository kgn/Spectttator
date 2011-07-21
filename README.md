Spectttator
========

Spectttator is an Objective-C framework for OSX and iOS that uses [Grand Central Dispatch](http://developer.apple.com/library/mac/#documentation/Performance/Reference/GCD_libdispatch_Ref/Reference/reference.html) and [blocks](http://developer.apple.com/library/mac/#documentation/Cocoa/Conceptual/Blocks/Articles/00_Introduction.html) to provide an easy to use, non-blocking, closure style interface to the [Dribbble api](http://dribbble.com/api).

Below is a quick overview of the framework, to get an in depth look check out the [documentation](http://inscopeapps.github.com/Spectttator).

*There is a [branch](https://github.com/InScopeApps/Spectttator/tree/SBJson) of Spectttator that still uses [SBJson](https://github.com/stig/json-framework).*

Example
--------

The following snippet demonstrates how to get the last 10 shots a player liked.

    #import <Spectttator/Spectttator.h>
    NSString *username = @"inscopeapps";
    [SPRequest shotsForPlayerLikes:username 
                    withPagination:[SPPagination perPage:10]     
                   runOnMainThread:NO 
                         withBlock:^(NSArray *shots, SPPagination *pagination){
                             NSLog(@"Shot %@ likes: %@", username, shots);
                         }];

This is non-blocking, `NSLog` will run whenever the comment data has finished loading, but the block still has access to everything in the scope from where it was defined. If the block is updating UI elements make sure to set `runOnMainThread:YES`, the Dribbble requests will still be asynchronous but the passed in block will be executed on the main thread.

SpectttatorTest
--------

SpectttatorTest is a sample application that demonstrates how to use Spectttator to create a non-blocking user interface that displays information from Dribbble. It also runs every method, this was used during testing and development and is a great way to see how to use Spectttator.

Check out [this video](http://vimeo.com/25704164) to see SpectttatorTest in action.

![SpectttatorTest](https://github.com/InScopeApps/Spectttator/raw/master/SpectttatorTest/SpectttatorTest.png)

SpectttatorTest-iOS
--------

SpectttatorTest-iOS is a simple iPhone app that demonstrates how to use Spectttator in iOS.

![SpectttatorTest](https://github.com/InScopeApps/Spectttator/raw/master/SpectttatorTest-iOS/SpectttatorTest-iOS.png)

Change Log
--------

* **3.1** - Updating for lion and iOS 5 by using arc and NSJSONSerialization.
* **3.0** - Renaming SPManager to SPRequest. SPRequest is no longer a singleton and all it's methods are now simply class methods.
* **2.1** - Switching to 64bit, this caused no interface changes.
* **2.0** - Overhaul of all the methods by adding runOnMainThread to make it easy to update UI elements inside the block on the main thread.
* **1.0** - Initial release with support for the full Dribbble api.

License
--------

Copyright (c) 2011 David Keegan

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
