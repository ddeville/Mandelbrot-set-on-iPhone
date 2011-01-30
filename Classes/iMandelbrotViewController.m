//
//  iMandelbrotViewController.m
//  iMandelbrot
//
//  Created by Damien DeVille on 1/14/11.
//  Copyright 2011 Snappy Code. All rights reserved.
//

#import "iMandelbrotViewController.h"

@implementation iMandelbrotViewController

- (void)dealloc
{
	[super dealloc] ;
}

- (void)viewDidLoad
{
	[super viewDidLoad] ;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return (interfaceOrientation ==  UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight) ;
}

- (void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning] ;
}

- (void)viewDidUnload
{
	
}

@end
