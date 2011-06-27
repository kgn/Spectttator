Spectttator
========

Spectttator is an Objective-C framework for the [dribbble api](http://dribbble.com/api). It uses [Grand Central Dispatch](http://developer.apple.com/library/mac/#documentation/Performance/Reference/GCD_libdispatch_Ref/Reference/reference.html) and [blocks](http://developer.apple.com/library/mac/#documentation/Cocoa/Conceptual/Blocks/Articles/00_Introduction.html) to provide an easy to use, non-blocking, closure style api for dribbble!

Example
--------

The following snippet demonstrates how to get the last 10 shots a player liked.

    #import <Spectttator/Spectttator.h>
    NSString *username = @"inscopeapps";
    [[SPManager sharedManager] shotsForPlayerLikes:username withBlock:^(NSArray *shots, SPPagination *pagination){
        NSLog(@"Shots %@ likes: %@", username, shots);
    } andPagination:[SPPagination page:10]];

This is non-blocking, `NSLog` will run whenever the shot data has finished loading but the block still has access to everything in the scope from which it was defined.

SPManager
--------

[SPManager](https://github.com/InScopeApps/Spectttator/blob/master/Spectttator/SPManager.h) is a singleton that contains most of the dribbble api calls, the other methods are on the [`SPShot`](https://github.com/InScopeApps/Spectttator/blob/master/Spectttator/SPShot.h) object.

Pagination
--------

Most dribbble api calls take `page` and `per_page` to define which page of data to return and how many items should be contained. In Spectttator this can be defined by passing a [`SPPagination`](https://github.com/InScopeApps/Spectttator/blob/master/Spectttator/SPPagination.h) object to the `andPagination:` parameter.

    [SPPagination page:5]
    [SPPagination perPage:20]
    [SPPagination page:2 perPage:20]

Under the hood these helper functions are simply creating dictionaries.

Calls that are pagable return an [`SPPagination`](https://github.com/InScopeApps/Spectttator/blob/master/Spectttator/SPPagination.h) object to the block, this object contains the returned pagination information: page, pages, perPage, total.

SpectttatorTest
--------

SpectttatorTest is a sample application that demonstrates how to use Spectttator to create a non-blocking user interface that displays information from dribbble. It also runs every method which was used during testing and development and show how to use each method.

![SpectttatorTest](https://github.com/InScopeApps/Spectttator/raw/master/SpectttatorTest/SpectttatorTest.png)
