//
//  MEXController.m
//  StoreSizer
//
//  Created by Eduardo Almeida on 10/12/05.
//  Copyright 2010 MegaEduX.com. All rights reserved.
//

#import "MEXController.h"

@implementation MEXController

@synthesize window;

- (void)awakeFromNib {
	[NSApp setDelegate:self];
	[window setDelegate:self];
	[window registerForDraggedTypes:[NSArray arrayWithObjects:NSColorPboardType, NSFilenamesPboardType, nil]];
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)theApplication {
	return YES;
}

- (IBAction)saveFileDialog:(id)sender {
	NSOpenPanel *savePanel = [NSOpenPanel openPanel];
	[savePanel setCanCreateDirectories:YES];
	[savePanel setCanChooseDirectories:YES];
	[savePanel setCanChooseFiles:NO];
	[savePanel setPrompt:@"Select"];
	[savePanel setTitle:@"Select the directory to save the output images in"];
	int result = [savePanel runModal];
	if (result == NSOKButton) {
		selectedDirectory = [savePanel directoryURL];
		[selectedDirectory retain];
	}
}

- (IBAction)generateTheIcons:(id)sender {
	if ([imageView image] && selectedDirectory) {
		CGSize size;
		if ([normalCbox state] == NSOnState) {
			size.width = 57;
			size.height = 57;
			NSString *path = [NSString stringWithFormat:@"%@Icon.png", selectedDirectory];
			NSURL *url = [NSURL URLWithString:path];
			[MEXImageTools savePNGImage:[MEXImageTools imageWithImage:[imageView image] scaledToSize:size] toPath:url];
		}
		if ([retinaCbox state] == NSOnState) {
			size.width = 114;
			size.height = 114;
			NSString *path = [NSString stringWithFormat:@"%@Icon@2x.png", selectedDirectory];
			NSURL *url = [NSURL URLWithString:path];
			[MEXImageTools savePNGImage:[MEXImageTools imageWithImage:[imageView image] scaledToSize:size] toPath:url];
		}
		if ([ipadCbox state] == NSOnState) {
			size.width = 72;
			size.height = 72;
			NSString *path = [NSString stringWithFormat:@"%@Icon-iPad.png", selectedDirectory];
			NSURL *url = [NSURL URLWithString:path];
			[MEXImageTools savePNGImage:[MEXImageTools imageWithImage:[imageView image] scaledToSize:size] toPath:url];
		}
		NSRunAlertPanel(@"Done!", @"Your images have been created at the folder you specified.", 
						nil, nil, nil);
	} else {
		NSRunAlertPanel(@"What are you trying to do?!", @"Please complete all the steps before even trying to generate the images.", 
						nil, nil, nil);
	}
}

@end
