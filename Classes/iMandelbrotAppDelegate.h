//
//  iMandelbrotAppDelegate.h
//  iMandelbrot
//
//  Created by Damien DeVille on 1/14/11.
//  Copyright 2011 Snappy Code. All rights reserved.
//

#import <UIKit/UIKit.h>

@class iMandelbrotViewController;

@interface iMandelbrotAppDelegate : NSObject <UIApplicationDelegate>
{
	UIWindow *window ;
	iMandelbrotViewController *viewController ;
}

@property (nonatomic, retain) IBOutlet UIWindow *window ;
@property (nonatomic, retain) IBOutlet iMandelbrotViewController *viewController ;

@end

