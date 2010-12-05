//
//  MEXImageTools.h
//  StoreSizer
//
//  Created by Eduardo Almeida on 10/12/05.
//  Copyright 2010 MegaEduX.com. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface MEXImageTools : NSObject {

}

+ (NSImage *)imageWithImage:(NSImage *)sourceImage scaledToSize:(CGSize)size;
+ (void)savePNGImage:(NSImage *)image toPath:(NSURL *)outURL;

@end
