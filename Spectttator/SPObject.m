//
//  SPObject.m
//  Spectttator
//
//  Created by David Keegan on 12/19/11.
//  Copyright (c) 2011 David Keegan. All rights reserved.
//

#import "SPObject.h"

@interface SPObject()
@property (readonly, nonatomic, readwrite) NSUInteger identifier;
@property (readonly, nonatomic, readwrite) NSDate *createdAt;
@end

@implementation SPObject

- (id)initWithDictionary:(NSDictionary *)dictionary{
    if((self = [super init])){
        self.identifier = [dictionary uintSafelyFromKey:@"id"];
        NSString *createdAt = [dictionary stringSafelyFromKey:@"created_at"];
        if(createdAt != nil){
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy/MM/dd HH:mm:ss ZZZZ"];
            self.createdAt = [[formatter dateFromString:createdAt] retain];
            [formatter release];
        }
    }
    
    return self;
}

- (NSUInteger)hash{
    return self.identifier;
}

- (BOOL)isEqual:(id)object{
    if([object isKindOfClass:[self class]]){
        return (self.identifier == [(SPObject *)object identifier]);
    }
    return NO;
}

- (void)dealloc{
    [_createdAt release];
    [super dealloc];
}

@end
