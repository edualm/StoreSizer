//
//  MEXController.h
//  StoreSizer
//
//  Created by Eduardo Almeida on 10/12/05.
//  Copyright 2010 MegaEduX.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ImageDragView.h"
#import "MEXImageTools.h"

@interface MEXController : NSObject <NSApplicationDelegate, NSWindowDelegate> {
	NSWindow *window;
	IBOutlet NSButton *normalCbox;
	IBOutlet NSButton *retinaCbox;
	IBOutlet NSButton *ipadCbox;
	IBOutlet ImageDragView *imageView;
	NSURL *selectedDirectory;
}

- (IBAction)saveFileDialog:(id)sender;
- (IBAction)generateTheIcons:(id)sender;

@property (assign) IBOutlet NSWindow *window;

@end
