//
//  JCMakeViewController.m
//  JapanCrosswords
//
//  Created by Alexander Naumenko on 10.04.13.
//  Copyright (c) 2013 Alexander Naumenko. All rights reserved.
//

#import "JCMakeViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "JCResolver.h"

@interface JCMakeViewController ()

@end

@implementation JCMakeViewController

@synthesize jcCrossword;

- (NSString *)applicationDocumentsDirectory
{
	return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)syncViews
{
    //NSLog(@"zoom = %.2f", scrollView.zoomScale);
    float zoom = scrollView.zoomScale;
    if (zoom < scrollView.minimumZoomScale)
        zoom = scrollView.minimumZoomScale;
    if (zoom > scrollView.maximumZoomScale)
        zoom = scrollView.maximumZoomScale;
    
    jcvLeft.transform = jcvTop.transform = CGAffineTransformMakeScale(scrollView.zoomScale,
                                                                      scrollView.zoomScale);

    CGRect rect = jcvLeft.frame;
    rect.origin.y = -scrollView.contentOffset.y;
    rect.origin.x = -rect.size.width + svLeft.frame.size.width;
    jcvLeft.frame = rect;
    
    rect = jcvTop.frame;
    rect.origin.x = -scrollView.contentOffset.x;
    rect.origin.y = -rect.size.height + svTop.frame.size.height;
    jcvTop.frame = rect;
    
}

- (void)createNew
{
    jcv.colCount = 10;
    jcv.rowCount = 10;
    jcv.currentColor = 1;
    jcv.delegate = self;
    
    jcv.jcDescription = [[[JCDescription alloc] init] autorelease];
    jcvLeft.jcDescription = jcvTop.jcDescription = jcv.jcDescription;
    
    [jcv createCellsWithCellSize:CGSizeMake(20, 20)];
    
    [jcCrossword release];
    jcCrossword = [[JCCrossword alloc] init];
    jcCrossword.description = jcv.jcDescription;
    jcCrossword.solution = jcv.jcSolution;
    
    // Left and top description panels
    [self fillPanels];
}

- (void)load
{
    jcv.colCount = [jcCrossword.description.topMatr count];
    jcv.rowCount = [jcCrossword.description.leftMatr count];
    jcv.currentColor = 1;
    jcv.delegate = self;
    
    jcv.jcDescription = jcCrossword.description;
    jcv.jcSolution = jcCrossword.solution;
    
    jcvLeft.jcDescription = jcvTop.jcDescription = jcv.jcDescription;
    
    [jcv loadCellsWithCellSize:CGSizeMake(20, 20)];
    
    // Left and top description panels
    [self fillPanels];
    
    [jcvLeft refreshDescription];
    [jcvTop refreshDescription];
}


- (void)configureViews
{
    scrollView.contentSize = jcv.frame.size;
    
    scrollView.scrollEnabled = !swScroll.on;
    jcv.userInteractionEnabled = swScroll.on;
    
    jcvLeft.colCount = jcvTop.colCount = jcv.colCount;
    jcvLeft.rowCount = jcvTop.rowCount = jcv.rowCount;
    
    jcvLeft.frame = jcvTop.frame = jcv.frame;
}

