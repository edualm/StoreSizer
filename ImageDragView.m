//
//  ImageDragView.m
//
//  Created by Eduardo Almeida on 10/12/05.
//  Copyright 2010 MegaEduX.com. All rights reserved.
//
//  This class is mostly code taken from http://cocoadevcentral.com/articles/000056.php
//

#import "ImageDragView.h"
#import "MEXImageTools.h"

@implementation ImageDragView

- (NSDragOperation)draggingEntered:(id <NSDraggingInfo>)sender {
    if ((NSDragOperationGeneric & [sender draggingSourceOperationMask]) == NSDragOperationGeneric) {
        return NSDragOperationGeneric;
    } else {
        return NSDragOperationNone;
    }
}

- (void)draggingExited:(id <NSDraggingInfo>)sender {
    // Nothing to see here.
}

- (NSDragOperation)draggingUpdated:(id <NSDraggingInfo>)sender {
    if ((NSDragOperationGeneric & [sender draggingSourceOperationMask]) == NSDragOperationGeneric) {
        return NSDragOperationGeneric;
    } else {
        return NSDragOperationNone;
    }
}

- (void)draggingEnded:(id <NSDraggingInfo>)sender {
    // Nothing to see here.
}

- (BOOL)prepareForDragOperation:(id <NSDraggingInfo>)sender {
    return YES;
}

- (BOOL)performDragOperation:(id <NSDraggingInfo>)sender {
    NSPasteboard *paste = [sender draggingPasteboard];
    NSArray *types = [NSArray arrayWithObjects:NSTIFFPboardType, 
					  NSFilenamesPboardType, nil];
    NSString *desiredType = [paste availableTypeFromArray:types];
    NSData *carriedData = [paste dataForType:desiredType];
	
    if (nil == carriedData) {
        NSRunAlertPanel(@"Paste Error", @"Sorry, but the past operation failed", nil, nil, nil);
        return NO;
    } else {
        if ([desiredType isEqualToString:NSTIFFPboardType]) {
            NSImage *newImage = [[NSImage alloc] initWithData:carriedData];
            [self setImage:newImage];
            [newImage release];    
        } else if ([desiredType isEqualToString:NSFilenamesPboardType]) {
            NSArray *fileArray = [paste propertyListForType:@"NSFilenamesPboardType"];
            NSString *path = [fileArray objectAtIndex:0];
            NSImage *newImage = [[NSImage alloc] initWithContentsOfFile:path];
			
            if (nil == newImage) {
                NSRunAlertPanel(@"File Reading Error", [NSString stringWithFormat:@"The file you dropped (\"%@\") can't be used with this application.", path], nil, nil, nil);
                return NO;
            } else {
                [self setImage:newImage];
            }
            [newImage release];
        } else {
            NSAssert(NO, @"This can't happen");
            return NO;
        }
    }
    [self setNeedsDisplay:YES];
    return YES;
}

- (void)concludeDragOperation:(id <NSDraggingInfo>)sender {
    [self setNeedsDisplay:YES];
}

- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    [self registerForDraggedTypes:[NSArray arrayWithObjects:NSTIFFPboardType, 
								   NSFilenamesPboardType, nil]];
    return self;
}

- (void)dealloc {
    [self unregisterDraggedTypes];
    [super dealloc];
}

- (void)drawRect:(NSRect)rect {
    NSRect ourBounds = [self bounds];
    NSImage *image = [self image];
	CGSize size;
	size.width = 157;
	size.height = 157;
	NSImage *newImage = [MEXImageTools imageWithImage:image scaledToSize:size];
	
    [super drawRect:rect];
    [newImage compositeToPoint:(ourBounds.origin) operation:NSCompositeSourceOver];
}

- (void)setImage:(NSImage *)newImage {
    NSImage *temp = [newImage retain];
    theImage = temp;
	[theImage retain];
}

- (NSImage *)image {
    return theImage;
}

@end
