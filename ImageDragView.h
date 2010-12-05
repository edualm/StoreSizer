//
//  ImageDragView.h
//
//  Created by Eduardo Almeida on 10/12/05.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//
//  This class is mostly code taken from http://cocoadevcentral.com/articles/000056.php
//

#import <Cocoa/Cocoa.h>

@interface ImageDragView : NSView {
	NSImage *theImage;
	NSURL *selectedDirectory;
}

- (void)setImage:(NSImage *)newImage;
- (NSImage *)image;

@end
