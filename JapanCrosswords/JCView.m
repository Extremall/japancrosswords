//
//  JCView.m
//  JapanCrosswords
//
//  Created by Alexander Naumenko on 10.04.13.
//  Copyright (c) 2013 Alexander Naumenko. All rights reserved.
//

#import "JCView.h"

#define kNumberInBlock  5

@implementation JCView

@synthesize rowCount;
@synthesize colCount;
@synthesize insets;
@synthesize cellsDistance;
@synthesize blocksDistance;
@synthesize currentColor;
@synthesize jcDescription;

- (void)defaults
{
    rowCount = 5;
    colCount = 5;
    cellsDistance = 1;
    blocksDistance = 3;
    insets = UIEdgeInsetsMake(2, 2, 2, 2);
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        NSLog(@"initWithFrame");
        [self defaults];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Initialization code
        NSLog(@"initWithCoder");
        [self defaults];
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code
        NSLog(@"init");
        [self defaults];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    NSLog(@"awakeFromNib");
}

- (void)dealloc
{
    [matrViews release];
    [super dealloc];
}

- (UIView *)createCellView
{
    return [[UIView alloc] init];
}

- (void)createCells
{
    [self removeCells];
    matrViews = [[NSMutableArray alloc] initWithCapacity:rowCount];
    
    int blocksW = colCount / kNumberInBlock + (colCount % kNumberInBlock == 0 ? 0 : 1);
    int blocksH = rowCount / kNumberInBlock + (rowCount % kNumberInBlock == 0 ? 0 : 1);;
    float cellW = (self.frame.size.width - (blocksW - 1) * (blocksDistance - cellsDistance) - (colCount - 1) * cellsDistance - insets.left - insets.right) / colCount;
    float cellH = (self.frame.size.height - (blocksH - 1) * (blocksDistance - cellsDistance) - (rowCount - 1) * cellsDistance - insets.bottom - insets.top) / rowCount;
    
    for (int i = 0; i < rowCount; i++)
    {
        NSMutableArray *rowViews = [[NSMutableArray alloc] initWithCapacity:colCount];
        for (int j = 0; j < colCount; j++)
        {
            UIView *v = [self createCellView];
            v.userInteractionEnabled = NO;
            int blockX = j / kNumberInBlock;
            int blockY = i / kNumberInBlock;
            float x = insets.left + j * (cellsDistance + cellW) + blockX * (blocksDistance - cellsDistance);
            float y = insets.top + i * (cellsDistance + cellH) + blockY * (blocksDistance - cellsDistance);
            CGRect rect = CGRectMake(x, y, cellW, cellH);
            v.frame = rect;
            v.backgroundColor = jcDescription.colorMatr[0];
            [self addSubview:v];
            [rowViews addObject:v];
            v.tag = i * colCount + j;
        }
        [matrViews addObject:rowViews];
        [rowViews release];
    }
}

- (void)createCellsWithCellSize:(CGSize)cellSize
{
    [self createCells];
    [self reloadSizesWithCellSize:cellSize];
}

- (void)removeCells
{
    for (int i = 0; i < [matrViews count]; i++)
    {
        NSMutableArray *rowViews = matrViews[i];
        for (int j = 0; j < [rowViews count]; j++)
        {
            UIView *v = rowViews[j];
            [v removeFromSuperview];
        }
    }
    [matrViews release];
    matrViews = nil;
}

- (void)reloadCells
{
    [self removeCells];
    [self createCells];
}

- (void)reloadCellsWithCellSize:(CGSize)cellSize
{
    [self removeCells];
    [self createCellsWithCellSize:cellSize];
}

- (void)reloadSizesWithCellSize:(CGSize)cellSize
{
    int blocksW = colCount / kNumberInBlock + (colCount % kNumberInBlock == 0 ? 0 : 1);
    int blocksH = rowCount / kNumberInBlock + (rowCount % kNumberInBlock == 0 ? 0 : 1);
    
    CGSize size;
    size.width = cellSize.width * colCount + (blocksW - 1) * (blocksDistance - cellsDistance) + (colCount - 1) * cellsDistance + insets.left + insets.right;
    size.height = cellSize.height * rowCount + (blocksH - 1) * (blocksDistance - cellsDistance) + (rowCount - 1) * cellsDistance + insets.top + insets.bottom;
    
    self.frame = CGRectMake(self.frame.origin.x,
                            self.frame.origin.y,
                            size.width,
                            size.height);
    
    [self reloadSizes];
}

- (void)reloadSizes
{
    int blocksW = colCount / kNumberInBlock + (colCount % kNumberInBlock == 0 ? 0 : 1);
    int blocksH = rowCount / kNumberInBlock + (rowCount % kNumberInBlock == 0 ? 0 : 1);
    float cellW = (self.frame.size.width - (blocksW - 1) * (blocksDistance - cellsDistance) - (colCount - 1) * cellsDistance - insets.left - insets.right) / colCount;
    float cellH = (self.frame.size.height - (blocksH - 1) * (blocksDistance - cellsDistance) - (rowCount - 1) * cellsDistance - insets.top - insets.bottom) / rowCount;
    
    for (int i = 0; i < rowCount; i++)
    {
        NSMutableArray *rowViews = [matrViews objectAtIndex:i];
        for (int j = 0; j < colCount; j++)
        {
            UIView *v = [rowViews objectAtIndex:j];
            v.userInteractionEnabled = NO;
            int blockX = j / kNumberInBlock;
            int blockY = i / kNumberInBlock;
            float x = insets.left + j * (cellsDistance + cellW) + blockX * (blocksDistance - cellsDistance);
            float y = insets.top + i * (cellsDistance + cellH) + blockY * (blocksDistance - cellsDistance);
            CGRect rect = CGRectMake(x, y, cellW, cellH);
            v.frame = rect;
            v.tag = i * colCount + j;
        }
    }
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    //[self reloadSizes];
}

@end
