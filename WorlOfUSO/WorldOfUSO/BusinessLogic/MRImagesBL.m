//
//  MRImagesBL.m
//  WorldOfUSO
//
//  Created by Andrei Vasilescu on 9/26/14.
//  Copyright (c) 2014 mReady. All rights reserved.
//

#import "MRImagesBL.h"

#import "MRApiHelper.h"

@implementation MRImagesBL

- (void)requestImageForURL:(NSString *)imgUrl
               withSuccess:(void (^)(UIImage *img))success
                andFailure:(void (^)(NSError *err))failure {
    UIImage *img = [self loadCachedImage:imgUrl];
    
    if (img == nil) {
        [[MRApiHelper new] requestImage:imgUrl withSuccess:success andFailure:failure];
    } else {
        success(img);
    }
}

- (UIImage *)loadCachedImage:(NSString *)imgName
{
    if (imgName == nil)
        return nil;
    NSRange range = [imgName rangeOfString:@"?"];
    NSString * filename;
    if (range.location != NSNotFound)
        filename = [imgName substringToIndex:range.location];
    else
        filename = imgName;
    range = [filename rangeOfString:@"/"];
    while(range.location != NSNotFound)
    {
        filename = [filename substringFromIndex:range.location + 1];
        range = [filename rangeOfString:@"/"];
    }
    NSString *uniquePath = [NSTemporaryDirectory() stringByAppendingPathComponent: filename];
    UIImage *image;
    if([[NSFileManager defaultManager] fileExistsAtPath: uniquePath])
    {
        image = [UIImage imageWithContentsOfFile: uniquePath]; // this is the cached image
    }
    
    return image;
}

- (void)cacheImage:(UIImage *)image name:(NSString*)imgName {
    if (imgName == nil)
        return;
    NSRange range = [imgName rangeOfString:@"?"];
    NSString * filename;
    if (range.location != NSNotFound)
        filename = [imgName substringToIndex:range.location];
    else
        filename = imgName;
    range = [filename rangeOfString:@"/"];
    while(range.location != NSNotFound)
    {
        filename = [filename substringFromIndex:range.location + 1];
        range = [filename rangeOfString:@"/"];
    }
    NSString *uniquePath = [NSTemporaryDirectory() stringByAppendingPathComponent: filename];
    if(![[NSFileManager defaultManager] fileExistsAtPath: uniquePath])
    {
        [UIImagePNGRepresentation(image) writeToFile: uniquePath atomically: YES];
    }
}
@end
