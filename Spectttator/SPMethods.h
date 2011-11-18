//
//  SPMethods.h
//  Spectttator
//
//  Created by David Keegan on 6/27/11.
//  Copyright 2011 David Keegan.
//

#import <Foundation/Foundation.h>
#import "SPPagination.h"

#if TARGET_OS_IPHONE
#define SPImage UIImage
#else
#define SPImage NSImage
#endif

@interface NSDictionary(Spectttator)

- (NSUInteger)uintSafelyFromKey:(id)key;
- (NSString *)stringSafelyFromKey:(id)key;
- (NSURL *)URLSafelyFromKey:(id)key;
- (id)objectSafelyFromKey:(id)key;

@end

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
                  withBlock:(void (^)(SPImage *))block;

@end
