//
//  ViewController.m
//  JapanCrosswords
//
//  Created by Alexander Naumenko on 10.04.13.
//  Copyright (c) 2013 Alexander Naumenko. All rights reserved.
//

#import "ViewController.h"
#import "JCMakeViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //[self.navigationController setNavigationBarHidden:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnCreate_Click:(id)sender
{
    JCMakeViewController *jcMake = [[JCMakeViewController alloc] init];
    [self.navigationController pushViewController:jcMake animated:YES];
}

@end
