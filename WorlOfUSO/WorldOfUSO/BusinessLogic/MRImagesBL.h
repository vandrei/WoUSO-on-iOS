//
//  MRImagesBL.h
//  WorldOfUSO
//
//  Created by Andrei Vasilescu on 9/26/14.
//  Copyright (c) 2014 mReady. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MRImagesBL : NSObject

- (void)requestImageForURL:(NSString *)imgUrl
               withSuccess:(void (^)(UIImage *img))success
                andFailure:(void (^)(NSError *err))failure;

@end
