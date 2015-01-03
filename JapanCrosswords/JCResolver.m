//
//  JCResolver.m
//  JapanCrosswords
//
//  Created by Alexander Naumenko on 19.04.13.
//  Copyright (c) 2013 Alexander Naumenko. All rights reserved.
//

#import "JCResolver.h"

@implementation JCResolver

+ (void)printMatr:(NSArray *)rows
{
    printf("\n");
    printf("Matr: \n");
    for (int i = 0; i < [rows count]; i++)
    {
        NSArray *row = rows[i];
        for (int j = 0; j < [row count]; j++)
        {
            int c = [row[j] intValue];
            printf("%4d", c);
        }
        printf("\n");
    }
}


- (void)addCandidate:(NSArray *)sol
{
    if (solution == nil)
        solution = [NSMutableArray arrayWithArray:sol];
    else
    {
        for (int i = 0; i < [sol count]; i++)
        {
            int c1 = [solution[i] intValue];
            int c2 = [sol[i] intValue];
            if (c1 != -1 && c1 != c2)
            {
                [solution replaceObjectAtIndex:i withObject:@(-1)];
            }
        }
    }
}

- (void)checkSolution
{
    NSMutableArray *sol = [NSMutableArray arrayWithCapacity:[cells count]];
    for (int i = 0; i < [cells count]; i++)
        [sol addObject:@(0)];
    
    for (int i = 0; i < [codes count]; i++)
    {
        int pos = [positions[i] intValue];
        JCLine *line = (JCLine *)codes[i];
        for (int j = 0; j < line.length; j++)
        {
            [sol replaceObjectAtIndex:pos + j withObject:@(line.color)];
        }
    }
    
    BOOL hasError = NO;
    for (int i = 0; i < [cells count]; i++)
    {
        int c1 = [cells[i] intValue];
        int c2 = [sol[i] intValue];
        
        if (c1 != -1 && c1 != c2)
        {
            hasError = YES;
            break;
        }
    }
    
    if (!hasError)
    {
        [self addCandidate:sol];
    }
}

- (void)generateSolutionWithPos:(NSInteger)pos
                     codeNumber:(NSInteger)codeNumber
{
    [positions addObject:@(pos)];
    
    if (codeNumber == [codes count] - 1)
    {
        [self checkSolution];
        
        [positions removeLastObject];
        return;
    }
    
    JCLine *line = (JCLine *)codes[codeNumber];
    int q = [cells count] - pos - line.length - ([codes count] - codeNumber - 1);
    for (int i = codeNumber + 1; i < [codes count]; i++)
    {
        JCLine *ln = codes[i];
        q -= ln.length;
    }
    
    for (int i = pos; i <= pos + q; i++)
    {
        [self generateSolutionWithPos:i + line.length + 1
                           codeNumber:codeNumber + 1];
    }
    
    [positions removeLastObject];
}

// Legend:
// 0 - empty cell
// 1, 2, ... - filled cell
// -1 - undefined cell
//
- (NSArray *)resolveCells:(NSArray *)_cells withCodes:(NSArray *)_codes
{
    codes = _codes;
    cells = _cells;
    
    solution = nil;
    
    if ([codes count] == 0)
    {
        solution = [NSMutableArray arrayWithCapacity:cells.count];
        for (int i = 0; i < cells.count; i++)
            [solution addObject:@(0)];
        
        return solution;
    }
    
    positions = [NSMutableArray arrayWithCapacity:[codes count]];
    
    JCLine *line = codes[0];
    int q = [cells count] - line.length - ([codes count] - 1);
    
    for (int i = 1; i < [codes count]; i++)
    {
        JCLine *ln = codes[i];
        q -= ln.length;
    }
    
    for (int i = 0; i <= q; i++)
        [self generateSolutionWithPos:i codeNumber:0];
    
    return solution;
}

- (BOOL)resolveMatrStep:(NSMutableArray *)rows
               rowCodes:(NSArray *)rowCodes
               colCodes:(NSArray *)colCodes
{
    NSInteger rowCount = [rows count];
    NSInteger colCount = [rows[0] count];
    
    BOOL isChanged = NO;
    
    for (int i = 0; i < rowCount; i++)
    {
        NSArray *_cells = [NSMutableArray arrayWithArray:rows[i]];
        NSArray *_codes = rowCodes[i];
        
        NSArray *sol = [self resolveCells:_cells withCodes:_codes];
        
        if (sol == nil)
        {
            NSLog(@"Error! The solution does not exist.");
            return NO;
        }
        
        for (int j = 0; j < colCount; j++)
        {
            int c1 = [_cells[j] intValue];
            int c2 = [sol[j] intValue];
            if (c1 != c2)
            {
                isChanged = YES;
                [rows replaceObjectAtIndex:i withObject:sol];
                break;
            }
        }
    }
    
    for (int i = 0; i < colCount; i++)
    {
        NSMutableArray *_cells = [NSMutableArray array];
        for (int j = 0; j < rowCount; j++)
        {
            NSMutableArray *row = rows[j];
            NSInteger c = [row[i] intValue];
            [_cells addObject:@(c)];
        }
        
        NSArray *_codes = colCodes[i];
        
        NSArray *sol = [self resolveCells:_cells withCodes:_codes];
        
        if (sol == nil)
        {
            NSLog(@"Error! The solution does not exist.");
            return NO;
        }
        
        
        for (int j = 0; j < rowCount; j++)
        {
            int c1 = [_cells[j] intValue];
            int c2 = [sol[j] intValue];
            if (c1 != c2)
            {
                isChanged = YES;
                NSMutableArray *row = rows[j];
                [row replaceObjectAtIndex:i withObject:@(c2)];
            }
        }
    }
    
    return isChanged;
}

- (BOOL)resolveMatrStep:(NSMutableArray *)rows jcDescription:(JCDescription *)jcDescription
{
    return [self resolveMatrStep:rows
                        rowCodes:jcDescription.leftMatr
                        colCodes:jcDescription.topMatr];
}

- (void)resolveMatr:(NSMutableArray *)rows jcDescription:(JCDescription *)jcDescription
{
    BOOL isChanged = NO;
    do
    {
        isChanged = [self resolveMatrStep:rows jcDescription:jcDescription];
    } while (isChanged);
}

- (NSArray *)resolveJCDescription:(JCDescription *)jcDescription
{
    NSMutableArray *rows = [NSMutableArray arrayWithCapacity:jcDescription.leftMatr.count];
    for (int i = 0; i < jcDescription.leftMatr.count; i++)
    {
        NSMutableArray *row = [NSMutableArray arrayWithCapacity:jcDescription.topMatr.count];
        for (int j = 0; j < jcDescription.topMatr.count; j++)
            [row addObject:@(-1)];
        [rows addObject:row];
    }
    
    [self resolveMatr:rows jcDescription:jcDescription];
    
    return rows;
}

@end
