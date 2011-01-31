//
//  MandelbrotView.m
//  iMandelbrot
//
//  Created by Damien DeVille on 1/14/11.
//  Copyright 2011 Snappy Code. All rights reserved.
//

#import "MandelbrotView.h"

#define MANDELBROT_STEPS	50

// C function
BOOL isInMandelbrotSet(float re, float im) ;

@implementation MandelbrotView

- (id)initWithCoder:(NSCoder *)aDecoder
{
	self = [super initWithCoder: aDecoder] ;
	if (self)
	{
		NSDate *time = [NSDate date] ;
		
		// instantiate the bitmap context
		bitmapContext = [self createCustomBitmapContextWithSize: CGSizeMake(480.0f, 320.0f)] ;
		
		NSLog(@"bitmap context creation duration = %f", [[NSDate date] timeIntervalSinceDate: time]) ;
		
		time = [NSDate date] ;
		
		// draw the Mandelbrot Set
		CGPoint center = CGPointMake(self.center.y, self.center.x) ;
		[self drawMandelbrot: center andZoom: 1] ;
		
		NSLog(@"drawing mandelbrot in bitmap duration = %f", [[NSDate date] timeIntervalSinceDate: time]) ;
	}
	
	return self ;
}

- (void)dealloc
{
	// release the bitmap context
	CGContextRelease(bitmapContext) ;
	
	// free the bitmap data
	free(bitmapData) ;
	
	[super dealloc] ;
}

- (void)drawRect:(CGRect)rect
{
	NSDate *now = [NSDate date] ;
	
	// get the current context
	CGContextRef context = UIGraphicsGetCurrentContext() ;
	
	// get an image representation of the bitmap context
	CGImageRef myImage = CGBitmapContextCreateImage(bitmapContext) ;
	
	// draw the image in the current context
	CGContextDrawImage(context, rect, myImage) ;
	
	// release the image
	CGImageRelease(myImage) ;
	
	NSLog(@"draw rect duration = %f", [[NSDate date] timeIntervalSinceDate: now]) ;
}

- (CGContextRef)createCustomBitmapContextWithSize:(CGSize)size
{
	CGContextRef context = NULL ;
	
	int bitmapBytesPerRow = (size.width * 4) ;
	bitmapBytesPerRow += (16 - bitmapBytesPerRow%16)%16 ;
	
	size_t bitmapByteCount = (bitmapBytesPerRow * size.height) ;
	
	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB() ;
	
	bitmapData = malloc(bitmapByteCount) ;
	
	if (bitmapData == NULL)
	{
		fprintf (stderr, "Memory not allocated!") ;
		return NULL ;
    }
	
	context = CGBitmapContextCreate(bitmapData, size.width, size.height, 8, bitmapBytesPerRow, colorSpace, kCGImageAlphaPremultipliedLast) ;
	
	if (context == NULL)
	{
		free (bitmapData) ;
		bitmapData = NULL ;
		fprintf (stderr, "Context not created!") ;
		return NULL ;
	}
	
	CGColorSpaceRelease(colorSpace) ;
	
	return context ;
}

BOOL isInMandelbrotSet(float re, float im)
{
	float x = 0 ;	float nx ;
	float y = 0 ;	float ny ;
	bool fl = TRUE ;
	for(int i = 0 ; i < MANDELBROT_STEPS ; i++)
	{
		// We calculate the real part of the sequence
		nx = x*x - y*y + re ;
		// We calculate the imaginary part of the sequence
		ny = 2*x*y + im ;
		// We compute the magnitude at each step
		// We check if it's greater than 2
		if((nx*nx + ny*ny) > 4)
		{
			fl = FALSE ;
			break ;
		}
		x = nx ;
		y = ny ;
	}
	
	return fl ;
}

- (void)drawMandelbrot:(CGPoint)center andZoom:(CGFloat)zoom
{
	CGContextSetAllowsAntialiasing(bitmapContext, FALSE) ;
	
	CGContextSetRGBFillColor(bitmapContext, 0.0f, 0.0f, 0.0f, 1.0f) ;
	
	CGFloat re ;
	CGFloat im ;
	
	// mapping the bounding box to pixels
	
	/*
		zoom 1 has to be between -2 to 1 and -1 to 1
		any additional zoom divides these by the zoom
	 */
	
	// loop through every pixel of the frame...
	for (int i = 0 ; i < 480 ; i++)
	{
		for (int j = 0 ; j < 320 ; j++)
		{
			re = (((CGFloat)i - 1.33f * center.x)/160) ;	// -2 to 1	-	screen width  = 480
			im = (((CGFloat)j - 1.00f * center.y)/160) ;	// -1 to 1	-	screen height = 320
			
			re /= zoom ;
			im /= zoom ;
			
			if (isInMandelbrotSet(re, im))
			{
				CGContextFillRect (bitmapContext, CGRectMake(i, j, 1.0f, 1.0f)) ;
			}
		}
	}
}

@end
