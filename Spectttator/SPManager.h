//
//  SPManager.h
//  Spectttator
//
//  Created by David Keegan on 6/25/11.
//  Copyright 2011 InScopeApps {+}. All rights reserved.
//
//  Singleton from http://boredzo.org/blog/archives/2009-06-17/doing-it-wrong
//

#import <Foundation/Foundation.h>
#import "SPShot.h"
#import "SPPlayer.h"
#import "SPPagination.h"

#define SPDebutsList @"debuts"
#define SPEveryoneList @"everyone"
#define SPPopularList @"popular"

@interface SPManager : NSObject

+ (id)sharedManager;

- (void)shotInformationForIdentifier:(NSUInteger)identifier withBlock:(void (^)(SPShot *))block;
- (void)playerInformationForUsername:(NSString *)username withBlock:(void (^)(SPPlayer *))block;

- (void)playerFollowers:(NSString *)player withBlock:(void (^)(NSArray *, SPPagination *))block;
- (void)playerFollowers:(NSString *)player withBlock:(void (^)(NSArray *, SPPagination *))block forPagination:(NSDictionary *)pagination;

- (void)playerFollowing:(NSString *)player withBlock:(void (^)(NSArray *, SPPagination *))block;
- (void)playerFollowing:(NSString *)player withBlock:(void (^)(NSArray *, SPPagination *))block forPagination:(NSDictionary *)pagination;

- (void)playerDraftees:(NSString *)player withBlock:(void (^)(NSArray *, SPPagination *))block;
- (void)playerDraftees:(NSString *)player withBlock:(void (^)(NSArray *, SPPagination *))block forPagination:(NSDictionary *)pagination;

- (void)shotsForList:(NSString *)list withBlock:(void (^)(NSArray *, SPPagination *))block;
- (void)shotsForList:(NSString *)list withBlock:(void (^)(NSArray *, SPPagination *))block forPagination:(NSDictionary *)pagination;

- (void)shotsForPlayer:(NSString *)player withBlock:(void (^)(NSArray *, SPPagination *))block;
- (void)shotsForPlayer:(NSString *)player withBlock:(void (^)(NSArray *, SPPagination *))block forPagination:(NSDictionary *)pagination;

- (void)shotsForPlayerFollowing:(NSString *)player withBlock:(void (^)(NSArray *, SPPagination *))block;
- (void)shotsForPlayerFollowing:(NSString *)player withBlock:(void (^)(NSArray *, SPPagination *))block forPagination:(NSDictionary *)pagination;

- (void)shotsForPlayerLikes:(NSString *)player withBlock:(void (^)(NSArray *, SPPagination *))block;
- (void)shotsForPlayerLikes:(NSString *)player withBlock:(void (^)(NSArray *, SPPagination *))block forPagination:(NSDictionary *)pagination;

@end
