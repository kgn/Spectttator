//
//  SPMethods.h
//  Spectttator
//
//  Created by David Keegan on 6/27/11.
//  Copyright 2011 David Keegan.
//

#import <Foundation/Foundation.h>
#import "SPPagination.h"

@interface SPMethods : NSObject

+ (NSOperationQueue *)operationQueue;
+ (NSString *)pagination:(NSDictionary *)pagination;

+ (void)requestPlayersWithURL:(NSURL *)url 
              runOnMainThread:(BOOL)runOnMainThread 
                    withBlock:(void (^)(NSArray *, SPPagination *))block;

+ (void)requestShotsWithURL:(NSURL *)url 
            runOnMainThread:(BOOL)runOnMainThread 
                  withBlock:(void (^)(NSArray *, SPPagination *))block;

+ (void)requestCommentsWithURL:(NSURL *)url 
               runOnMainThread:(BOOL)runOnMainThread 
                     withBlock:(void (^)(NSArray *, SPPagination *))block;

+ (void)requestImageWithURL:(NSURL *)url 
            runOnMainThread:(BOOL)runOnMainThread 
                  withBlock:(void (^)(
#if TARGET_OS_IPHONE
                                      UIImage *
#else
                                      NSImage *
#endif
                                      ))block;

+ (NSData *)dataFromUrl:(NSURL *)url;
+ (id)jsonDataFromUrl:(NSURL *)url;

@end
