//
//  JCCenterView.m
//  JapanCrosswords
//
//  Created by Alexander Naumenko on 11.04.13.
//  Copyright (c) 2013 Alexander Naumenko. All rights reserved.
//

#import "JCCenterView.h"

@implementation JCCenterView

@synthesize delegate;
@synthesize jcSolution;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        jcSolution = [[JCSolution alloc] init];
    }
    return self;
}

- (id)init
{
    if (self = [super init])
    {
        jcSolution = [[JCSolution alloc] init];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        jcSolution = [[JCSolution alloc] init];
    }
    return self;
}

- (void)dealloc
{
    [jcSolution release];
    [matrCells release];
    [super dealloc];
}

- (void)loadCells
{
    matrCells = [jcSolution.matrCells retain];
    rowCount = [matrCells count];
    colCount = [(NSArray *)matrCells[0] count];
    
    [super createCells];
    for (int i = 0; i < rowCount; i++)
    {
        NSArray *rowViews = matrViews[i];
        NSArray *rowCells = matrCells[i];
        for (int j = 0; j < colCount; j++)
        {
            NSInteger color = [rowCells[j] intValue];
            UIView *v = rowViews[j];
            v.backgroundColor = jcDescription.colorMatr[color];
        }
    }
}

- (void)loadCellsWithCellSize:(CGSize)cellSize
{
    [self loadCells];
    [self reloadSizesWithCellSize:cellSize];
}

- (void)createCells
{
    [super createCells];
    
    matrCells = [[NSMutableArray alloc] initWithCapacity:rowCount];
    jcSolution.matrCells = matrCells;
    
    for (int i = 0; i < rowCount; i++)
    {
        NSMutableArray *rowCells = [[NSMutableArray alloc] initWithCapacity:colCount];
        for (int j = 0; j < colCount; j++)
        {
            [rowCells addObject:@(0)];
        }
        [matrCells addObject:rowCells];
    }
    
    [jcDescription.leftMatr removeAllObjects];
    [jcDescription.topMatr removeAllObjects];
    
    for (int i = 0; i < rowCount; i++)
    {
        [jcDescription.leftMatr addObject:[NSMutableArray array]];
    }
    for (int i = 0; i < colCount; i++)
    {
        [jcDescription.topMatr addObject:[NSMutableArray array]];
    }

}

- (void)refreshDescriptionForRow:(NSInteger)row col:(NSInteger)col
{
    NSMutableArray *rowLines = [NSMutableArray array];
    NSArray *rowCells = matrCells[row];
    JCLine *line = nil;
    for (int i = 0; i < colCount; i++)
    {
        if ([rowCells[i] intValue] > 0)
        {
            if (line == nil || line.color != [rowCells[i] intValue])
            {
                line = [[[JCLine alloc] init] autorelease];
                line.color = [rowCells[i] intValue];
                line.length = 1;
                [rowLines addObject:line];
            }
            else
                line.length++;
        }
        else
            line = nil;
    }
    
    line = nil;
    NSMutableArray *colLines = [NSMutableArray array];
    for (int i = 0; i < rowCount; i++)
    {
        rowCells = matrCells[i];
        if ([rowCells[col] intValue] > 0)
        {
            if (line == nil || line.color != [rowCells[col] intValue])
            {
                line = [[[JCLine alloc] init] autorelease];
                line.color = [rowCells[col] intValue];
                line.length = 1;
                [colLines addObject:line];
            }
            else
                line.length++;
        }
        else
            line = nil;
    }
    
    jcDescription.leftMatr[row] = rowLines;
    jcDescription.topMatr[col] = colLines;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    for (int i = 0; i < matrViews.count; i++)
    {
        NSArray *rowViews = matrViews[i];
        UIView *first = rowViews[0];
        if (CGRectGetMinY(first.frame) <= point.y && CGRectGetMaxY(first.frame) >= point.y)
        {
            for (int j = 0; j < rowViews.count; j++)
            {
                UIView *v = rowViews[j];
                if (CGRectGetMinX(v.frame) <= point.x && CGRectGetMaxX(v.frame) >= point.x)
                {
                    v.backgroundColor = jcDescription.colorMatr[currentColor];
                    matrCells[i][j] = @(currentColor);
                    [self refreshDescriptionForRow:i col:j];
                    [delegate jcCenterViewDidSelectCell:self
                                                   cell:v
                                                    row:i
                                                    col:j];
                    break;
                }
            }
            break;
        }
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self touchesBegan:touches withEvent:event];
}



@end
