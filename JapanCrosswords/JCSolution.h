//
//  JCSolution.h
//  JapanCrosswords
//
//  Created by Alexander Naumenko on 25.04.13.
//  Copyright (c) 2013 Alexander Naumenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JCSolution : NSObject<NSCoding>
{
    NSMutableArray *matrCells;
}

@property (nonatomic, retain) NSMutableArray *matrCells;

@end
