//
//  MEXImageTools.m
//  StoreSizer
//
//  Created by Eduardo Almeida on 10/12/05.
//  Copyright 2010 MegaEduX.com. All rights reserved.
//

#import "MEXImageTools.h"

@implementation MEXImageTools

+ (NSImage *)imageWithImage:(NSImage *)sourceImage scaledToSize:(CGSize)finalSize {
	NSImage *resizedImage = [[NSImage alloc] initWithSize: NSMakeSize(finalSize.width, finalSize.height)];
	NSSize originalSize = [sourceImage size];
	
	[resizedImage lockFocus];
	[sourceImage drawInRect: NSMakeRect(0, 0, finalSize.width, finalSize.height) fromRect: NSMakeRect(0, 0, originalSize.width, originalSize.height) operation: NSCompositeSourceOver fraction: 1.0];
	[resizedImage unlockFocus];
	
	return resizedImage;
}

+ (void)savePNGImage:(NSImage *)image toPath:(NSURL *)outURL {
	CGImageSourceRef source;
	
	source = CGImageSourceCreateWithData((CFDataRef)[image TIFFRepresentation], NULL);
	CGImageRef imageRef = CGImageSourceCreateImageAtIndex(source, 0, NULL);
	
	CGImageDestinationRef dr = CGImageDestinationCreateWithURL ((CFURLRef)outURL, (CFStringRef)@"public.png" , 1, NULL);
	CGImageDestinationAddImage(dr, imageRef, NULL);
	CGImageDestinationFinalize(dr);
}

@end
