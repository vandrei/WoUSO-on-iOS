//
//  MRApiBase.h
//  ActeAz
//
//  Created by Andrei Vaduva on 6/17/14.
//  Copyright (c) 2014 mReady. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MRApiBase : NSObject

@property (strong, nonatomic) NSString *baseURL;

- (void)doGETRequest:(NSString *)urlRequest parameters:(NSDictionary *)params
          success:(void (^)(id responseObject))success
          failure:(void (^)(NSError *error))failure;

- (void)doPOSTRequest:(NSString*)urlRequest parameters:(NSDictionary*)params
              success:(void (^)(id responseObject))success
              failure:(void (^)(NSError *error))failure;

- (void)requestImage:(NSString *)requestURL
         withSuccess:(void (^)(id responseObject))success
         andFailure:(void (^)(NSError *error))failure;

@end
