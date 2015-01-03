//
//  JCSolution.m
//  JapanCrosswords
//
//  Created by Alexander Naumenko on 25.04.13.
//  Copyright (c) 2013 Alexander Naumenko. All rights reserved.
//

#import "JCSolution.h"

@implementation JCSolution

@synthesize matrCells;

- (void)dealloc
{
    [matrCells release];
    [super dealloc];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init])
    {
        matrCells = [[aDecoder decodeObjectForKey:@"matrCells"] retain];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:matrCells forKey:@"matrCells"];
}

@end
