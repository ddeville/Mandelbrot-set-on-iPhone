//
//  MandelbrotView.h
//  iMandelbrot
//
//  Created by Damien DeVille on 1/14/11.
//  Copyright 2011 Snappy Code. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MandelbrotView : UIView
{
	void *bitmapData ;
	CGContextRef bitmapContext ;
}

- (void)drawMandelbrot:(CGPoint)center andZoom:(CGFloat)zoom ;
- (CGContextRef)createCustomBitmapContextWithSize:(CGSize)size ;

@end
