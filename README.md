Spectttator
========

Spectttator is an Objective-C framework for the [dribbble api](http://dribbble.com/api). It uses [Grand Central Dispatch](http://developer.apple.com/library/mac/#documentation/Performance/Reference/GCD_libdispatch_Ref/Reference/reference.html) and [blocks](http://developer.apple.com/library/mac/#documentation/Cocoa/Conceptual/Blocks/Articles/00_Introduction.html) to provide an easy to use, non-blocking, closure style api for dribbble!

Below is a quick overview of the framework, to get an indepth look check out the [documentation](http://inscopeapps.github.com/Spectttator).

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

SpectttatorTest is a sample application that demonstrates how to use Spectttator to create a non-blocking user interface that displays information from dribbble. It also runs every method, this was used during testing and development and is a great way to see how to use Spectttator.

Check out [this video](http://vimeo.com/25704164) to see SpectttatorTest in action.

![SpectttatorTest](https://github.com/InScopeApps/Spectttator/raw/master/SpectttatorTest/SpectttatorTest.png)
