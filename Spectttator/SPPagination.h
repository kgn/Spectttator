//
//  SPPagination.h
//  Spectttator
//
//  Created by David Keegan on 6/26/11.
//  Copyright 2011 InScopeApps {+}. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SPPagination : NSObject{
    NSUInteger _page;
    NSUInteger _pages;
    NSUInteger _perPages;
    NSUInteger _total;
}

@property(readonly) NSUInteger page;
@property(readonly) NSUInteger pages;
@property(readonly) NSUInteger perPages;
@property(readonly) NSUInteger total;

+ (NSDictionary *)page:(NSUInteger)page;
+ (NSDictionary *)perPage:(NSUInteger)perPage;
+ (NSDictionary *)page:(NSUInteger)page perPage:(NSUInteger)perPage;

+ (id)paginationWithDictionary:(NSDictionary *)dictionary;
- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