- (void)fillPanels
{
    // Configuring views
    [self configureViews];
    
    [jcvLeft createCells];
    [jcvTop createCells];
    
    jcvLeft.sideViewType = JCSideViewTypeLeft;
    jcvTop.sideViewType = JCSideViewTypeTop;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (jcCrossword == nil)
        [self createNew];
    else
        [self load];
    
    // Synchronization
    [self syncViews];
    
    // Nav buttons
    UIButton *btnResolve = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btnResolve.frame = CGRectMake(0, 0, 70, 30);
    [btnResolve setTitle:@"Resolve" forState:UIControlStateNormal];
    [btnResolve addTarget:self action:@selector(btnResolve_Click) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barBtnResolve = [[UIBarButtonItem alloc] initWithCustomView:btnResolve];

    UIButton *btnSave = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btnSave.frame = CGRectMake(0, 0, 50, 30);
    [btnSave setTitle:@"Save" forState:UIControlStateNormal];
    [btnSave addTarget:self action:@selector(btnSave_Click) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barBtnSave = [[UIBarButtonItem alloc] initWithCustomView:btnSave];
    
    UIButton *btnOpen = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btnOpen.frame = CGRectMake(0, 0, 50, 30);
    [btnOpen setTitle:@"Open" forState:UIControlStateNormal];
    [btnOpen addTarget:self action:@selector(btnOpen_Click) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barBtnOpen = [[UIBarButtonItem alloc] initWithCustomView:btnOpen];
    
    self.navigationItem.rightBarButtonItems = @[barBtnResolve, barBtnSave, barBtnOpen];
}

- (void)btnResolve_Click
{
    JCResolver *resolver = [JCResolver new];
    NSArray *rows = [resolver resolveJCDescription:jcv.jcDescription];
    
    [JCResolver printMatr:rows];
}

- (void)btnSave_Click
{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:jcCrossword];
    NSString *path = [[self applicationDocumentsDirectory] stringByAppendingPathComponent:@"test.jc"];
    [data writeToFile:path atomically:YES];
}

- (void)btnOpen_Click
{
    [jcCrossword release];
    NSString *path = [[self applicationDocumentsDirectory] stringByAppendingPathComponent:@"test.jc"];
    jcCrossword = [[NSKeyedUnarchiver unarchiveObjectWithFile:path] retain];
    
    if (jcCrossword)
        [self load];
    else
        [self createNew];
    
    [self syncViews];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)swChange:(id)sender
{
    scrollView.scrollEnabled = !swScroll.on;
    jcv.userInteractionEnabled = swScroll.on;
}

#pragma mark - Touches

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.view];
    if (CGRectContainsPoint(sliderView.frame, point))
    {
        insideSlider = YES;
        startPoint = point;
    }
    else
        insideSlider = NO;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.view];
    if (insideSlider)
    {
        CGRect rect = sliderView.frame;
        
        rect.origin.x += point.x - startPoint.x;
        rect.origin.y += point.y - startPoint.y;
        if (rect.origin.x < 120)
            rect.origin.x = 120;
        if (rect.origin.y < 120)
            rect.origin.y = 120;
        if (rect.origin.x > 500)
            rect.origin.x = 500;
        if (rect.origin.y > 500)
            rect.origin.y = 500;
        point.x = rect.origin.x - sliderView.frame.origin.x + startPoint.x;
        point.y = rect.origin.y - sliderView.frame.origin.y + startPoint.y;
        sliderView.frame = rect;
        startPoint = point;
        
        CGPoint rightBottom = CGPointMake(CGRectGetMaxX(scrollView.frame),
                                          CGRectGetMaxY(scrollView.frame));
        CGPoint cursor = CGPointMake(CGRectGetMaxX(sliderView.frame),
                                     CGRectGetMaxY(sliderView.frame));
        
        CGSize contentSize = scrollView.contentSize;
        scrollView.frame = CGRectMake(cursor.x,
                                      cursor.y,
                                      rightBottom.x - cursor.x,
                                      rightBottom.y - cursor.y);
        scrollView.contentSize = contentSize;
        
        CGRect rectLeft = svLeft.frame;
        rectLeft.origin.y = scrollView.frame.origin.y;
        rectLeft.size.width = scrollView.frame.origin.x - svLeft.frame.origin.x;
        svLeft.frame = rectLeft;
        
        CGRect rectTop = svTop.frame;
        rectTop.origin.x = scrollView.frame.origin.x;
        rectTop.size.height = scrollView.frame.origin.y - svTop.frame.origin.y;
        svTop.frame = rectTop;
        
        [self syncViews];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self syncViews];
}

#pragma mark - Scroll View

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)_scrollView
{
    return jcv;
}

- (void)scrollViewDidZoom:(UIScrollView *)_scrollView
{
    [self syncViews];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self syncViews];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self syncViews];
}

#pragma mark - JCCenter view delegate

- (void)jcCenterViewDidSelectCell:(JCCenterView *)jcView cell:(UIView *)cell row:(NSInteger)row col:(NSInteger)col
{
    [jcvLeft refreshDescriptionForRow:row col:col];
    [jcvTop refreshDescriptionForRow:row col:col];
}

@end
