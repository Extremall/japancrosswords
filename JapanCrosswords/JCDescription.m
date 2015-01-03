//
//  JCDescription.m
//  JapanCrosswords
//
//  Created by Alexander Naumenko on 12.04.13.
//  Copyright (c) 2013 Alexander Naumenko. All rights reserved.
//

#import "JCDescription.h"

@implementation JCDescription

@synthesize leftMatr;
@synthesize topMatr;
@synthesize colorMatr;

- (void)dealloc
{
    self.leftMatr = nil;
    self.topMatr = nil;
    self.colorMatr = nil;
    [super dealloc];
}

- (id)init
{
    if (self = [super init])
    {
        leftMatr = [[NSMutableArray alloc] init];
        topMatr = [[NSMutableArray alloc] init];
        colorMatr = [[NSMutableArray alloc] init];
        [colorMatr addObject:[UIColor whiteColor]];
        [colorMatr addObject:[UIColor blackColor]];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init])
    {
        leftMatr = [[aDecoder decodeObjectForKey:@"leftMatr"] retain];
        topMatr = [[aDecoder decodeObjectForKey:@"topMatr"] retain];
        colorMatr = [[aDecoder decodeObjectForKey:@"colorMatr"] retain];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:leftMatr forKey:@"leftMatr"];
    [aCoder encodeObject:topMatr forKey:@"topMatr"];
    [aCoder encodeObject:colorMatr forKey:@"colorMatr"];
}

@end

@implementation JCLine

@synthesize length;
@synthesize color;

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init])
    {
        length = [[aDecoder decodeObjectForKey:@"length"] intValue];
        color = [[aDecoder decodeObjectForKey:@"color"] intValue];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:@(length) forKey:@"length"];
    [aCoder encodeObject:@(color) forKey:@"color"];
}

@end