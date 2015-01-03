//
//  JCSideView.m
//  JapanCrosswords
//
//  Created by Alexander Naumenko on 11.04.13.
//  Copyright (c) 2013 Alexander Naumenko. All rights reserved.
//

#import "JCSideView.h"

@implementation JCSideView

@synthesize sideViewType;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (UIView *)createCellView
{
    UIView *v = [[UIView alloc] init];
    v.frame = CGRectMake(0, 0, 1, 1);
    UILabel *lbl = [[UILabel alloc] init];
    lbl.frame = v.frame;
    lbl.text = @"";
    lbl.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    lbl.backgroundColor = [UIColor clearColor];
    lbl.textAlignment = NSTextAlignmentCenter;
    [v addSubview:lbl];
    [lbl release];
    lbl.tag = kLabelSideCellTag;
    return v;
}

- (UIColor *)invertColor:(UIColor *)color
{
    CGFloat r;
    CGFloat g;
    CGFloat b;
    [color getRed:&r green:&g blue:&b alpha:nil];
    return [UIColor colorWithRed:1.0 - r
                           green:1.0 - g
                            blue:1.0 - b
                           alpha:1.0];
}

- (void)refreshDescriptionForRow:(NSInteger)row col:(NSInteger)col
{
    if (sideViewType == JCSideViewTypeLeft)
    {
        NSArray *rowLines = jcDescription.leftMatr[row];
        NSArray *rowCells = matrViews[row];
        for (int i = 0; i < [rowCells count] - [rowLines count]; i++)
        {
            UIView *v = rowCells[i];
            ((UILabel *)[v viewWithTag:kLabelSideCellTag]).text = @"";
            v.backgroundColor = jcDescription.colorMatr[0];
        }
        for (int i = 0; i < [rowLines count]; i++)
        {
            JCLine *line = [rowLines objectAtIndex:i];
            int c = [rowCells count] - [rowLines count] + i;
            UIView *v = rowCells[c];
            UILabel *lbl = ((UILabel *)[v viewWithTag:kLabelSideCellTag]);
            lbl.text = [NSString stringWithFormat:@"%d", line.length];
            v.backgroundColor = jcDescription.colorMatr[line.color];
            lbl.textColor = [self invertColor:v.backgroundColor];
        }
    }
    else
    {
        NSArray *rowCells;
        NSArray *colLines = jcDescription.topMatr[col];
        for (int i = 0; i < [matrViews count] - [colLines count]; i++)
        {
            rowCells = matrViews[i];
            UIView *v = rowCells[col];
            ((UILabel *)[v viewWithTag:kLabelSideCellTag]).text = @"";
            v.backgroundColor = jcDescription.colorMatr[0];
        }
        for (int i = 0; i < [colLines count]; i++)
        {
            JCLine *line = colLines[i];
            int r = [matrViews count] - [colLines count] + i;
            rowCells = matrViews[r];
            UIView *v = rowCells[col];
            UILabel *lbl = ((UILabel *)[v viewWithTag:kLabelSideCellTag]);
            lbl.text = [NSString stringWithFormat:@"%d", line.length];
            v.backgroundColor = jcDescription.colorMatr[line.color];
            lbl.textColor = [self invertColor:v.backgroundColor];
        }
    }
}

- (void)refreshDescription
{
    if (sideViewType == JCSideViewTypeLeft)
    {
        for (int i = 0; i < [jcDescription.leftMatr count]; i++)
            [self refreshDescriptionForRow:i col:0];
    }
    else
    {
        for (int i = 0; i < [jcDescription.topMatr count]; i++)
            [self refreshDescriptionForRow:0 col:i];
    }
}

@end
